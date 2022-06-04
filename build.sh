KICKASS_JAR="/home/darko/Programs/KickAssembler/KickAss.jar"
EMU_EXE="x64"

PROJ_DIR=~/Development/assembly-6510/
PROG_DIR=01_assembly
PROG_NAME=prog
SAVE_DISK=false

if [ "$OSTYPE" = "msys" ]; then
    KICKASS_JAR="c:/Users/darko/Programs/KickAssembler/KickAss.jar"
    EMU_EXE="c:/Users/darko/Programs/VICE/bin/x64sc.exe"

    PROJ_DIR=c:/Users/darko/Development/assembly-6510/    
fi

while getopts "d:p:s" option; do
    case $option in
        d)
            PROG_DIR=$OPTARG
            ;;
        p)
            PROG_NAME=$OPTARG
            ;;
        s)
            SAVE_DISK=true
    esac
done

COMPILE_CMD="java -jar ${KICKASS_JAR} ${PROG_NAME}.asm"
RUN_CMD="${EMU_EXE} -silent -autostartprgmode 1 ${PROG_NAME}.prg"

cd ${PROJ_DIR}/${PROG_DIR}

$COMPILE_CMD
if [ $? != 0 ]; then
    exit 1
fi

if [ $SAVE_DISK == true ]; then
    # create a disk image
    c1541 -format $PROG_NAME,dd d64 $PROG_NAME.d64
    # write the prg file on disk
    c1541 -attach $PROG_NAME.d64 -write $PROG_NAME.prg
fi

$RUN_CMD
