#!/usr/bin/env bash

# ------------------------------------------------------------
# Configuration (override via env if needed)
# ------------------------------------------------------------
KICKASS_JAR="${KICKASS_JAR:-$HOME/Retrogaming/C64/utils/KickAssembler/KickAss.jar}"
EMU_EXE="${EMU_EXE:-x64sc}"

PROJ_DIR="${PROJ_DIR:-$HOME/dev/edu/assembly-6510}"
PROG_DIR="01_assembly"
PROG_NAME="prog"
SAVE_DISK=false

# ------------------------------------------------------------
# Options
# ------------------------------------------------------------
usage() {
    echo "Usage: $0 [-d prog_dir] [-p prog_name] [-s]"
    echo "  -d  Program directory (default: $PROG_DIR)"
    echo "  -p  Program name without extension (default: $PROG_NAME)"
    echo "  -s  Save PRG to D64 disk image"
    exit 1
}

while getopts ":d:p:s" option; do
    case "$option" in
        d) PROG_DIR="$OPTARG" ;;
        p) PROG_NAME="$OPTARG" ;;
        s) SAVE_DISK=true ;;
        *) usage ;;
    esac
done

# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------
WORK_DIR="$PROJ_DIR/$PROG_DIR"
ASM_FILE="$PROG_NAME.asm"
PRG_FILE="$PROG_NAME.prg"
D64_FILE="$PROG_NAME.d64"

# ------------------------------------------------------------
# Sanity checks
# ------------------------------------------------------------
command -v java >/dev/null || { echo "java not found"; exit 1; }
command -v "$EMU_EXE" >/dev/null || { echo "$EMU_EXE not found"; exit 1; }

if [[ ! -f "$KICKASS_JAR" ]]; then
    echo "KickAssembler JAR not found: $KICKASS_JAR"
    exit 1
fi

if [[ ! -d "$WORK_DIR" ]]; then
    echo "Program directory not found: $WORK_DIR"
    exit 1
fi

cd "$WORK_DIR"

if [[ ! -f "$ASM_FILE" ]]; then
    echo "ASM file not found: $ASM_FILE"
    exit 1
fi

# ------------------------------------------------------------
# Compile
# ------------------------------------------------------------
echo "==> Compiling $ASM_FILE"
java -jar "$KICKASS_JAR" "$ASM_FILE"

# ------------------------------------------------------------
# Optional disk image
# ------------------------------------------------------------
if $SAVE_DISK; then
    echo "==> Creating disk image $D64_FILE"
    rm -f "$D64_FILE"
    c1541 -format "$PROG_NAME,dd" d64 "$D64_FILE" \
          -attach "$D64_FILE" \
          -write "$PRG_FILE"
fi

# ------------------------------------------------------------
# Run
# ------------------------------------------------------------
echo "==> Running $PRG_FILE"
"$EMU_EXE" -silent -autostartprgmode 1 "$PRG_FILE"
