        .import source "../include/constants.asm"
        .import source "../include/utils.asm"

        .const  spraddr         =       200
        .const  spr0Fname =       "anim_hires_plane"
        .const  spr0NumFrames   = 4
        
        BasicUpstart2(irqinit)

        *=$1000

irqinit:
        sei                                     // set interrupt disable (disable interrupts)
        
        lda     #$7f                            
        sta     INTERRUPT_STA_CTRL              // Interrupt control and status register (Bit #7: Fill bit)

        lda     RASTER_SPRITE_INT_CTRL
        ora     #$01                            // Bit #0: 1 = Raster interrupt enabled.
        sta     RASTER_SPRITE_INT_CTRL
        SET_RASTER_LINE_INTERRUPT($7f,$00)
        SET_INTERRUPT_EXECUTION(irq1)

        cli                                     // clear interrupt disable (re-enable interrupts)
        
start:
        lda     #spraddr                // incr/decr this by 1 to animate
        sta     SPRITE_POINTER_0
        lda     #violet
        sta     SPRITE_MULTICOLOR_3_0   // individual color of sprite 0
        lda     #44
        sta     SPRITE_0_X
        lda     #120
        sta     SPRITE_0_Y

        lda     #%00000000              // no multicolor sprites
        sta     SPRITE_HIRES
        lda     #%00000001              // turn on sprite 0
        sta     SPRITE_ENABLE
        // sta     SPRITE_DOUBLE_X      // scale x2 horizontally
        // sta     SPRITE_DOUBLE_Y

        lda     #green
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        jsr     CLR_SCR

        jsr     game_loop
        
        rts

/// GAME LOOP
        
game_loop:
        
key_loop:
        jsr     CHR_IN
        cmp     #$103           // run stop
        beq     quit

        // check key presses
        cmp     #$41
        beq     dir_left
        cmp     #$44
        beq     dir_right
        
        bne     key_loop
        
dir_left:       
        lda     #spr0NumFrames
        sta     spr0_direction
        jmp     key_loop
dir_right:      
        lda     #$00
        sta     spr0_direction
        jmp     key_loop

quit:   
        rts

/// INTERRUPTS
        
irq1:
        SAVE_REG_TO_STACK()
        jsr     spr0_anim
        
        jmp     ack

ack:
        // Bit #0: 1 = Current raster line is equal to the raster line to generate interrupt at.
        // acknowledge interrupt means to set the corresponding bit to 0
        dec     RASTER_SPRITE_INT_STA

        RESTORE_REG_FROM_STACK()

        jmp     SYS_IRQ_HANDLER

spr0_anim:
        // run anim every 6th interrupt
        inc     spr0_anim_delay
        lda     spr0_anim_delay
        cmp     #6
        bne     spr0_anim_2
        // wrap anim delay
        lda     #0
        sta     spr0_anim_delay

        // increase frame counter
        ldx     spr0_frame_cnt
        cpx     #spr0NumFrames
        bne     spr0_anim_1
        // wrap frame counter
        ldx     #0
        stx     spr0_frame_cnt

spr0_anim_1:
        // set sprite direction
        txa
        clc
        adc     spr0_direction
        tax
        // select anim frame; x is offset
        lda     spr0_anim_frames,x      // use X as offset
        sta     SPRITE_POINTER_0
        inc     spr0_frame_cnt

spr0_anim_2:
        
        rts

/// DATA
        
spr0_anim_frames:
        .byte spraddr, spraddr+1, spraddr+2, spraddr+1
        .byte spraddr+3, spraddr+4, spraddr+5, spraddr+4
spr0_frame_cnt:
        .byte 0
spr0_anim_delay:
        .byte 0
spr0_direction:
        .byte 0

/// SPRITES
        
        *=(spraddr*64)                  // mul spr addr by 64 to animate
spr0:
        LOAD_HIRES_ANIM_SPRITE(spr0Fname,"",3)
        LOAD_HIRES_ANIM_SPRITE(spr0Fname,"_flop",3)
