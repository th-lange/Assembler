#!/bin/bash

if [[ -n "$1" && -f "$1" ]]; then
    filename="$1"
    base="${filename%%.*}"
    ext="${filename##*.}"

    nasm -f macho "$filename" \
    && ld "${base}.o" -o "$base"
fi
