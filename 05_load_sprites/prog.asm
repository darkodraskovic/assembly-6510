        .import source "../include/constants.asm"
        .import source "../include/utils.asm"

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
        SET_SPRITE_COLORS(SPRITE_MULTICOLOR_3_1, cyan, grey, yellow)
        lda     #150
        sta     SPRITE_1_X
        lda     #120
        sta     SPRITE_1_Y
        
        lda     #%00000010              // only sprite 1 is multicolor
        sta     SPRITE_HIRES
        lda     #%00000011              // turn on sprite 0 and 1
        sta     SPRITE_ENABLE
        // sta     SPRITE_DOUBLE_X      // scale x2 horizontally
        // sta     SPRITE_DOUBLE_Y

        lda     #black
        sta     BORDER_COLOR
        lda     #black
        sta     SCREEN_COLOR
        jsr     CLR_SCR

        rts

        *=(spraddr*64)                  // mul spr addr by 64 to animate
sprite_0: LOAD_HIRES_SPRITE("spr_hires_plane.gif")
sprite_1: LOAD_MULTICOL_SPRITE("spr_mulcol_vehicle.gif", $75CEC8, $7B7B7B, $EDF171)
