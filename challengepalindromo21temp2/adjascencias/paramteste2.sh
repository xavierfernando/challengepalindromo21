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

func6
