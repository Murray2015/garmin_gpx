#!/bin/bash -x

## This script calls the python script garmin_gpx.py, which outputs the gpx file to a csv format, and this script then calls GMT to make maps and output basic statistics for the journey.

# Take command line argument
infile=$1

# Run python script
./garmin_gpx.py $infile

datfile="temp.csv"
rgn=`gmtinfo temp.csv -I0.001 -i1,2`
prj="-JM3i"
mapfile="map.ps"

psxy $datfile -Wred $prj $rgn -P -i1,2 -B0.1 > $mapfile
evince $mapfile
