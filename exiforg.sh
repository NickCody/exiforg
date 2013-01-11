#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

for PIC in $*; do
    DATETIME=`exiftool -p '$DateTimeOriginal' $PIC 2> /dev/null | sed 's/[: ]//g' | cut -d- -f1`
    if [ -z "$DATETIME" ]; then
        DATETIME=`exiftool -p '$TrackCreateDate' $PIC 2> /dev/null | sed 's/[: ]//g' | cut -d- -f1`
        if [ -z $DATETIME ]; then
            echo "Could not file date in ${PIC}"
            exit 1
        fi
    fi
    DATE="${DATETIME:0:4}.${DATETIME:4:2}.${DATETIME:6:2}"
    echo $PIC - $DATE
    touch -t $(echo $DATETIME | sed 's/\(..$\)/\.\1/') $PIC
    mkdir -p $DATE
    if [ -e $DATE/$PIC  ]; then
        echo "Warning, ${DATE}/${PIC} exists, appending datetime to filename"
        FILENAME=${PIC%.*}-$DATETIME.${PIC##*.}
    else
        FILENAME=$PIC
    fi
    mv $PIC $DATE/$FILENAME 
done
