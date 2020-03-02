#!/usr/bin/env python3

import gpxpy
import numpy as np
import pandas as pd
import sys

gpx_file = open(sys.argv[1], 'r')
gpx = gpxpy.parse(gpx_file)
track_coords = []

for track in gpx.tracks:
	for segment in track.segments:
		for point in segment.points:
			track_coords.append((point.latitude, point.longitude, point.elevation, point.time))

garmin_track = pd.DataFrame(track_coords, columns=['Latitude','Longitude','Elevation','Time'])

## Find the smallest and greatest coordinates
maxlat = np.max(garmin_track.Latitude)
maxlong = np.max(garmin_track.Longitude)
minlat = np.min(garmin_track.Latitude)
minlong = np.min(garmin_track.Longitude)

print(maxlat, maxlong, minlat, minlong)
garmin_track.to_csv('gps_track.csv')
