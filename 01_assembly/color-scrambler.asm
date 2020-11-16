BasicUpstart2(start)

start:
        ldx #$21
        stx $fb
        lda $fb
        jsr $ffd2
        rts
