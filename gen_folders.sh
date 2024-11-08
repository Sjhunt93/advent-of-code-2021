#!/usr/bin/env bash

start_index=1
end_index=25
for ((i=start_index; i<=end_index; i++)); do
  # format a dirpath with the 3-digits index
  # printf -v dirpath 'solutions/%d/1' $i
  # mkdir -p -- "$dirpath"
  printf -v dirpath 'solutions/%d' $i
  mkdir -p -- "$dirpath"
  printf -v dirpath 'solutions/%d/notes.md' $i
  touch "$dirpath"
  printf -v dirpath 'solutions/%d/input.dat' $i
  touch "$dirpath"
  printf -v dirpath 'solutions/%d/test.dat' $i
  touch "$dirpath"
done