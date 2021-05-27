        .import source "../include/constants.asm"

        .var    runstop =       $0103
        .const  spraddr =       200
        
        BasicUpstart2(start)

        *=$1000

start:
        lda     #spraddr                // incr/decr this by 1 to animate
        sta     SPRITE_POINTER_0
        lda     #lgreen
        sta     SPRITE_MULTICOLOR_3_0   // individual color of sprite 0
        lda     #44
        sta     SPRITE_0_X
        lda     #120
        sta     SPRITE_0_Y

        lda     #(spraddr+1)
        sta     SPRITE_POINTER_1
        lda     #yellow
        sta     SPRITE_MULTICOLOR_3_1   // individual color of sprite 1 (bit combo 10)
        lda     #violet
        sta     SPRITE_MULTICOLOR_1     // multicolor 1 of sprites (bit combo 01)
        lda     #lblue
        sta     SPRITE_MULTICOLOR_2     // multicolor 2 of sprites (bit combo 11)
        lda     #150
        sta     SPRITE_1_X
        lda     #120
        sta     SPRITE_1_Y
        
        lda     #%00000010              // only sprite 1 is multicolor
        sta     SPRITE_HIRES
        lda     #%00000011              // turn on sprite 0 and 1
        sta     SPRITE_ENABLE
        ;; sta     SPRITE_DOUBLE_X      // scale x2 horizontally
        ;; sta     SPRITE_DOUBLE_Y

        lda     #black
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        jsr     CLR_SCR

        rts

        *=(spraddr*64)                  // mul spr addr by 64 to animate
// sprite 0 / singlecolor / color: $0d
sprite_0:
.byte $00,$18,$00,$00,$3c,$00,$00,$7e
.byte $00,$00,$db,$00,$01,$99,$80,$03
.byte $bd,$c0,$07,$ff,$e0,$0f,$ff,$f0
.byte $0f,$ff,$f0,$1f,$e7,$f8,$1f,$81
.byte $f8,$1d,$81,$b8,$19,$81,$98,$11
.byte $81,$88,$11,$81,$88,$00,$81,$00
.byte $01,$42,$80,$00,$81,$00,$00,$81
.byte $00,$00,$00,$00,$00,$00,$00,$0d        

// sprite 1 / multicolor / color: $07
sprite_1:
.byte $00,$00,$00,$00,$00,$00,$00,$cc
.byte $00,$02,$46,$00,$00,$44,$00,$00
.byte $54,$00,$00,$64,$00,$00,$64,$00
.byte $25,$55,$60,$01,$55,$00,$00,$54
.byte $00,$00,$74,$00,$00,$74,$00,$01
.byte $75,$00,$05,$dd,$40,$07,$03,$40
.byte $07,$03,$40,$07,$03,$40,$05,$01
.byte $40,$14,$00,$50,$00,$00,$00,$87
