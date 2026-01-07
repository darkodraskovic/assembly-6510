// ---------------------------------------
// Minimal C64 program
// Shows a single sprite
// ---------------------------------------

BasicUpstart2(start)

* = $1000

start:
    // border color (just to keep something visible)
    lda #$00
    sta $d020

    // background color
    lda #$06
    sta $d021

    // sprite 0 X position
    lda #$80        // 128
    sta $d000

    // sprite 0 Y position
    lda #$60        // 96
    sta $d001

    // sprite pointer for sprite 0
    lda #$80        // $2000 / 64 = $20
    sta $07f8

    // enable sprite 0
    lda #$01
    sta $d015

loop:
    jmp loop

// ---------------------------------------
// Sprite data (63 bytes)
// ---------------------------------------

* = $2000

sprite0:
    // 21 rows, each row = 3 bytes (24 bits)
    .byte %00000000, %00000000, %00000000  // row 0
    .byte %00000000, %00011000, %00000000  // row 1
    .byte %00000000, %00111100, %00000000  // row 2
    .byte %00000000, %01111110, %00000000  // row 3
    .byte %00000000, %11111111, %00000000  // row 4
    .byte %00000000, %01111110, %00000000  // row 5
    .byte %00000000, %00111100, %00000000  // row 6
    .byte %00000000, %00011000, %00000000  // row 7

    // rows 8..20 empty
    .fill (21 - 8) * 3, 0