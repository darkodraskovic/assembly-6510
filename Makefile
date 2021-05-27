all:
	java -jar ~/Programs/KickAss/KickAss.jar prog.asm

run:
	vice-jz.x64 -silent -autostartprgmode 1 prog.prg

clean:
	rm *.prg *.sym
