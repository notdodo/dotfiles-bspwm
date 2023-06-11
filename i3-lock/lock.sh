#!/bin/bash
rectangles=" "

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in ${SR}; do
  SRA=("${RES//[x+]/ }")
  CX=$(("${SRA[2]}" + 25))
  CY=$(("${SRA[1]}" - 80))
  rectangles+="rectangle $CX,$CY $((CX+250)),$((CY-80)) "
done

TMPBG=/tmp/.screen.png
maim $TMPBG && convert $TMPBG -scale 5% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG

i3lock \
  -i $TMPBG \
  --time-pos="x+100:h-100" \
  --date-pos="x+100:h-80" \
  --clock --date-str="%A %d %B" \
  --line-uses-inside \
  --keyhl-color="1976D2FF" --bshl-color=d23c3dff --separator-color=00000000 \
  --ind-pos="x+225:h-102" \
  --radius=22 --ring-width=3 --verif-text="" --wrong-text="" --verif-size=50 --wrong-size=50  \
  --color="ffffffff" --time-color="ffffffff" --date-color="ffffffff" \
  --inside-color="00000000" --ring-color="ffffffff" \
  --insidever-color="FFEB3BFF" --insidewrong-color="d23c3dff" \
  --ringver-color="FFEB3BFF" --ringwrong-color="d23c3dff" \
  --noinput-text "" --pass-media-keys --pass-volume-keys
  --no-modkeytext

rm $TMPBG
