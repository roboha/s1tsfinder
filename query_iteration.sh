#!/bin/bash

# utilizes a modified version of Sentinel_download.py
# this one generates multiple query.xmls for every
# 100 entries (maximum query number)

export outfile=annual.geojson
python Sentinel_download.py --latmin -15 --latmax -5 --lonmin -60 --lonmax -45 -a ~/opt/Sentinel-download/apihub.txt -n -s S1A_IW_GRD*2016$m*

allqueries=$(ls *xml)

echo '{ "type": "FeatureCollection",' >> $outfile
echo '"features": [' >> $outfile

for x in $allqueries
do
	export xmlfile=$x
	bash replacenotes.sh
done

sed -i '$ s/.$//' $outfile
echo ']}' >> $outfile

rm query*xml
