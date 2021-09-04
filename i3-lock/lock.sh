#!/bin/bash
rectangles=" "

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in ${SR}; do
  SRA=("${RES//[x+]/ }")
  CX=$(("${SRA[2]}" + 25))
  CY=$(("${SRA[1]}" - 80))
  rectangles+="rectangle $CX,$CY $((CX+250)),$((CY-80)) "
done

TMPBG=/tmp/screen.png
maim $TMPBG && convert $TMPBG -scale 5% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG

i3lock \
  -i $TMPBG \
  --time-pos="x+90:h-101" \
  --date-pos="tx-0:ty+25" \
  --clock --date-str="%A %d %B" \
  --line-uses-inside \
  --keyhl-color=d23c3dff --bshl-color=d23c3dff --separator-color=00000000 \
  --ind-pos="x+190:h-99" \
  --radius=20 --ring-width=3 --verif-text="" --wrong-text="" \
  --color="ffffffff" --time-color="ffffffff" --date-color="ffffffff" \
  --inside-color="00000000" --ring-color="ffffffff" \
  --insidever-color="fecf4dff" --insidewrong-color="d23c3dff" \
  --ringver-color="fecf4dff" --ringwrong-color="d23c3dff"

rm $TMPBG