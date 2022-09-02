#!/bin/bash

#!/bin/bash
# resultado de todos os palindromos de 21 digitos, excluindo os que comecam com numero par e 5
file_r_palind="temp_01_palind.txt"
# resultado dos primos de 3 ate range inicial auxiliar
file_r_primos_ate_100="temp_02_primos_ate_100.txt"
# resultado dos multiplos q serao excluidos do rol de multiplicacao para buscar primos extensos
file_r_multiplos_selecionados="temp_03_multiplos_selecionados.txt"

file_r_multiplos_selecionados_ordenados_exclusivos="temp_04_multiplos_selecionados_ordenados_exclusivos.txt"

file_r_todos_multiplos="temp_05_todos_multiplos.txt"

file_r_juncao_selecionados_com_todos="temp_06_juncao_selecionados_com_todos.txt"

file_r_todos_multiplos_menos_os_selecionados="temp_07_todos_multiplos_menos_os_selecionados.txt"

file_r_palind_primos="temp_08_palind_primos.txt"

rm -f "${file_r_palind}"
rm -f "${file_r_primos_ate_100}"
rm -f "${file_r_multiplos_selecionados}"
rm -f "${file_r_multiplos_selecionados_ordenados_exclusivos}"
rm -f "${file_r_todos_multiplos}"
rm -f "${file_r_juncao_selecionados_com_todos}"
rm -f "${file_r_todos_multiplos_menos_os_selecionados}"
rm -f "${file_r_palind_primos}"
prime_1=0
multiplo_a_gravar=0
primeiro21digitos=100000000
ultimo21digitos=999999999

echo "range de primos iniciais a descobrir:"
read n

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

read -p "Press Enter to contine 2"
# echo $r
r=$(echo "sqrt(${ultimo21digitos})" | bc)
echo $r
# sleep 1
while read -r k; do
  echo k $k
  # sleep 1
  if [ $k -le $r ]; then
    echo $k e $r k e r
    # sleep 1
    # echo $k 2>&1 | tee -a ${file_r_multiplos_selecionados}
    for ((m = 2; l < r; m += 2)); do
      echo m $m
      l=$(($k + $k * $m))
      if [ $(expr $l % 5) -ne 0 ] && [ $l -le $r ]; then
        echo k = $k
        echo $l 2>&1 | tee -a ${file_r_multiplos_selecionados}
      fi
    done
    l=1
  fi
done <"${file_r_primos_ate_100}"

sort -g "${file_r_multiplos_selecionados}" | uniq >"${file_r_multiplos_selecionados_ordenados_exclusivos}"

read -p "Press Enter to contine 3"

echo $r
sleep 3

for ((i = 3; i <= r; i += 2)); do
  #sleep 1
  if [ $(expr $i % 5) -ne 0 ]; then
    echo $i 2>&1 | tee -a "${file_r_todos_multiplos}"
  fi
done

cat "${file_r_multiplos_selecionados_ordenados_exclusivos}" "${file_r_todos_multiplos}" > \
  "${file_r_juncao_selecionados_com_todos}"
sort -g "${file_r_juncao_selecionados_com_todos}" | uniq -u > "${file_r_todos_multiplos_menos_os_selecionados}"

sleep 1

read -p "Press Enter to contine 4"

while read -r line; do
  r=$(echo "sqrt(${line})" | bc)
  while read -r i; do
    # for ((i = 3; i <= r; i += 2)); do
    #echo line = $line e i = $i
    if [ $(expr $line % $i) -ne 0 ]; then
      prime_1=1

    else
      prime_1=0
      echo $line nao eh primo pois divide por $i
      break
    fi
  done <"${file_r_todos_multiplos_menos_os_selecionados}"
  if [ $prime_1 -eq 1 ]; then
    echo $line 2>&1 | tee -a "${file_r_palind_primos}"
  fi
done <"${file_r_palind}"
