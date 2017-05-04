#!/bin/bash

echo $xmlfile

cat $xmlfile | grep -o 'POLYGON ((.*))' | sed 's/(/[/g' | sed 's/)/]/g' | sed 's/,/],[/g' | sed 's/ /,/g' | sed 's/POLYGON,//g' | sed 's/]]/]]]/g' | sed 's/\[\[/\[\[\[/g' > polygons.txt
#sed -n 's/.*link href=\(.*\)/\1/p' $xmlfile | cut -f1 -d\/\< > uuids.txt
sed -n 's/.*link href="\(.*\)/\1/p' $xmlfile | sed 's/"\/>//g' > uuids.txt
cat uuids.txt
sed -n 's/.*filename">\(.*\)/\1/p' $xmlfile | cut -f1 -d\< > filenames.txt

NUMBER_POLYGONS=$(wc -l < uuids.txt)
echo ui
wc -l < uuids.txt
echo fn
wc -l < filenames.txt

for (( i=1; i<=$NUMBER_POLYGONS; i++ ))
do
	uuid=$(sed -n $i'p' uuids.txt)
	fn=$(sed -n $i'p' filenames.txt)
	poly=$(sed -n $i'p' polygons.txt)

	echo '{ "type": "Feature",' >> $outfile
	echo '"geometry": {' >> $outfile
	echo '"type": "Polygon",' >> $outfile
	echo '"coordinates": '$poly >> $outfile
	echo '},' >> $outfile
	echo '"properties": {' >> $outfile
	echo '"uuid": "'$uuid'",' >> $outfile
	echo '"filename": "'$fn'"' >> $outfile
	echo '}},' >> $outfile
done
rm uuids.txt filenames.txt polygons.txt
