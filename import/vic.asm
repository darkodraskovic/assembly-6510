.importonce

.import source "constants.asm"

.macro setVICBank(bank) {
    .assert "VIC bank must be 0–3", bank, bank >= 0 && bank <= 3

    lda VIC_BANK
    and #%11111100
    ora #((~bank) & 3)
    sta VIC_BANK
}

// controls where inside the VIC bank the screen and character data live
.macro setVICPtr(screenAddr, charsetAddr) {
    // scr mem must be on a 1 KB boundary // scr idx (0–15)
    .const __screenIndex  = (screenAddr & $3FFF) / 1024 
    // char mem must be on a 2 KB boundary // charset idx (0–7)
    .const __charsetIndex = (charsetAddr & $3FFF) / 2048 

    // bits 7–4 → screen memory index // bits 3–1 → character memory index
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
