/*
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/dma-mapping.h>
#include <linux/vmalloc.h>
#include <linux/interrupt.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>

#include <linux/sm501.h>
#include <linux/sm501_regs.h>

#include "sm501-ac97.h"
#include "sm501-pcm.h"
#include "sm501-u8051.h"


#define DRV_NAME                        "sm501-audio"

#ifdef DEBUG
#define dprintk(msg...) do { printk(KERN_DEBUG DRV_NAME ": " msg); } while (0)
#else
#define dprintk(msg...)
#endif

#ifndef NEW_BUFFER
#define NEW_BUFFER 1
#endif

static void do_audio_p_tasklet(unsigned long);
DECLARE_TASKLET(audio_p_tasklet,do_audio_p_tasklet,0);
static void do_audio_c_tasklet(unsigned long);
DECLARE_TASKLET(audio_c_tasklet,do_audio_c_tasklet,0);

struct sm501_runtime_data_father{
	struct sm501_runtime_data * play_data;
	struct sm501_runtime_data * capture_data;
};


struct sm501_runtime_data {
	spinlock_t lock;
	struct sm501_pcm_dma_params *params;
	struct snd_pcm_substream *psubstream;
	unsigned long ppointer; /* playback pointer in bytes */
	struct snd_pcm_substream *csubstream;
	unsigned long cpointer;	//capture buffer pointer in bytes
};

/*hardware definition */
static struct sm501_runtime_data_father * g_father = NULL;

static struct snd_pcm_hardware snd_sm501_playback_hw = {
	.info = (SNDRV_PCM_INFO_MMAP |
			SNDRV_PCM_INFO_INTERLEAVED |
			SNDRV_PCM_INFO_BLOCK_TRANSFER |
			SNDRV_PCM_INFO_MMAP_VALID |
			SNDRV_PCM_INFO_HALF_DUPLEX |
			SNDRV_PCM_INFO_BATCH),
	.formats =          SNDRV_PCM_FMTBIT_S16_LE,
	.rates =            SNDRV_PCM_RATE_48000, /*SNDRV_PCM_RATE_8000_48000,*/
	.rate_min =         48000, /* 8000,*/
	.rate_max =         48000,
	.channels_min =     2,
	.channels_max =     2,
	.buffer_bytes_max = SM501_AC97_P_PERIOD_SIZE * SM501_AC97_P_PERIOD_COUNT,
	.period_bytes_min = SM501_AC97_P_PERIOD_SIZE,
	.period_bytes_max = SM501_AC97_P_PERIOD_SIZE,
	.periods_min =      32,//change to 32 from 4
	.periods_max =      SM501_AC97_P_PERIOD_COUNT,
};


static struct snd_pcm_hardware snd_sm501_capture_hw = {
	.info = (SNDRV_PCM_INFO_MMAP |
			SNDRV_PCM_INFO_INTERLEAVED |
			SNDRV_PCM_INFO_BLOCK_TRANSFER |
			SNDRV_PCM_INFO_MMAP_VALID |
			SNDRV_PCM_INFO_HALF_DUPLEX |
			SNDRV_PCM_INFO_BATCH),
	.formats =          SNDRV_PCM_FMTBIT_S16_LE,
	.rates =            SNDRV_PCM_RATE_48000,
	.rate_min =         48000,
	.rate_max =         48000,
	.channels_min =     2,
	.channels_max =     2,
	.buffer_bytes_max = SM501_AC97_C_PERIOD_SIZE * SM501_AC97_C_PERIOD_COUNT,
	.period_bytes_min = SM501_AC97_C_PERIOD_SIZE,
	.period_bytes_max = SM501_AC97_C_PERIOD_SIZE,
	.periods_min =      32,//change to 32 from 4
	.periods_max =      SM501_AC97_C_PERIOD_COUNT,
};
static void snd_sm501_copy_pdata(struct sm501_runtime_data *);
static void snd_sm501_copy_cdata(struct sm501_runtime_data *);


static void do_audio_p_tasklet(unsigned long ptr)
{
	struct sm501_runtime_data * rtdata;
	rtdata = (struct sm501_runtime_data *)ptr;	
	snd_sm501_copy_pdata(rtdata);
}

static void do_audio_c_tasklet(unsigned long ptr)
{
	struct sm501_runtime_data * rtdata;
	rtdata = (struct sm501_runtime_data *)ptr;	
	snd_sm501_copy_cdata(rtdata);
}


/*
 * allocate a buffer via vmalloc_32().
 * called from hw_params
 * NOTE: this may be called not only once per pcm open!
*/
static int snd_sm501_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs,
					      size_t size)
{
	struct snd_pcm_runtime *runtime = subs->runtime;
	if (runtime->dma_area) {
		/* already allocated */
		if (runtime->dma_bytes >= size)
			return 0; /* already enough large */
		vfree(runtime->dma_area);
	}
	runtime->dma_area = vmalloc_32(size);
	if (! runtime->dma_area)
		return -ENOMEM;
	memset(runtime->dma_area, 0, size);
	runtime->dma_bytes = size;
	return 1; /* changed */
}

/*
 * free the buffer.
 * called from hw_free callback
 * NOTE: this may be called not only once per pcm open!
 */
static int snd_sm501_pcm_free_vmalloc_buffer(struct snd_pcm_substream *subs)
{
	struct snd_pcm_runtime *runtime = subs->runtime;
	if (runtime->dma_area) {
		vfree(runtime->dma_area);
		runtime->dma_area = NULL;
	}
	return 0;
}

/*
* Copy playback data into the hardware buffer
*/
#if 0
static void snd_sm501_copy_pdata(struct sm501_runtime_data *rtdata)
{
	u16  *phalfframe;
	u32  *pdest;
	u32  *pborder;
	struct snd_pcm_runtime *runtime;
	unsigned char status;

	if (rtdata->psubstream==NULL) {
		return;
	}

	runtime = rtdata->psubstream->runtime;

	if (runtime->dma_area == NULL) {
		return;
	}

	status = SmRead8(SRAM(buffer_status)) & 0x3;
	if (status==0x2)
		pdest = (u32*)rtdata->params->s->hw_buffer_addr + 192;
	else
		pdest = (u32*)rtdata->params->s->hw_buffer_addr;

	pborder = pdest + (SM501_AC97_P_PERIOD_SIZE / (sizeof(u32)));

	do {
		/* Sample format : */
		/* 32 ... 20 | 19 ... 4 | 3-0 */
		/* reserved  | 16b sampl| opt */
		
		/* Left */
		phalfframe = (u16 *) (runtime->dma_area + rtdata->ppointer);
		*pdest++ = (u32)*phalfframe << 4;
		phalfframe++;

		/* Right */
		*pdest++ = (u32)*phalfframe << 4;
		rtdata->ppointer += 4;
	} while (pdest < pborder);

	rtdata->ppointer %= (SM501_AC97_P_PERIOD_SIZE) * runtime->periods;

	snd_pcm_period_elapsed(rtdata->psubstream);

}
#endif

static void snd_sm501_copy_pdata(struct sm501_runtime_data *rtdata)
{
#if NEW_BUFFER == 0
	u16  *phalfframe;
	u32  *pdest;
	u32  *pborder;
#else
	const void * phalfframe;
	volatile void __iomem * pdest;
#endif
	
	struct snd_pcm_runtime *runtime;
	unsigned char status;

	if (rtdata->psubstream == NULL) {
		return;
	}

	runtime = rtdata->psubstream->runtime;

	if (runtime->dma_area == NULL) {
		return;
	}

	status = SmRead8(SRAM(buffer_status));
	
	if (status & 2)
		pdest = (u32*)rtdata->params->s->hw_buffer_addr + 255;//192
	else
		pdest = (u32*)rtdata->params->s->hw_buffer_addr;
	
#if NEW_BUFFER == 0
	pborder = pdest + (SM501_AC97_P_PERIOD_SIZE / (sizeof(u32)));

	do {				
		/* Sample format : */
		/* 32 ... 20   | 19 ... 4	   | 3-0 */
		/* reserved  | 16b sample| opt	*/
		
		phalfframe = (u16 *) (runtime->dma_area + rtdata->ppointer);		
		/* Left channel */
		*pdest++ = (u32)*phalfframe << 4;
		phalfframe++;
		/* Right channel*/
		*pdest++ = (u32)*phalfframe << 4;
		rtdata->ppointer += 4;
	} while (pdest < pborder);
#else
	phalfframe = (const void *)(runtime->dma_area + rtdata->ppointer);

	/* left and right channel transported together !! */
	memcpy_toio(pdest,phalfframe,SM501_AC97_P_PERIOD_SIZE);
	rtdata->ppointer += SM501_AC97_P_PERIOD_SIZE;	
#endif

	rtdata->ppointer %= (SM501_AC97_P_PERIOD_SIZE) * runtime->periods;

	snd_pcm_period_elapsed(rtdata->psubstream);

}


/*
 * Fill the playback buffers with audio data
 * Just the first 768 bytes
 */
static void snd_sm501_pfill(struct sm501_runtime_data *rtdata)
{
	u16 *phalfframe;
	u32 *pdest;
	u32 *pborder;
	struct snd_pcm_runtime *runtime;

#if NEW_BUFFER == 1
	snd_sm501_copy_pdata(rtdata);
	return;
#endif

	if (rtdata->psubstream==NULL) {
		return;
	}

	runtime = rtdata->psubstream->runtime;

	if (runtime->dma_area == NULL) {
		return;
	}

	phalfframe = (u16 *) (runtime->dma_area	+ frames_to_bytes(runtime, rtdata->ppointer));
	pdest = (u32*)rtdata->params->s->hw_buffer_addr;
	pborder = pdest + (SM501_AC97_P_PERIOD_SIZE / (sizeof(u32)));
	
#if 1
	do{
		phalfframe = (u16*)(runtime->dma_area + rtdata->ppointer);
		*pdest++ = (u32)((*phalfframe) << 4);
		rtdata->ppointer += 2;

		phalfframe = (u16*)(runtime->dma_area + rtdata->ppointer);
		*pdest++ = (u32)((*phalfframe) << 4);
		rtdata->ppointer += 2;
	}while(pdest < pborder);	
	
#else
	do {
		phalfframe = (u16 *) (runtime->dma_area + rtdata->ppointer);
		SmWrite32((unsigned long) pdest,*phalfframe  << 4);
		pdest++;
		rtdata->ppointer += 2;

		phalfframe = (u16 *) (runtime->dma_area + rtdata->ppointer);
		SmWrite32((unsigned long) pdest,*phalfframe << 4);
		pdest++;
		rtdata->ppointer += 2;
	} while (pdest < pborder);
#endif	
}

/*
 * Copy capture data into software buffer
 * This function can also be called as tasklet!
*/
static void snd_sm501_copy_cdata(struct sm501_runtime_data *rtdata)
{
#if NEW_BUFFER == 1
	void * phalfframe;
	const volatile void __iomem * psrc;
#else	
	volatile u16 *phalfframe;
	u32  *psrc;
	u32  *pborder;
#endif	
	struct snd_pcm_runtime *runtime;
	unsigned char status;

	if (rtdata->csubstream==NULL) {
		return;
	}

	runtime = rtdata->csubstream->runtime;

	if (runtime->dma_area == NULL) {
		return;
	}

	status = SmRead8(SRAM(buffer_status)) & 0x30;
	if (status == 0x20)
		psrc = (u32*)rtdata->params->s->hw_buffer_addr + 765;//from 576 to 765
	else
		psrc = (u32*)rtdata->params->s->hw_buffer_addr + 510;//from 384 to 510
#if NEW_BUFFER == 0
	pborder = psrc + (SM501_AC97_C_PERIOD_SIZE / (sizeof(u32)));
	do {
		/* Sample format : */
		/* 32 ... 20 | 19 ... 4 | 3-0 */
		/* reserved  | 16b sampl| opt */
		/* Left */
		phalfframe = (u16 *) (runtime->dma_area + rtdata->cpointer);
		//*phalfframe = (SmRead32((unsigned long) psrc) >> 4) & 0xffff;
		*phalfframe = (*psrc++)>>4;
		phalfframe++;

		/* Right */
		//*phalfframe = (SmRead32((unsigned long) psrc) >> 4) & 0xffff;
		*phalfframe =(*psrc++)>>4;
		rtdata->cpointer += 4;
	} while (psrc < pborder);
#else
	phalfframe = (void*)(runtime->dma_area + rtdata->cpointer);
	/* left and right channel transported together !! */
	memcpy_fromio(phalfframe,psrc,SM501_AC97_C_PERIOD_SIZE);
	rtdata->cpointer += SM501_AC97_C_PERIOD_SIZE;
#endif

	rtdata->cpointer %= (SM501_AC97_C_PERIOD_SIZE) * runtime->periods;

	snd_pcm_period_elapsed(rtdata->csubstream);
}

/* hw_params callback */
static int snd_sm501_pcm_hw_params(struct snd_pcm_substream *substream,
				   struct snd_pcm_hw_params * hw_params)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct sm501_runtime_data *rtdata = runtime->private_data;
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct sm501_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;


	if (rtdata->params == NULL) {
		rtdata->params = dma;
	}

	return snd_sm501_pcm_alloc_vmalloc_buffer(substream,
			params_buffer_bytes(hw_params));
}


/* hw_free callback */
static int snd_sm501_pcm_hw_free(struct snd_pcm_substream *substream)
{
	dprintk("pcm_hw_free\n");

	return snd_sm501_pcm_free_vmalloc_buffer(substream);
}


/* prepare callback */
static int snd_sm501_pcm_prepare(struct snd_pcm_substream *substream)
{
	struct sm501_runtime_data *rtdata = substream->runtime->private_data;

	dprintk("pcm_playback_prepare\n");
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK){
		rtdata->ppointer = 0;
	}
	else{
		rtdata->cpointer = 0;
	}

	return 0;
}
#if 1
static irqreturn_t snd_sm501_u8051_irq(int irq,void * dev_id)
{
	struct sm501_runtime_data_father * father = (struct sm501_runtime_data_father *)dev_id;
	u32 status,mask;
	
	status = SmRead32(INTERRUPT_STATUS);
	if(TEST_FIELD(status,INTERRUPT_STATUS_8051,NOT_ACTIVE))
		return IRQ_NONE;

	mask = SmRead32(INTERRUPT_MASK);
	SmWrite32(INTERRUPT_MASK,SET_FIELD(mask,INTERRUPT_MASK_8051,DISABLE));
	
	SmRead32(U8051_8051_PROTOCOL_INTERRUPT);
	
	status = SmRead8(SRAM(buffer_status));

	if(status & 0x03){
		if(father->play_data){
			audio_p_tasklet.data = (ulong)father->play_data;
			tasklet_hi_schedule(&audio_p_tasklet);
		}
	}

	if(status & 0x30){
		if(father->capture_data){
			audio_c_tasklet.data = (ulong)father->capture_data;
			tasklet_hi_schedule(&audio_c_tasklet);			
		}
	}

	mask = SmRead32(INTERRUPT_MASK);
	SmWrite32(INTERRUPT_MASK,SET_FIELD(mask,INTERRUPT_MASK_8051,ENABLE));
	return IRQ_HANDLED;
	
}

#else
static irqreturn_t snd_sm501_u8051_irq(int irq, void* dev_id)
{
	struct sm501_runtime_data *rtdata = (struct sm501_runtime_data *)dev_id;
	struct sm501_audio *s = rtdata->params->s;
	unsigned int status, mask;
	unsigned long flags;


	/* Read interrupt status. */
	status = SmRead32(INTERRUPT_STATUS);
	if (TEST_FIELD(status, INTERRUPT_STATUS_8051, NOT_ACTIVE))
		return IRQ_NONE;

	/* Reset 8051 interrupt status. */
	mask = SmRead32(INTERRUPT_MASK);
	SmWrite32(INTERRUPT_MASK, SET_FIELD(mask, INTERRUPT_MASK_8051, DISABLE));

	spin_lock_irqsave(&s->lock, flags);
	SmRead32(U8051_8051_PROTOCOL_INTERRUPT);

	/* Check 8051 buffer status. */
	status = SmRead8(SRAM(buffer_status));

	if (status != 0) {
		if (status & 0x0F) {	//playback buffer full
			snd_sm501_copy_pdata(rtdata);
		}
		if (status & 0xF0) {	//record buffer full
 			snd_sm501_copy_cdata(rtdata);
		}
	}

	spin_unlock_irqrestore(&s->lock, flags);
	mask = SmRead32(INTERRUPT_MASK);
	SmWrite32(INTERRUPT_MASK, SET_FIELD(mask, INTERRUPT_MASK_8051, ENABLE));

	return IRQ_HANDLED;
}
#endif


/* trigger callback */
static int snd_sm501_pcm_playback_trigger(struct snd_pcm_substream *substream,
					  int cmd)
{
	struct sm501_runtime_data *rtdata = substream->runtime->private_data;
	struct sm501_audio *s = rtdata->params->s;

	//printk("triggle for play\n");

	spin_lock(&s->lock);

	switch (cmd) {
		case SNDRV_PCM_TRIGGER_START:
			dprintk("pcm_playback_trigger: start\n");
			rtdata->psubstream = substream;
			snd_sm501_pfill(rtdata);
			//sm501_write_command(s, SET_PLAYBACK_BUFFER_READY, 3, 0);
			sm501_write_command(s, START_STOP_AUDIO_PLAYBACK, 1, 0);
			break;
		case SNDRV_PCM_TRIGGER_STOP:
			dprintk("pcm_playback_trigger: stop\n");
			sm501_write_command(s, START_STOP_AUDIO_PLAYBACK, 0, 0);
			rtdata->psubstream = NULL;
			break;
		default:
			dprintk("pcm_playback_trigger: default (%i)\n", cmd);
			return -EINVAL;
	}
	spin_unlock(&s->lock);

	return 0;
}
static int snd_sm501_pcm_capture_trigger(struct snd_pcm_substream *substream,
					 int cmd)
{
	struct sm501_runtime_data *rtdata = substream->runtime->private_data;
	struct sm501_audio *s = rtdata->params->s;
	printk("triggle for capture\n");

	spin_lock(&s->lock);

	switch (cmd) {
		case SNDRV_PCM_TRIGGER_START:
			sm501_write_command(s, SET_CAPTURE_BUFFER_EMPTY, 3, 0);
			dprintk("pcm_capture_trigger: start\n");
			rtdata->csubstream = substream;
			sm501_write_command(s, START_STOP_AUDIO_CAPTURE, 1, 0);
			break;
		case SNDRV_PCM_TRIGGER_STOP:
			dprintk("pcm_capture_trigger: stop\n");
			sm501_write_command(s, START_STOP_AUDIO_CAPTURE, 0, 0);
			rtdata->csubstream = NULL;
			break;
		default:
			dprintk("pcm_capture_trigger: default (%i)\n", cmd);
			return -EINVAL;
	}

	spin_unlock(&s->lock);

	return 0;
}

static int snd_sm501_pcm_trigger(struct snd_pcm_substream *substream,
					 int cmd)
{
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
		return snd_sm501_pcm_playback_trigger(substream, cmd);
	else
		return snd_sm501_pcm_capture_trigger(substream, cmd);

}
/* open callback */
static int snd_sm501_open(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct sm501_runtime_data *rtdata;
	struct sm501_audio *s = rtdata->params->s;
	int ret;

	rtdata = kzalloc(sizeof(struct sm501_runtime_data), GFP_KERNEL);
	if (rtdata == NULL)
		return -ENOMEM;

	//we do not need below lock initialized,because there is no use of it ...
//	spin_lock_init(&rtdata->lock);
	runtime->private_data = rtdata;
	
	
#if 0
		/* mute the record in */
		u16 rg;
		rg = soc_ac97_ops.read(NULL,AC97_MIC);
		soc_ac97_ops.write(NULL,AC97_MIC,rg|0x8000);
		
		rg = soc_ac97_ops.read(NULL,AC97_LINE);
		soc_ac97_ops.write(NULL,AC97_LINE,rg|0x8000); 
	
		/* setting codec */
#endif

	/* 	use global lock to prevent the simultaneous calling from 
		capture open and playback open
		we should use lock in every routine that access global resource 
		and with re-entrance attribuite for thorough safety
	*/
	spin_lock(&s->lock);

	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK){
		snd_soc_set_runtime_hwparams(substream, &snd_sm501_playback_hw);
		g_father->play_data = rtdata;
	}
	else{
		snd_soc_set_runtime_hwparams(substream, &snd_sm501_capture_hw);
		g_father->capture_data = rtdata;
	}

	spin_unlock(&s->lock);
	
	return 0;
}

static int snd_sm501_close(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct sm501_runtime_data *rtdata = runtime->private_data;
	struct sm501_audio *s = rtdata->params->s;

	dprintk("Entered %s\n", __FUNCTION__);

	if (rtdata)
	{
		kfree(rtdata);
		spin_lock(&s->lock);
		if(substream->stream == SNDRV_PCM_STREAM_PLAYBACK)			
			g_father->play_data = NULL;
		else
			g_father->capture_data = NULL;
		spin_unlock(&s->lock);
	}
	else
		printk("%s called with rtdata == NULL\n", __func__);

	return 0;
}

/* pointer callback */
static snd_pcm_uframes_t snd_sm501_pcm_pointer(struct snd_pcm_substream *substream)
{
	struct sm501_runtime_data *rtdata = substream->runtime->private_data;
	snd_pcm_uframes_t value = 0;

	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
		value = bytes_to_frames(substream->runtime, rtdata->ppointer);
	else
		value = bytes_to_frames(substream->runtime, rtdata->cpointer);
	return value;
}

/* get the physical page pointer on the given offset */
static struct page *snd_sm501_pcm_get_vmalloc_page(struct snd_pcm_substream *subs,
		unsigned long offset)
{
	void *pageptr = subs->runtime->dma_area + offset;

	return vmalloc_to_page(pageptr);
}


/* operators */
static struct snd_pcm_ops snd_sm501_ops = {
	.open =		snd_sm501_open,
	.close =	snd_sm501_close,
	.ioctl =	snd_pcm_lib_ioctl,
	.hw_params =	snd_sm501_pcm_hw_params,
	.hw_free =	snd_sm501_pcm_hw_free,
	.prepare =	snd_sm501_pcm_prepare,
	.trigger =	snd_sm501_pcm_trigger,
	.pointer =	snd_sm501_pcm_pointer,
	.page =		snd_sm501_pcm_get_vmalloc_page,
};

int sm501_pcm_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
	struct snd_pcm *pcm)
{
	int ret = 0;
	static int nt = 0;
	struct sm501_runtime_data_father * father;
	father = kzalloc(sizeof (*father),GFP_KERNEL);
	if(!father)
		return -ENOMEM;	
	g_father = father;
	request_irq(37, snd_sm501_u8051_irq,
				IRQF_SHARED | IRQF_DISABLED, "sm501-pcm", g_father);

	return ret;
}

static void sm501_pcm_free(struct snd_pcm *pcm)
{
	free_irq(37, g_father);
	if(g_father)
		kfree(g_father);
	
}

struct snd_soc_platform sm501_soc_platform = {
	.name		= "sm501-snd",
	.pcm_ops 	= &snd_sm501_ops,
	.pcm_new	= sm501_pcm_new,
	.pcm_free	= sm501_pcm_free,
};

EXPORT_SYMBOL_GPL(sm501_soc_platform);


MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
MODULE_DESCRIPTION("SM501 pcm module");
MODULE_LICENSE("GPL");
