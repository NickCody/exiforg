#!/bin/bash

if [ $# -eq 0 ]; then
    echo "exiforg [-m] -f filespec"
    echo "  -f filespec   Specifies files to be affected"
    echo "  -m            Optional. Specifies file should be moved into dated dir. "
    exit 1
fi

MOVE=0
FILESPEC=""
while getopts ":m :f:" opt; do
    case $opt in
        m)
            MOVE=1
            ;;
        f)
            FILESPEC="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
              echo "Option -$OPTARG requires an argument." >&2
              exit 1
              ;;
    esac
done

if [ -z "$FILESPEC" ]; then
    FILESPEC="*.MTS"
fi

for PIC in $FILESPEC
do
    MESSAGE=""
    #
    # Get the Date from the file. Try a few things. Fail if you can't get it.
    #
    DATETIME=`exiftool -p '$DateTimeOriginal' $PIC 2> /dev/null | sed 's/[: ]//g' | cut -d- -f1`
    if [ -z "$DATETIME" ]; then
        DATETIME=`exiftool -p '$TrackCreateDate' $PIC 2> /dev/null | sed 's/[: ]//g' | cut -d- -f1`
        if [ -z $DATETIME ]; then
            echo "Could not find date in ${PIC}, skipping."
            continue
        fi
    fi
    DATE="${DATETIME:0:4}.${DATETIME:4:2}.${DATETIME:6:2}"
    MESSAGE="${MESSAGE} Changing date on ${PIC} to ${DATE}"
    touch -t $(echo $DATETIME | sed 's/\(..$\)/\.\1/') $PIC

    #
    # Move if -m specified
    #
    if [ $MOVE == 1 ]; then
        mkdir -p $DATE
        if [ -e $DATE/$PIC  ]; then
            MESSAGE="${MESSAGE}, appending datetime because dest exists"
            FILENAME=${PIC%.*}-$DATETIME.${PIC##*.}
        else
            FILENAME=$PIC
        fi
        MESSAGE="$MESSAGE, moving to $DATE/"
        mv $PIC $DATE/$FILENAME 
    fi

    echo $MESSAGE
done
