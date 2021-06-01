        .import source "../include/constants.asm"
        .import source "../include/utils.asm"
        
        BasicUpstart2(start)

        *=$1000
        
start:
        sei
        lda     1
        and     #251            // %0xx: Character ROM visible at $D000-$DFFF (except for the value %000)
        sta     1

        // copy first 256/8 chars from Character ROM area
        ldx     #0
char_init_loop:
        lda     VIC_BASE,x      // $D000-$DFFF shape of characters (4096 bytes)
        sta     $3000,x
        inx
        bne     char_init_loop

        lda     1
        ora     #4
        sta     1
        cli
        
        lda     #black
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        lda     #white
        sta     TEXT_COLOR
        jsr     CLR_SCR

        lda     GRAPHICS_POINTER 
        and     #240
        clc
        adc     #12
        sta     GRAPHICS_POINTER        // Bits #1-#3 %110, 6: $3000-$37FF^ 

        ldx     #40
char_print_loop:
        lda     #00
        dex
        sta     SCREEN_MEM,x
        bne     char_print_loop
        
        rts

        *=$3000
        // At start we copy Character ROM to $3000.
        // Instead, we can load a custom character map.
        // LOAD_HIRES_CHAR("chars_hires_map.gif", 4, 2)
