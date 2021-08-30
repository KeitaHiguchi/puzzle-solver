#!/bin/bash

kaiten() {
    tac ${1} | rs -T | sed 's/  / /g'
}

make4ptn() {
    # 全方向回転
    #for i in {1..3}; do
    local i
    for ((i=${2}; i < ${3}; i++)); do
        cat ${1}/$i.txt | kaiten > ${1}/$((i+1)).txt
    done
}

make8ptn () {
    rm -rf ${1}
    mkdir ${1}
    cat base${1}.txt > ${1}/1.txt

    make4ptn ${1} 1 4

    # 裏返し
    cat base${1}.txt > ${1}/5.txt
    make4ptn ${1} 5 8
}

main() {
    local i
    for i in {1..12}; do
        make8ptn ${i}
    done
}


main
