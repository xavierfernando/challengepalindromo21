#!/bin/bash


# laco para criar todos palindromos 9 digitos 
for e in 1 3 7 9; do
  for ((d = 0; d <= 9; d++)); do
    for ((c = 0; c <= 9; c++)); do
      for ((b = 0; b <= 9; b++)); do
        for ((a = 0; a <= 9; a++)); do
          echo $e$d$c$b$a$b$c$d$e >>"${file_r_palind}"
        done
      done
    done
  done
done