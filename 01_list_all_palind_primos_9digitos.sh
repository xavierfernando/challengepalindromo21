#!/bin/bash

#!/bin/bash
# resultado dos primos de 3 ate range inicial auxiliar
file_r_primos_ate_100="r_primos_ate_100.txt"
# resultado de todos os palindromos de 21 digitos, excluindo os que comecam com numero par e 5
file_r_palind="r_palind.txt"
# resultado dos multiplos q serao excluidos do rol de multiplicacao para buscar primos extensos
file_r_multiplos_selecionados="r_multiplos_selecionados.txt"

rm -f "${file_r_palind}"
rm -f "${file_r_primos_ate_100}"
rm -f "${file_r_multiplos_selecionados}"
m=100000000
n=999999999

prime_1=0
echo "range de primos iniciais a descobrir:"
read n

for e in 1 3 7 9; do
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

# ************************************************************** #
# obs: a) o numero primo 2 foi omitido, pois nenhum palindromo   #
#         par eh elegivel a ser primo.                           #
#      b) para otimizar o algoritimo, os 3 primos subsequentes   #
#         foram lancados manualmente.                            #
# ************************************************************** #

echo 3 | tee -a ${file_r_primos_ate_100}
# echo 5 | tee -a ${file_r_primos_ate_100}
echo 7 | tee -a ${file_r_primos_ate_100}

for ((i = 3; i <= n; i += 2)); do
  r=$(echo "sqrt(${i})" | bc)
  for ((j = 3; j <= r; j++)); do
    echo i $i e j $j
    # sleep 5
    if [ $(expr $i % $j) -ne 0 ]; then
      prime_1=1
    else
      prime_1=0
      break
    fi
    # j=$(expr $j - 1)
  done
  if [ $prime_1 -eq 1 ]; then
    echo $i 2>&1 | tee -a ${file_r_primos_ate_100}
  fi
done

read -p "Press Enter to continue"

prime_1=0
while read -r line0; do
  r=$(echo "sqrt(${line0})" | bc)
  echo $r
  sleep 1
  while read -r k; do
    echo $k
    sleep 1
    if [ $k -le $r ]; then
      echo $k e $r k e r
      sleep 1
      echo $k 2>&1 | tee -a ${file_r_multiplos_selecionados}
      for ((m = 2; l < r; m += 2)); do
        echo $m m
        l=$(($k + $k * $m))
        echo $l 2>&1 | tee -a ${file_r_multiplos_selecionados}
      done
      l=1
    fi
  done <"${file_r_primos_ate_100}"

  #   if [ $k -le $r ]; then
  #     echo line0 = $line0 e k = $k
  #     if [ $(expr $line0 % $k) -ne 0 ]; then
  #       prime_1=1

  #     else
  #       prime_1=0
  #       echo $line0 nao eh primo pois divide por $k
  #       break
  #     fi

  #   fi

  # if [ $prime_1 -eq 1 ]; then
  #   echo $line0 2>&1 | tee -a r_palind_primos.txt
  # fi
done <"${file_r_palind}"
