        .import source "../include/constants.asm"

        .var    runstop =       $0103
        
BasicUpstart2(start)

        *=$2000

start:
        lda     #black
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        lda     #violet
        sta     TEXT_COLOR
        jsr     CLR_SCR
        
        ldx     #$00
introloop:      
        lda     introtxt,x
        beq     charloop        // if we hit .byte 0
        sta     SCREEN_MEM,x        // write char in screen mem
        inx
        jmp     introloop

charloop:       
        jsr     CHR_IN           // call character input routine
        cmp     #$00            // if character pressed A holds char code, else 0
        beq     charloop

        cmp     #runstop
        beq     quit
        
        sec
        sbc     #$40            // substract 64 from char code to get ASCII
        sta     SCREEN_MEM          // poke char in screen memory
        ldx     #$00
scrloop:        
        sta     SCREEN_MEM,x
        sta     SCREEN_MEM+255,x
        sta     SCREEN_MEM+(255*2),x
        sta     SCREEN_MEM+(999-255),x    // 999-255
        inx
        bne     scrloop
        jmp     charloop
quit:
        jsr     CLR_SCR
        rts

introtxt:       
        .text   "press keys or runstop to quit"
        .byte   0
