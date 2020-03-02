#!/bin/bash

## This script calls the python script garmin_gpx.py, which outputs the gpx file to a csv format, and this script then calls GMT to make maps and output basic statistics for the journey.

# Take command line argument
infile=$1
basemap=$2

# Run python script
./garmin_gpx.py $infile

# Preprocess data file
awk -F"," '{if(NR>2)print $0}' < gps_track.csv > temp_processed.csv
datfile="temp_processed.csv"
rgn=`gmtinfo -i2,1 -I0.001 temp_processed.csv`
prj="-JM6i"
mapfile="map.ps"
scalelat=`gmtinfo temp_processed.csv -I0.001 -i2,1 | awk 'BEGIN{FS="/"}{print $3}'`

grdimage $basemap $rgn $prj -Cetopo1 -P -K > $mapfile
pscoast $prj $rgn -Ia -Df -Lx5.5i/0.5i+c${scalelat}+w2.5k -K -O >> $mapfile
psxy $datfile -Wred $prj $rgn -i2,1 -By0.1 -Bx0.2 -O >> $mapfile
rm temp_processed.csv
evince map.ps
