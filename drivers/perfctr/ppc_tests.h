/* $Id: ppc_tests.h,v 1.1 2004/06/01 08:45:11 fxzhang Exp $
 * Performance-monitoring counters driver.
 * Optional PPC32-specific init-time tests.
 *
 * Copyright (C) 2004  Mikael Pettersson
 */

#ifdef CONFIG_PERFCTR_INIT_TESTS
extern void perfctr_ppc_init_tests(void);
#else
#define perfctr_ppc_init_tests()
#endif
