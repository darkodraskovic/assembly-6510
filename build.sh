KICKASS_JAR="c:/Users/darko/Programs/KickAssembler/KickAss.jar"
EMU_EXE="c:/Users/darko/Programs/VICE/bin/x64sc.exe"

PROJ_DIR=c:/Users/darko/Development/assembly-6510/
PROG_DIR=01_assembly
PROG_NAME=prog

while getopts "d:p:" option; do
    case $option in
        d)
            PROG_DIR=$OPTARG
            ;;
        p)
            PROG_NAME=$OPTARG
            ;;
    esac
done

COMPILE_CMD="java -jar ${KICKASS_JAR} ${PROG_NAME}.asm"
RUN_CMD="${EMU_EXE} -silent -autostartprgmode 1 ${PROG_NAME}.prg"

cd ${PROJ_DIR}/${PROG_DIR}

$COMPILE_CMD
if [ $? != 0 ]; then
    exit 1
fi

$RUN_CMD
