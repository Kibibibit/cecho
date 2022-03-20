#!/bin/bash

usage(){
  echo "Usage:"
  echo "  $0 <args>"
  echo ""
  echo "Options:"
  echo "  -h       : Shows this help message"
  echo "  -f       : Indicated that this colour is a foreground colour"
  echo "  -c colour: Used to pass in the colour name to convert"
  echo "  -l       : Gives the list of colours that can be used. Will not work if cecho is not installed!"
  echo ""
  exit
}

declare -a colours

dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

colours=(
    "black"
    "red"
    "green"
    "orange"
    "blue"
    "magenta"
    "cyan"
    "lightgray"
    "gray"
    "darkred"
    "darkgreen"
    "yellow"
    "darkblue"
    "purple"
    "darkcyan"
    "white"
)


list(){
    echo "--Colour Codes--"
    for c in "${colours[@]}"
    do
        fgbg=${colours[0]}
        bgfg=${colours[15]}
        if [ "$c" = "${colours[7]}" ] || [ "$c" = "${colours[15]}" ]
        then
            bgfg=${colours[0]}
        fi

        if [ "$c" = "${colours[0]}" ]
        then
            fgbg="${colours[15]}"
        fi
        out=`cecho -b $fgbg -f $c $c`
        out="$out `cecho -b $c -f $bgfg $c`"
        echo -e $out
    done
    exit

}

declare -A fgcolours

fgcolours=(
    [${colours[0]}]="30"
    [${colours[1]}]="31"
    [${colours[2]}]="32"
    [${colours[3]}]="33"
    [${colours[4]}]="34"
    [${colours[5]}]="35"
    [${colours[6]}]="36"
    [${colours[7]}]="37"
    [${colours[8]}]="90"
    [${colours[9]}]="91"
    [${colours[10]}]="92"
    [${colours[11]}]="93"
    [${colours[12]}]="94"
    [${colours[13]}]="95"
    [${colours[14]}]="96"
    [${colours[15]}]="97"
)

declare -A bgcolours

bgcolours=(
    [${colours[0]}]="40"
    [${colours[1]}]="41"
    [${colours[2]}]="42"
    [${colours[3]}]="43"
    [${colours[4]}]="44"
    [${colours[5]}]="45"
    [${colours[6]}]="46"
    [${colours[7]}]="47"
    [${colours[8]}]="100"
    [${colours[9]}]="101"
    [${colours[10]}]="102"
    [${colours[11]}]="103"
    [${colours[12]}]="104"
    [${colours[13]}]="105"
    [${colours[14]}]="106"
    [${colours[15]}]="107"
)

colour=""
fg="BG"

while getopts "hflc:" opt
do

  case $opt in
    f)
      fg="FG"
      ;;
    c)
      colour=$OPTARG >&2
      ;;
    l)
      list
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done


if [ "$fg" = "FG" ]
then
    echo ${fgcolours[$colour]}
else
    echo ${bgcolours[$colour]}
fi