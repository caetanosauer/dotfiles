#!/bin/bash

LAYOUT=$(setxkbmap -query | awk 'BEGIN{l=""} /^layout/{l=$2} END{print l}')
VARIANT=$(setxkbmap -query | awk 'BEGIN{v=""} /^variant/{v=$2} END{print v}')

NEXT_LAYOUT=$LAYOUT
NEXT_VARIANT=$VARIANT
if [[ "$LAYOUT-$VARIANT" == "us-" ]]; then
    NEXT_LAYOUT=us
    NEXT_VARIANT=intl
elif [[ "$LAYOUT-$VARIANT" == "de-" ]]; then
    NEXT_LAYOUT=us
    NEXT_VARIANT=
elif [[ "$LAYOUT-$VARIANT" == "us-intl" ]]; then
    NEXT_LAYOUT=gb
    NEXT_VARIANT=intl
elif [[ "$LAYOUT-$VARIANT" == "gb-intl" ]]; then
    NEXT_LAYOUT=de
    NEXT_VARIANT=
else
    NEXT_LAYOUT=de
    NEXT_VARIANT=
fi

setxkbmap -model pc105 -layout "$NEXT_LAYOUT" -variant "$NEXT_VARIANT"
