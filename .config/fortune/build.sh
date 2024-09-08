#!/usr/bin/env bash

# get all files with no extension in current directory
cd "$(dirname "$0")" || exit
shopt -s extglob

# cat quotes.txt | sort -t'\~' -f -k2 | sd '$' '\n%' >quotes

# compile fortune files
files=(!(*.*))
for file in "${files[@]}"; do
  echo "compiling $file"
  rm -f "$file".dat
  strfile -c % "$file" "$file".dat
  echo
done
