#!/bin/bash

#!/bin/bash
# rm -f r_palind.txt
# rm -f r_palind_primos.txt
m=100000000
n=999999999

for ((e = 1; e <= 9; e += 2)); do
  for ((d = 0; d <= 9; d++)); do
    for ((c = 0; c <= 9; c++)); do
      for ((b = 0; b <= 9; b++)); do
        for ((a = 0; a <= 9; a++)); do
          echo $e$d$c$b$a$b$c$d$e >>r_palind.txt
        done
      done
    done
  done
done

read -p "Press Enter to continue"

filename="/home/fernando/r_palind.txt"
while read -r line; do
  r=$(echo "sqrt(${line})" | bc)
  for ((i = 3; i <= r; i += 2)); do
    echo line = $line e i = $i
    if [ $(expr $line % $i) -ne 0 ]; then
      prime_1=1

    else
      prime_1=0
      echo $line nao eh primo pois divide por $i
      break
    fi
  done
  if [ $prime_1 -eq 1 ]; then
    echo $line 2>&1 | tee -a r_palind_primos.txt
  fi
done <"$filename"

