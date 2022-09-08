func1() {
    ret_val=hi
}

func2() {
    ret_val=bye
    echo $1
}

func3() {
    local ret_val=nothing
    echo $ret_val
    func1
    echo $ret_val
    func2
    echo $ret_val
}

func3

echo $ret_val

A="global"
B="global"

criarArquivo() {
printf -v file_"${1}" "${1}".txt
echo $file_palind
echo oi
}


func5() {
 criarArquivo palind

 echo $file_palind
 
  sufix=mooca
 printf -v file_"${sufix}" "${sufix}"txt 
echo $file_mooca


ariana=grande


}


func5 
echo $file_palind
echo oi3
echo $file_mooca

func6() {
   echo 6a
   echo $file_mooca
   


    func5

    echo 6b

    echo $file_mooca
}

func6