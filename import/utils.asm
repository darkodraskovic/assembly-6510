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

.macro SET_RASTER_IRQ_LINE(line) {
        .assert "line must be 0–311", line, line >= 0 && line <= 311

        lda RASTER_LINE_MSB          // read $D011 (VIC control + raster MSB)
        and #%01111111               // clear raster bit 8
        .if (line >= 256)
            ora #%10000000           // set raster bit 8 if line >= 256
        sta RASTER_LINE_MSB          // write back, preserve other control bits

        lda #(line & $FF)            // low 8 bits of raster line
        sta RASTER_LINE              // $D012: raster compare value
}

.macro SET_IRQ_VECTOR(irq) {
        lda #<irq                    // IRQ handler address (low byte)
        sta INTERRUPT_EXECUTION_LOW  // $0314
        lda #>irq                    // IRQ handler address (high byte)
        sta INTERRUPT_EXECUTION_HIGH // $0315
}


// fileName : str        
.macro  LOAD_HIRES_SPRITE(fileName) {
        .var pic = LoadPicture(fileName)

        .for (var y=0; y<21; y++) // which row
                .for (var x=0;x<3; x++) // which byte of the row
                        .byte pic.getSinglecolorByte(x,y)

        .fill 1,0 // Sprites are 64 bytes long, but only 63 are used: add one byte of padding
}
        

.macro LOAD_HIRES_ANIM_SPRITE(fileName, suffix, numFrames) {
        .for (var y=0; y<numFrames; y++)
                LOAD_HIRES_SPRITE(fileName+y+suffix+".gif")
}

// fileName : str; -Col : hex        
.macro  LOAD_MULTICOL_SPRITE(fileName, indvidualCol, multiCol1, multiCol2) {
        // List().add(transparent, SPRITE_MULTICOLOR_1, SPRITE_MULTICOLOR_3_X, SPRITE_MULTICOLOR_2)
        // Multicolor 1 ($D025), Sprite individual color ($D027+n), Multicolor 2 ($D026)
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
