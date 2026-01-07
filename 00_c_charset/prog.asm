.import source "../import/utils.asm"
.import source "../import/vic.asm"

// ---------------------------------------
// Minimal custom charset display
// ---------------------------------------

BasicUpstart2(start)

// ---------------------------------------
// Load charset at $2000
// ---------------------------------------

* = $2000 "Charset"

LOAD_HIRES_CHAR("hi-res-chars-128x64.png", 16, 8)

// ---------------------------------------
// Program code
// ---------------------------------------

* = $1000 "Code"

start:
    // border & background (just for clarity)
    lda #black
    sta BORDER_COLOR
    lda #lgreen
    sta SCREEN_COLOR

setVICBank(0)

setVICPtr($0400, $2000)

blitScreenMap(screen_map_2, $0400, 0*$ff, $ff)
blitScreenMap(screen_map_2, $0400, 1*$ff, $ff)
blitScreenMap(screen_map_2, $0400, 2*$ff, $ff)
blitScreenMap(screen_map_2, $0400, 3*$ff, $ff)
blitScreenMap(screen_map_2, $0400, 4*$ff, 1000 - 4 * 256)

loop:
    jmp loop

.import source "char_map_0.asm"
