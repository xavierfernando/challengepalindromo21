#!/bin/bash

file="/home/vagrant/pimil.txt"
primeiroCaracter=0

i=1
echo -n $file
while read -n1 c; do
  echo c "$c" $(printf "%2X" "'$c'")
  # for ((i = 1; i = 1000000; i++)); do
  if [ $primeiroCaracter -eq 0 ]; then
    echo no laco do arquivo
    # if [ $c -eq 1 ] || [ $c -eq 3 ] || [ $c -eq 7 ] || [ $c -eq 9 ]; then
    if [ $i -le 20 ]; then
      possivelPalind="${possivelPalind}${c}"
      ((i++))
      echo i $i

    else
      expansaoDecimal=$possivelPalind$c
      echo expansao $expansaoDecimal
      possivelPalind=""
      echo terminou
      i=1
    fi
  fi
  # fi

  # done

done <$file
