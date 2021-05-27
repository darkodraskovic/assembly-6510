#!/bin/sh

for f in ${1}*.gif; do
    name=${f%.gif}
    convert -flop "$f" "${name}_flop.gif"
done
