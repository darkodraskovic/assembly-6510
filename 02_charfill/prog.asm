        .import source "../include/constants.asm"

        .var    runstop =       $0103

        
BasicUpstart2(start)                    // inserts a basic sys-line to start your program

        *=$2000

start:
        lda     #black
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        lda     #violet
        sta     TEXT_COLOR
        jsr     CLR_SCR

        // print intro text
        ldx     #$00
introloop:      
        lda     introtxt,x              // load byte in A
        beq     charloop                // if .byte 0 loaded
        sta     SCREEN_MEM,x            // write char in screen mem
        inx
        jmp     introloop

        // get char input
charloop:       
        jsr     CHR_IN                  // call character input routine
        cmp     #$00                    // if character pressed, A holds char code, else 0
        beq     charloop

        cmp     #runstop
        beq     quit
        
        sec
        sbc     #$40                    // substract 64 from char code to get ASCII

        // fill screen with char
        ldx     #$00
scrloop:                                // x is in [0,255], screen has 40x25=1000 chars
        sta     SCREEN_MEM,x            
        sta     SCREEN_MEM+255,x        
        sta     SCREEN_MEM+(255*2),x    
        sta     SCREEN_MEM+(999-255),x  
        inx
        bne     scrloop
        jmp     charloop
        
quit:
        jsr     CLR_SCR
        rts

introtxt:       
        .text   "press keys or runstop to quit"
        .byte   0
