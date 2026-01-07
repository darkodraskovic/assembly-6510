.importonce

.import source "constants.asm"

.macro setVICBank(bank) {
    .assert "VIC bank must be 0–3", bank, bank >= 0 && bank <= 3

    lda VIC_BANK
    and #%11111100
    ora #((~bank) & 3)
    sta VIC_BANK
}

.macro setVICPtr(screenAddr, charsetAddr) {
    .const __screenIndex  = (screenAddr & $3FFF) / 1024
    .const __charsetIndex = (charsetAddr & $3FFF) / 2048

    lda #((__screenIndex << 4) | (__charsetIndex << 1))
    sta VIC_MEM_PTR
}

.macro blitScreenMap(screenMap, screenRAM, cellOffset, cellCount) {
    ldx #0
loop_scr_map:
    lda screenMap+cellOffset,x
    sta screenRAM+cellOffset,x
    inx
    cpx #cellCount
    bne loop_scr_map
}
