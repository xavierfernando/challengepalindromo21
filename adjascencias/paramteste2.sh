func5() {

    for ((i = 1; i <= 1000000; i += 999)); do

        urlpi=$(printf "https://api.pi.delivery/v1/pi?start=%s&numberOfDigits=999&radix=10" $i)

        echo $urlpi

    done

    echo $urlpi final
    curl -s "${urlpi}" | cut -d '"' -f 4

    curl -s "https://api.pi.delivery/v1/pi?start=1&numberOfDigits=9&radix=10" | cut -d '"' -f 4

    curl -s "https://api.pi.delivery/v1/pi?start=10&numberOfDigits=9&radix=10" | cut -d '"' -f 4

    curl -s "https://api.pi.delivery/v1/pi?start=19&numberOfDigits=9&radix=10" | cut -d '"' -f 4

    curl -s "https://api.pi.delivery/v1/pi?start=1&numberOfDigits=90&radix=10" | cut -d '"' -f 4

}

func6() {

    numerosAcortar=3

    str="price: 9832.3"
    echo "${str:7}"

    echo "${str:${numerosAcortar}}"

}

func7() {
    rm -f teste.txt
    #   read -p "Press Enter to contine 2"
    # echo $r
    r=$(echo "sqrt(999999999999999999999)" | bc)
    declare -a arr
    echo $r
    # sleep 1
    while read -r k; do
        # echo k $k
        # sleep 1
        if [ $k -lt $r ]; then
            echo $k e $r k e r
            # sleep 1
            # echo $k 2>&1 | tee -a ${file_r_multiplos_selecionados}
            for ((m = 3; l < r; m += 2)); do
                # echo m $m
                l=$(($k * $m))
                if [ $(expr $l % 5) -ne 0 ] && [ $l -le $r ]; then
                #   echo l $l   
                    arr+=($l)
                    sleep 1 
                #   echo $l 2>&1 | tee -a ${file_r_multiplos_selecionados}
                fi
                
            done
            l=1
        fi
    done <../temp_02_primos_iniciais.txt
        for ELEMENT in ${arr[@]}; do
            echo $ELEMENT >> teste.txt
        done

        

    #   sort -g "${file_r_multiplos_selecionados}" | uniq >"${file_r_multiplos_selecionados_ordenados_exclusivos}"

    #   read -p "Press Enter to contine 3"

}

func7
