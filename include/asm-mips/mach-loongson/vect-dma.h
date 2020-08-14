#ifndef _VECT_DMA_H
#define _VECT_DMA_H

#define VECT_DMA_REG_BASE 0xbfa00000

#define VECT_DMA_A1     0x10
#define VECT_DMA_A2     0x18
#define VECT_DMA_B1     0x20
#define VECT_DMA_B2     0x28
#define VECT_DMA_C1     0x50
#define VECT_DMA_C2     0x58
#define VECT_DMA_D1     0x40
#define VECT_DMA_D2     0x48

#define TUNNEL_WORK     (1<<63)

#define bc2f(cc, offset) \
        .word ((0x248 << 21) | (cc << 18) | (0 << 16) | (offset))

#endif
