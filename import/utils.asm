#importonce

.import source "constants.asm"
        
.macro  SAVE_REG_TO_STACK() {
        // save A, X, Y to stack
        pha                                     // A -> stack
        txa                                     // X -> A
        pha
        tya                                     // Y -> A
        pha
}

.macro  RESTORE_REG_FROM_STACK() {        
        // restore Y, X, A from stack
        pla                                     // stack -> A
        tay                                     // A -> Y
        pla
        tax                                     // A -> X
        pla
}

// Write: Raster line to generate interrupt at
// MSB = #$ff (1) or #7f (0), LSB = #$00, #$ff
.macro  SET_RASTER_LINE_INTERRUPT(MSB, LSB) {                
        // Write: Raster line to generate interrupt at
        lda     RASTER_LINE_MSB
        and     #MSB
        sta     RASTER_LINE_MSB                 // set bit 8 (rater line pos MSB)
        lda     #LSB
        sta     RASTER_LINE                     // set low byte (bits 0-7) to LSB
}

.macro  SET_INTERRUPT_EXECUTION(irq) {
        lda     #<irq
        sta     INTERRUPT_EXECUTION_LOW
        lda     #>irq
        sta     INTERRUPT_EXECUTION_HIGH
}

// fileName : str        
.macro  LOAD_HIRES_SPRITE(fileName) {
        .var pic = LoadPicture(fileName)
        .for (var y=0; y<21; y++)
                .for (var x=0;x<3; x++)
                        .byte pic.getSinglecolorByte(x,y)

        .fill 1,0
}
        

.macro LOAD_HIRES_ANIM_SPRITE(fileName, suffix, numFrames) {
        .for (var y=0; y<numFrames; y++)
                LOAD_HIRES_SPRITE(fileName+y+suffix+".gif")
}

// fileName : str; -Col : hex        
.macro  LOAD_MULTICOL_SPRITE(fileName, indvidualCol, multiCol1, multiCol2) {
        // List().add(transparent, SPRITE_MULTICOLOR_1, SPRITE_MULTICOLOR_3_X, SPRITE_MULTICOLOR_2)
       .var pic = LoadPicture(fileName, List().add($00,multiCol1,indvidualCol,multiCol2))
       .for (var y=0; y<21; y++)
               .for (var x=0;x<3; x++)
                       .byte pic.getMulticolorByte(x,y)
        .fill 1,0
}        

///  spriteMulticolor : SPRITE_MULTICOLOR_3_x (x = 0,7)
.macro  SET_SPRITE_COLORS(spriteMulticolor, indvidualCol, multiCol1, multiCol2){
        lda     #indvidualCol
        sta     spriteMulticolor        // individual color of sprite 1 (bit combo 10)
        lda     #multiCol1
        sta     SPRITE_MULTICOLOR_1     // multicolor 1 of sprites (bit combo 01)
        lda     #multiCol2
        sta     SPRITE_MULTICOLOR_2     // multicolor 2 of sprites (bit combo 11)
}

.macro LOAD_HIRES_CHAR(fileName, numCharsX, numCharsY) {
        .var pic = LoadPicture(fileName)
        .for (var y = 0; y < numCharsY; y++)
                .for (var x = 0; x < numCharsX; x++) {
                        .var offset = y*8
                        .for (var i = offset; i < offset+8; i++)
                                .byte pic.getSinglecolorByte(x,i)
                }
}
