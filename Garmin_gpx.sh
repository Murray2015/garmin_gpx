#!/bin/bash -x

## This script calls the python script garmin_gpx.py, which outputs the gpx file to a csv format, and this script then calls GMT to make maps and output basic statistics for the journey.

# Take command line argument
infile=$1

# Run python script
./garmin_gpx.py $infile

datfile="temp.csv"
basemap="/home/murray/Documents/Work/global_data/ETOPO1_Ice_g_gmt4.grd"
rgn=`gmtinfo temp.csv -I0.001 -i2,1`
prj="-JM6i"
mapfile="map.ps"
scalelat=`gmtinfo temp.csv -I0.001 -i2,1 | awk 'BEGIN{FS="/"}{print $3}'`

grdimage $basemap $rgn $prj -Cetopo1 -P -K > $mapfile
pscoast $prj $rgn -Ia -Df -Lx5.5i/0.5i+c${scalelat}+w2.5k -K -O >> $mapfile
psxy $datfile -Wred $prj $rgn -i2,1 -B0.1 -O >> $mapfile
evince $mapfile
