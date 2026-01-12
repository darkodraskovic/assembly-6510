        .import source "../import/constants.asm"
        .import source "../import/utils.asm"

        .var    music   =       LoadSid("Saboteur.sid")

        BasicUpstart2(irqinit)

        *=$1000

irqinit:
        sei
        lda     #$7f
        sta     INTERRUPT_STA_CTRL              // Interrupt control and status register (Bit #7: Fill bit)

        lda     RASTER_SPRITE_INT_CTRL
        ora     #$01                            // Bit #0: 1 = Raster interrupt enabled.
        sta     RASTER_SPRITE_INT_CTRL

        SET_RASTER_IRQ_LINE(0)

        SET_IRQ_VECTOR(irq1)

        cli

start:
        lda     #music.startSong-1
        jsr     music.init

        // interrupts (irq routines) contiune running after rts (if not cleared)
        rts

irq1:
        SAVE_REG_TO_STACK()

        lda     #$38
        sta     RASTER_LINE_MSB                 // Bit #5: 1 = Bitmap mode
        
        ;; jsr     music.play

        lda     #green
        sta     BORDER_COLOR

        lda     #$9f
        sta     RASTER_LINE
        SET_IRQ_VECTOR(irq2)
        jmp     ack

irq2:
        SAVE_REG_TO_STACK()

        lda     #yellow
        sta     BORDER_COLOR

        lda     #$c8
        sta     RASTER_LINE
        SET_IRQ_VECTOR(irq3)
        jmp     ack

irq3:
        SAVE_REG_TO_STACK()

        lda     #$18
        sta     RASTER_LINE_MSB                 // Bit #5: 0 = Text mode
        
        lda     #00
        sta     RASTER_LINE
        SET_IRQ_VECTOR(irq1)

        jmp     ack

ack:
        // Bit #0: 1 = Current raster line is equal to the raster line to generate interrupt at.
        // acknowledge interrupt means to set the corresponding bit to 0
        dec     RASTER_SPRITE_INT_STA

        RESTORE_REG_FROM_STACK()

        jmp     SYS_IRQ_HANDLER



        *=music.location "Music"
        .fill music.size, music.getData(i)
