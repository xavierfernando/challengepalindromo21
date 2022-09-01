#!/bin/bash
declare -i i=10
filename="r_palind_primos.txt"
# rm -f r_palind_primos_expansao.txt

while :; do
    if [[ $i -lt 999999999 ]]; then
        echo imprimindo numeral de 9 digitos das posicoes $(($i - 9)) a $(($i - 1)) da expansao decimal.
        deslocamento=$(expr $i - 9)
        
        expansaoDecimal=$(echo $(pi $i) | cut -d'.' -f 2)
        
        expDecimalNoveDigitos=$(echo "${expansaoDecimal}" | cut -c "${deslocamento}"-)
        echo $expDecimalNoveDigitos
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

                            for ((j = 8; j >= 0; j--)); do
                                
                                revExpDecNoveDigitos="$revExpDecNoveDigitos${expDecimalNoveDigitos:$j:1}"
                            done
                            if [[ "$revExpDecNoveDigitos" == "$expDecimalNoveDigitos" ]]; then
                                echo $expDecimalNoveDigitos e $revExpDecNoveDigitos sao palindromos
                                echo posicoes $(($i - 9)) a $(($i - 1)) da expansao decimal $expDecimalNoveDigitos >>r_palind_primos_expansao.txt
                                
                                
                                while IFS= read -r line; do
                                    if [ $line -eq $expDecimalNoveDigitos ]; then
                                        echo $line foi encontrado no arquivo.
                                        echo "${line} eh o primeiro palindromo primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
                                        exit
                                    fi
                                done <"$filename"
                                echo "${expDecimalNoveDigitos} eh palindromo porem nao primo de 9 digitos da expansao decimal de PI" | tee -a r_palind_primos_expansao.txt
                            fi
                            revExpDecNoveDigitos=""
                            sleep 1
                        fi
                    fi
                fi
            fi
        fi

        ((i++))
        echo
        echo
    else
        break
    fi
done
