// ---------------------------------------
// Row-based keyboard scan
// Q W E R T → border colors
// ---------------------------------------

BasicUpstart2(start)

* = $1000

start:
    lda #$00
    sta $d020        // initial border color

mainloop:
    jsr scan_row0
    jmp mainloop


// ---------------------------------------
// Scan row 0 (Q W E R T)
// ---------------------------------------

scan_row0:
    // select row 0
    lda #%11111000
    sta $dc00

    lda $dc01        // read columns

    // Q → color 0
    and #%01000000
    bne check_w
    lda #$00
    sta $d020
    rts

check_w:
    lda $dc01
    and #%00000010
    bne check_e
    lda #$01
    sta $d020
    rts

check_e:
    lda $dc01
    and #%00000100
    bne check_r
    lda #$02
    sta $d020
    rts

check_r:
    lda $dc01
    and #%00001000
    bne check_t
    lda #$03
    sta $d020
    rts

check_t:
    lda $dc01
    and #%00010000
    bne done
    lda #$04
    sta $d020

done:
    rts
