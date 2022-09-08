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

consultarApi() {

  urlpi=$(printf "https://api.pi.delivery/v1/pi?start=%s&numberOfDigits=999&radix=10" ${1})

  curl -s $urlpi | cut -d '"' -f 4

}

consultarArquivoOffline() {


cat pimil.txt | cut -c 1-10 | cut -c 1-3
 cat pimil.txt | cut -c 1-999 | cut -c 1-21
 cat pimil.txt | cut -c 1-999 | cut -c 2-22
 cat pimil.txt | cut -c 1-999 | cut -c 3-23
 cat pimil.txt | cut -c 1-999 | cut -c 4-24
 cat pimil.txt | cut -c 1-999 | cut -c 5-25
 cat pimil.txt | cut -c 1-999 | cut -c 6-26
 echo "..."
 cat pimil.txt | cut -c 1-999 | cut -c 945-965
 cat pimil.txt | cut -c 1-999 | cut -c 946-966
 cat pimil.txt | cut -c 1-999 | cut -c 966-986
 cat pimil.txt | cut -c 1-987 | cut -c 967-987
 
 echo "pega mail mil"

 cat pimil.txt | cut -c 968-1966 | cut -c 1-21
 cat pimil.txt | cut -c 967-1965 | cut -c 2-22
 echo "..."
 cat pimil.txt | cut -c 967-1965 | cut -c 945-966

 echo "pega mais mil"
 cat pimil.txt | cut -c 1933-2931 | cut -c 1-21
 
 
  
}

procuraPalindromoExpansaoDecimal() {

  rm -f r_palind_primos_expansao.txt
  rm -f r_consultarApi.txt
  rm -f r_consultarApi2.txt


  # 8970277
  # 8970277
  # 8972209
  # 8972209

  for ((piIncremento = 1; piIncremento <= 1000000000000; piIncremento += 966)); do
    # for ((piIncremento = 1; piIncremento <= 1000000000000; piIncremento += 990)); do
    echo piIncremento $piIncremento
    expansaoDecimal=$(consultarApi $piIncremento)
    # echo $expansaoDecimal >> r_consultarApi.txt
    # echo -n $expansaoDecimal >> r_consultarApi2.txt
    echo decimalpura $expansaoDecimal
    # read -p "press enter para continuar"
    for ((umIncremento = 1; umIncremento <= 966; umIncremento++)); do
      # for ((umIncremento = 1; umIncremento <= 990; umIncremento++)); do
      # echo decimal2 $expansaoDecimal
      echo umIncremento $umIncremento
      echo "      012345678901234567890 press enter"
      # echo "$umIncremento"
      # echo decimal 3 $expansaoDecimal
      # echo unico digito "${expansaoDecimal:0:1}"

      if
        [ "${expansaoDecimal:0:1}" -eq "1" ] ||
          [ "${expansaoDecimal:0:1}" -eq "3" ] ||
          [ "${expansaoDecimal:0:1}" -eq "7" ] ||
          [ "${expansaoDecimal:0:1}" -eq "9" ]
      then

         echo -n "impar ${expansaoDecimal::21} umincremento $umIncremento "

        # echo zeroum "${expansaoDecimal:0:1}" oitoum "${expansaoDecimal:8:1}"
        # echo umum "${expansaoDecimal:1:1}" seteum "${expansaoDecimal:7:1}"
        if [ "${expansaoDecimal:0:1}" -eq "${expansaoDecimal:20:1}" ]; then
          if [ "${expansaoDecimal:1:1}" -eq "${expansaoDecimal:19:1}" ]; then
            if [ "${expansaoDecimal:2:1}" -eq "${expansaoDecimal:18:1}" ]; then
              if [ "${expansaoDecimal:3:1}" -eq "${expansaoDecimal:17:1}" ]; then
                if [ "${expansaoDecimal:4:1}" -eq "${expansaoDecimal:16:1}" ]; then
                  if [ "${expansaoDecimal:5:1}" -eq "${expansaoDecimal:15:1}" ]; then
                    if [ "${expansaoDecimal:6:1}" -eq "${expansaoDecimal:14:1}" ]; then
                      if [ "${expansaoDecimal:7:1}" -eq "${expansaoDecimal:13:1}" ]; then
                        if [ "${expansaoDecimal:8:1}" -eq "${expansaoDecimal:12:1}" ]; then
                          if [ "${expansaoDecimal:9:1}" -eq "${expansaoDecimal:11:1}" ]; then

                            echo "impar ${expansaoDecimal::21} umincremento $umIncremento " | tee -a r_palind_primos_expansao.txt
                            read -p "achou palindromo... press enter para continuar"
                            echo piIncremento ${piIncremento}
                            echo umIncremento ${umIncremento}
                            testaPrimo ${expansaoDecimal::21}
                            echo $testaPrimoResult
                            if [ $testaPrimoResult -eq 1 ]; then
                              echo "entrou no if do testa primo"
                              echo "${expansaoDecimal::21} foi encontrado no arquivo."
                              echo "${expansaoDecimal::21} eh o primeiro palindromo primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
                              exit
                            fi
                            echo "passou do if testa primo"
                            echo "${expansaoDecimal::21} eh palindromo porem nao primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
                            sleep 1
                            read -p "achou palindromo... press enter para continuar"
                          fi
                        fi
                      fi
                    fi
                  fi
                fi
              fi
            fi
          fi
        fi

      else
         echo -n "par   ${expansaoDecimal::21} umincremento $umIncremento "
      fi
      expansaoDecimal=${expansaoDecimal:1}
      read -p ""

    done

  done

}

# echo "range de primos iniciais a descobrir:"
primosiniciais=177823
# echo "informe o primeiro numeral a fazer buscas: "
sequenciainicial=10000000000000000000
# "informe o ultimo numeral a fazer buscas: "
sequenciafinal=999999999999999999999

# descobrePrimosIniciais
# gerarMultiplosSelecionadosExclusivos
# procuraPalindromoExpansaoDecimal
consultarArquivoOffline