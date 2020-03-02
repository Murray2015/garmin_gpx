# garmin_gpx
This is a command line shellscript to take a gpx file from an Garmin etrex10 hand held GPS unit, process the file to extract tracks, and make a quick map of the gps track.

## Usage
At the bash command line, run
`./Garmin_gpx.sh [gpx_file] [topography_NetCDF_grid_file]`

## Outputs
gps_track.csv - .csv file of the processed data, for further mapping in a GIS program
map.ps - quick map to show results, only really appropriate for QC (use a full featured GIS for mapping).

## Dependencies
- Bash
- Generic Mapping Tools
- Python3
- python3-gpxpy
- Numpy
- Pandas
- evince 
