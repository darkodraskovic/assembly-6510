#importonce

.var CHR_IN = $ffe4
.var CHR_OUT = $ffd2
.var CLR_SCR = $e544

.var SCREEN_MEM = $0400
.var TEXT_COLOR = $286

// Execution address of interrupt service routine
.var INTERRUPT_EXECUTION_LOW = $0314
.var INTERRUPT_EXECUTION_HIGH = $0315
.var SYS_IRQ_HANDLER = $EA31                            // Default address of interrupt service routine

.var RASTER_LINE_MSB = $D011
.var RASTER_LINE = $D012                                // Read: Current raster line (bits #0-#7); Write: Raster line to generate interrupt at (bits #0-#7).
.var SCREEN_MULTICOLOUR = $D016
// Timer A/B underflow, TOD is equal to alarm time, byte received/sent from/to serial shift register, signal level on FLAG pin, interrupt generated
.var INTERRUPT_STA_CTRL = $DC0D                         // R occurence, W enable/disable with Bit #7: Fill bit
.var RASTER_SPRITE_INT_STA = $D019                      // status (R occurence, W acknowledge) of raster interrupt, sprite-background and sprite-sprite collisions
.var RASTER_SPRITE_INT_CTRL = $D01A                     // R is enabled/disabled; W enable/disable raster interrupt, sprite-background and sprite-sprite collisions

.var JPORT2 = $DC00

// VIC-II sprite registers
.const	VIC_BASE  = $D000
//screen colors
.const	BORDER_COLOR = $D020
.const	SCREEN_COLOR = $D021
.const TXT_COLOUR_1 = $D022
.const TXT_COLOUR_2 = $D023
.const  VIC_CONTR_REG = $D016
//sprite colors registers
.const	SPRITE_MULTICOLOR_1 = $D025
.const	SPRITE_MULTICOLOR_2 = $D026
.const	SPRITE_MULTICOLOR_3_0 = $D027
.const	SPRITE_MULTICOLOR_3_1 = $D028
.const	SPRITE_MULTICOLOR_3_2 = $D029
.const	SPRITE_MULTICOLOR_3_3 = $D02A
.const	SPRITE_MULTICOLOR_3_4 = $D02B
.const	SPRITE_MULTICOLOR_3_5 = $D02C
.const	SPRITE_MULTICOLOR_3_6 = $D02D
.const	SPRITE_MULTICOLOR_3_7 = $D02E
//sprite enable
.const	SPRITE_ENABLE = $D015
//address holding pointer info to graphics area
.const	GRAPHICS_POINTER = $D018
//sprite pointers - relative to GRAPHICS_POINTER
//sprite data address / 64
.const	SPRITE_POINTER_0 = $07F8
.const	SPRITE_POINTER_1 = $07F9
.const	SPRITE_POINTER_2 = $07FA
.const	SPRITE_POINTER_3 = $07FB
.const	SPRITE_POINTER_4 = $07FC
.const	SPRITE_POINTER_5 = $07FD
.const	SPRITE_POINTER_6 = $07FE
.const	SPRITE_POINTER_7 = $07FF
//sprite screen locations
.const	SPRITE_0_X = $D000
.const	SPRITE_0_Y = $D001
.const	SPRITE_1_X = $D002
.const	SPRITE_1_Y = $D003
.const	SPRITE_2_X = $D004
.const	SPRITE_2_Y = $D005
.const	SPRITE_3_X = $D006
.const	SPRITE_3_Y = $D007
.const	SPRITE_4_X = $D008
.const	SPRITE_4_Y = $D009
.const	SPRITE_5_X = $D00A
.const	SPRITE_5_Y = $D00B
.const	SPRITE_6_X = $D00C
.const	SPRITE_6_Y = $D00D
.const	SPRITE_7_X = $D00E
.const	SPRITE_7_Y = $D00F
.const	SPRITE_MSB_X = $D010
//high res or multicolor
.const	SPRITE_HIRES = $D01C
//sprite size expanders
.const	SPRITE_DOUBLE_X = $D01D
.const	SPRITE_DOUBLE_Y = $D017
//sprite color settings
.const	SPRITE_SOLID_ALL_1 = $D025
.const	SPRITE_SOLID_ALL_2 = $D026
.const	SPRITE_SOLID_0 = $D027
.const	SPRITE_SOLID_1 = $D028
.const	SPRITE_SOLID_2 = $D029
.const	SPRITE_SOLID_3 = $D02A
.const	SPRITE_SOLID_4 = $D02B
.const	SPRITE_SOLID_5 = $D02C
.const	SPRITE_SOLID_6 = $D02D
.const	SPRITE_SOLID_7 = $D02E
//sprite priority over background
.const	SPRITE_BG_PRIORITY = $D01B
//collision detection
.const	SPRITE_COLL_SPRITE = $D01E
.const	SPRITE_COLL_BG = $D01F
//interrupt registers
.const	INTERRUPT_EVENT = $D019
.const	INTERRUPT_ENABLE = $D01A

// C64 Colour Codes
.var black = $0
.var white = $1
.var red = $2
.var cyan = $3
.var violet = $4
.var green = $5
.var blue = $6
.var yellow = $7
.var orange = $8
.var brown = $9
.var lred = $a
.var dgrey = $b
.var grey = $c
.var lgreen = $d
.var lblue = $e
.var lgrey = $f
