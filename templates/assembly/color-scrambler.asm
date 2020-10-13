BasicUpstart2(start)

start:
        inc $d020
        inc $d021
        jmp start
