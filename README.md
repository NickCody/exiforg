# exiforg

_An tiny organizational tool for media files_

Supports Adobe DNG, MTS, and M4V files. Depends on the excellent [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/ exiftool) by Phil Harvey.

Will move files into dated directory and touch files with datetime contained in the underlying EXIF data.
Will not overwrite original filename during move, but will append datetimestamp
If filename with appended datetimestamp is encountered, it will be overwritten. The assumption here is that the file should be the same. 

Use at your own risk!

Report problems to nick at primordia dot com

## Description

exiforg now handles DNG files, MTS files, and M4V files. Say you have a dir of new MTS files:

    /Volumes/CAVE3/AVCHD/00000.MTS
    /Volumes/CAVE3/AVCHD/00001.MTS
    /Volumes/CAVE3/AVCHD/00002.MTS

And you want these moves into a folder for the EXIF date. You just run this command:

    exiforg.sh *.MTS

Your new layout will be:

    /Volumes/CAVE3/AVCHD/2012.12.23/00000.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00001.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00002.MTS

And each file is touched with the EXIF timestamp, regardless of the OS timestamp currently there. The OS timestamp is when you imported the photos. Say you Clear the movies from your camera, and take 3 more on the same day:

    /Volumes/CAVE3/AVCHD/00000.MTS
    /Volumes/CAVE3/AVCHD/00001.MTS
    /Volumes/CAVE3/AVCHD/00002.MTS

If you run the command again, you would think I would overwrite the file. Well, exiforg doesn't. I see the dest file exists and I add a date & time stamp to the new one, like so:

    exiforg.sh *.MTS

    /Volumes/CAVE3/AVCHD/2012.12.23/00000.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00001.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00002.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00000-20121223155456.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00001-20121223155600.MTS
    /Volumes/CAVE3/AVCHD/2012.12.23/00002-20121223155910.MTS

If you do this AGAIN, then the files with the timestamp will get overwritten. But they should be the same file so it should not matter. A true duplicate.

This all works for DNG files. For M4V files, I had to use a different tag, but it works.

I'd run it on some test files before risking your real files, until you get what it's doing.



