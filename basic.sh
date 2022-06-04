#!/bin/bash

PROG_DIR=
PREPEND_LINE_NUM=false

while getopts "p:" option; do
    case $option in
        p) PROG_DIR=$OPTARG
           ;;
    esac
done

cd $PROG_DIR

PROG_NAME=main

# create a disk image
c1541 -format $PROG_NAME,dd d64 $PROG_NAME.d64

# tokenize the program into a prg file
petcat -v -w2 -o $PROG_NAME.prg -- ${PROG_NAME}.bas

# write the prg file on disk
c1541 -attach $PROG_NAME.d64 -write $PROG_NAME.prg

# test it in VICE
x64 $PROG_NAME.d64
