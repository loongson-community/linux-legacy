#ifdef DEBUG26_PLX
#include <linux/pci.h>
#define XB_Down_Sem 0x90 //XB Downstream Configuration Ownership Semaphore Register ¨C Offset 90hbit 0
#define XB_Down_Sem 0x91 //XB Downstream Configuration Ownership Semaphore Register ¨C Offset 90hbit 0
#define Upstream_Message_0 0xA4 
#define Upstream_Message_1 0xA5 
#define Upstream_Message_2 0xA6 
#define Upstream_Message_3 0xA7 

#define Downstream_Message_0 0xA8 
#define Downstream_Message_1 0xA9 
#define Downstream_Message_2 0xAA 
#define Downstream_Message_3 0xAB 

#define TRUE 1
#define FALSE 0


/******************************************************************************
 *
 * Function   :  OnInterrupt
 *
 * Description:  The Interrupt Service Routine for the PLX device
 *
 ******************************************************************************/
void
OnInterrupt(
    int             irq,
    void           *dev_id,
    struct pt_regs *regs
    )
{
    unsigned int               TmpValue;
    unsigned int               RegEnable_DB;
    unsigned int               RegEnable_MSG;
    unsigned int               RegStatus;
    int           bInterrupt;
	struct pci_dev *plxdev;



    // Get the device extension
    plxdev = (struct pci_dev *)dev_id;

    // Assume no interrupt
    bInterrupt = FALSE;

    // Get interrupt enable
	pci_read_config_dword (
        plxdev,
        0xc4,
        &RegEnable_DB
        );

    pci_read_config_dword(
        plxdev,
        0xc8,
        &RegEnable_MSG
        );

    // Get interrupt status
    pci_read_config_dword(
        plxdev,
        0xcc,
        &RegStatus
        );

    // Check for doorbell interrupt
    TmpValue = (RegEnable_DB & 0xFFFF) & (RegStatus & 0xFFFF);

    if (TmpValue)
    {
        // Ignore active doorbell interrupt if still pending
        if ((RegEnable_DB >> 16) & TmpValue)
        {
            // Doorbell interrupt still pending, ignore it
        }
        else
        {
            // Clear active doorbell interrupts
            pci_write_config_dword(
                plxdev,
                0xcc,
                (RegStatus & 0xFF000000) | TmpValue
                );

            // Flag doorbell interrupt active
			printk("<0>doorbell interrupt active:RegStatus=%x\n",RegStatus);

            // Flag interrupt found
            bInterrupt = TRUE;
        }
    }

    // Check for message, S_RSTIN, S_PME, & GPIO interrupts
    TmpValue = (RegEnable_MSG >> 24) & ((RegStatus >> 16) & 0xFF);

    if (TmpValue & 0xFF)
    {
        if (TmpValue & 0xF)
        {
            // Flag message interrupt active
			printk("<0>message interrupt active,TmpValue=%x\n",TmpValue);
        }

        if (TmpValue & (1 << 4))
        {
            // Flag S_RSTIN de-assertion detected
			printk("<0>S_RSTIN de-assertion detected,TmpValue=%x\n",TmpValue);
        }

        if (TmpValue & (1 << 5))
        {
            // Flag S_PME de-assertion detected
			printk("<0>S_PME de-assertion detected,TmpValue=%x\n",TmpValue);
        }

        // GPIO14 interrupt
        if (TmpValue & (1 << 6))
        {
            // Interrupt active, must disable/mask since can't clear source
            RegEnable_MSG &= ~((1 << 6) << 24);

            pci_write_config_dword(
                plxdev,
                0xc8,
                (RegEnable_MSG & 0xFF000000)
                );

            // Flag GPIO14 interrupt active
			printk("<0>GPIO14 interrupt active,TmpValue=%x\n",TmpValue);
        }

        // GPIO4 interrupt
        if (TmpValue & (1 << 7))
        {
            // Interrupt active, must disable/mask since can't clear source
            RegEnable_MSG &= ~((1 << 7) << 24);

            pci_write_config_dword(
                plxdev,
                0xc8,
                (RegEnable_MSG & 0xFF000000)
                );

            // Flag GPIO4 interrupt active
			printk("<0>GPIO4 interrupt active,TmpValue=%x\n",TmpValue);
        }

        // Clear active interrupts
        pci_write_config_dword(
            plxdev,
            0xcc,
            (RegStatus & 0x00FF0000) | (TmpValue << 16)
            );

        // Flag interrupt found
        bInterrupt = TRUE;
    }
	return bInterrupt;
}

/*******************************************************************************
 *
 * Function   :  PlxChipPciInterruptEnable
 *
 * Description:  Enables the PLX Chip PCI Interrupt
 *
 ******************************************************************************/
int
PlxChipPciInterruptEnable(
struct pci_dev *plxdev
    )
{
    unsigned int RegValue;


    // Enable upstream doorbell interrupts
    pci_read_config_dword(
        plxdev,
        0xc4,
        &RegValue
        );

    RegValue |= 0xFFFF;

    pci_write_config_dword(
        plxdev,
        0xc4,
        RegValue
        );

    // Enable Message, S_RSTIN, S_PME, & GPIO interrupts
    pci_write_config_dword(
        plxdev,
        0xc8,
        0xFF000000
        );

    return TRUE;
}


/*******************************************************************************
 *
 * Function   :  PlxChipPciInterruptDisable
 *
 * Description:  Disables the PLX Chip PCI Interrupt
 *
 ******************************************************************************/
int
PlxChipPciInterruptDisable(
struct pci_dev *plxdev
    )
{
    unsigned int RegValue;


    // Disable upstream doorbell interrupts
    pci_read_config_dword(
        plxdev,
        0xc4,
        &RegValue
        );

    RegValue &= ~0xFFFF;

    pci_write_config_dword(
        plxdev,
        0xc4,
        RegValue
        );

    // Disable Message, S_RSTIN, S_PME, & GPIO interrupts
    pci_write_config_dword(
        plxdev,
        0xc8,
        0x00000000
        );

    return TRUE;
}

static int setup_plx()
{
struct pci_dev *plxdev;
int rc;
plxdev=pci_find_device(0x3388,0x21,0);
if(!plxdev) return-1;
rc = request_irq(
                plxdev->irq,    // The device IRQ
                OnInterrupt,             // Interrupt handler
                SA_SHIRQ,                // Flags, support interrupt sharing
                "plx",         // The driver name
                plxdev                      // Parameter to the ISR
                );
return rc;
}

static int plx_irqenable(int argc,char **argv)
{
struct pci_dev *plxdev;
unsigned int data;
if(argc!=2)return -1;
plxdev=pci_find_device(0x3388,0x21,0);
if(!plxdev){nr_printf("can not find plx device");return -1;}
if(argv[1][0]=='0')PlxChipPciInterruptDisable(plxdev);
if(argv[1][0]=='1')PlxChipPciInterruptEnable(plxdev);
}

mycmd_init(plx_irqen,plx_irqenable,"[0|1]","enable plx irq");
myinit_begin(setup_plx);
#endif
