#!/bin/bash

#######################################
# 指定位置にピースを置く.
# Globals:
#   frame - 現在の盤面ファイル
# Arguments:
#   $1 - 開始行番号
#   $2 - 開始カラム番号
#   $3 - ピースファイル
# Outputs:
#   ピース置いた結果の盤面
#######################################
function setPiece() {
    echo $1, $2, $3
    local offsetRow=$1
    local offsetCol=$2
    local pieceFile=$3
    cat frame | awk -v offsetRow=${offsetRow} -v offsetCol=${offsetCol} -v pieceFile=${pieceFile} '
    BEGIN {
        offsetCol=offsetCol-1
    }
    NR<offsetRow
    NR>=offsetRow{
    if ((getline piece < pieceFile) > 0)  {
        count = split(piece, pieces);
        for (i = 1; i <= count; i ++) {
            $(i+offsetCol) = ($(i+offsetCol) + pieces[i]);
        }
        print;
    } else {
        print;
    }
    }' > nextFrame
}

function createFrame() {
    # stub
    cat frame.txt > frame
}

function main() {
    createFrame
    setPiece 2 3 "piece/1/1.txt"
}

main
