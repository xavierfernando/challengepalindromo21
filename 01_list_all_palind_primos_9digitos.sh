#!/bin/bash

# resultado dos primos de 3 ate range inicial auxiliar
file_r_primos_iniciais="temp_02_primos_iniciais.txt"
# resultado dos multiplos q serao excluidos do rol de multiplicacao para buscar primos extensos
file_r_multiplos_selecionados="temp_03_multiplos_selecionados.txt"

file_r_multiplos_selecionados_ordenados_exclusivos="temp_04_multiplos_selecionados_ordenados_exclusivos.txt"

file_r_todos_multiplos="temp_05_todos_multiplos.txt"

file_r_juncao_selecionados_com_todos="temp_06_juncao_selecionados_com_todos.txt"

file_r_todos_multiplos_menos_os_selecionados="temp_07_todos_multiplos_menos_os_selecionados.txt"

file_r_palind_primos="temp_08_palind_primos.txt"

rm -f "${file_r_primos_iniciais}"
rm -f "${file_r_multiplos_selecionados}"
rm -f "${file_r_multiplos_selecionados_ordenados_exclusivos}"
rm -f "${file_r_todos_multiplos}"
rm -f "${file_r_juncao_selecionados_com_todos}"
rm -f "${file_r_todos_multiplos_menos_os_selecionados}"
rm -f "${file_r_palind_primos}"

descobrePrimosIniciais() {

  prime_1=0

  # ***************************************************************** #
  # obs: a) os numeros primo 2 e 5 foram omitidos, pois nenhum        #
  #         palindromo par ou multiplo de 5 eh elegivel a ser primo.  #
  #      b) para otimizar o algoritimo, os 2 primos subsequentes      #
  #         foram lancados manualmente.                               #
  # ***************************************************************** #

  echo 3 | tee -a ${file_r_primos_iniciais}
  # echo 5 | tee -a ${file_r_primos_iniciais}
  echo 7 | tee -a ${file_r_primos_iniciais}

  for ((i = 3; i <= primosiniciais; i += 2)); do
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
      echo $i 2>&1 | tee -a ${file_r_primos_iniciais}
    fi
  done

}

gerarMultiplosSelecionadosExclusivos() {

  read -p "Press Enter to contine 2"
  # echo $r
  r=$(echo "sqrt(${sequenciafinal})" | bc)
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
  done <"${file_r_primos_iniciais}"

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
  sort -g "${file_r_juncao_selecionados_com_todos}" | uniq -u >"${file_r_todos_multiplos_menos_os_selecionados}"
  read -p "Press Enter to contine 4"
}

testaPrimo() {
  line="${1}"

  r=$(echo "sqrt(${line})" | bc)
  while read -r z; do
    # for ((i = 3; i <= r; i += 2)); do
    #echo line = $line e i = $i
    if [ $(expr $line % $z) -ne 0 ]; then
      prime_1=1

    else
      prime_1=0
      echo $line nao eh primo pois divide por $i
      testaPrimoResult=0
      break
    fi
  done <"${file_r_todos_multiplos_menos_os_selecionados}"
  if [ $prime_1 -eq 1 ]; then
    echo $line 2>&1 | tee -a "${file_r_palind_primos}"
    testaPrimoResult=1
  fi

}

procuraPalindromoExpansaoDecimal() {

  i=121900
  # filename="r_palind_primos.txt"
  rm -f r_palind_primos_expansao.txt

  while :; do
    echo analisando numeral de 9 digitos das posicoes $(($i - 9)) a $(($i - 1)) da expansao decimal.
    deslocamento=$(expr $i - 9)

    expansaoDecimal=$(echo $(pi $i) | cut -d'.' -f 2)

    expDecimalNoveDigitos=$(echo "${expansaoDecimal}" | cut -c "${deslocamento}"-)
    # echo $expDecimalNoveDigitos
    if
      [ "${expDecimalNoveDigitos: -1}" -eq "1" ] ||
        [ "${expDecimalNoveDigitos: -1}" -eq "3" ] ||
        [ "${expDecimalNoveDigitos: -1}" -eq "7" ] ||
        [ "${expDecimalNoveDigitos: -1}" -eq "9" ]
    then

      if [ "${expDecimalNoveDigitos:0:1}" -eq "${expDecimalNoveDigitos:8:1}" ]; then

        if [ "${expDecimalNoveDigitos:1:1}" -eq "${expDecimalNoveDigitos:7:1}" ]; then
          if [ "${expDecimalNoveDigitos:2:1}" -eq "${expDecimalNoveDigitos:6:1}" ]; then
            if [ "${expDecimalNoveDigitos:3:1}" -eq "${expDecimalNoveDigitos:5:1}" ]; then

              echo $expDecimalNoveDigitos eh palindromo
              echo posicoes $(($i - 9)) a $(($i - 1)) da expansao decimal $expDecimalNoveDigitos >>r_palind_primos_expansao.txt

              testaPrimo ${expDecimalNoveDigitos}
              echo $testaPrimoResult
              if [ $testaPrimoResult -eq 1 ]; then
                echo "entrou no if do testa primo"
                echo "${expDecimalNoveDigitos} foi encontrado no arquivo."
                echo "${expDecimalNoveDigitos} eh o primeiro palindromo primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
                exit
              fi
              echo "passou do if testa primo"
              echo "${expDecimalNoveDigitos} eh palindromo porem nao primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
              sleep 1
              echo i = $i
            fi
          fi
        fi
      fi
    fi

    ((i++))
    
  done
}

echo "range de primos iniciais a descobrir:"
read primosiniciais
echo "informe o primeiro numeral a fazer buscas: "
read sequenciainicial
echo "informe o ultimo numeral a fazer buscas: "
read sequenciafinal

descobrePrimosIniciais
gerarMultiplosSelecionadosExclusivos
procuraPalindromoExpansaoDecimal


curl -s "https://api.pi.delivery/v1/pi?start=1&numberOfDigits=1000&radix=10" | cut -d '"' -f 4
