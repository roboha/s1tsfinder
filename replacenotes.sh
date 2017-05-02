#!/bin/bash

echo $xmlfile

cat $xmlfile | grep -o 'POLYGON ((.*))' | sed 's/(/[/g' | sed 's/)/]/g' | sed 's/,/],[/g' | sed 's/ /,/g' | sed 's/POLYGON,//g' | sed 's/]]/]]]/g' | sed 's/\[\[/\[\[\[/g' > polygons.txt
sed -n 's/.*ingestiondate">\(.*\)/\1/p' $xmlfile | cut -f1 -dT > ingestions.txt
sed -n 's/.*filename">\(.*\)/\1/p' $xmlfile | cut -f1 -d\< > filenames.txt

NUMBER_POLYGONS=$(wc -l < ingestions.txt)

for (( i=1; i<=$NUMBER_POLYGONS; i++ ))
do
	date=$(sed -n $i'p' ingestions.txt)
	fn=$(sed -n $i'p' filenames.txt)
	poly=$(sed -n $i'p' polygons.txt)

	echo '{ "type": "Feature",' >> $outfile
	echo '"geometry": {' >> $outfile
	echo '"type": "Polygon",' >> $outfile
	echo '"coordinates": '$poly >> $outfile
	echo '},' >> $outfile
	echo '"properties": {' >> $outfile
	echo '"date": "'$date'",' >> $outfile
	echo '"filename": "'$fn'"' >> $outfile
	echo '}},' >> $outfile
done
rm ingestions.txt filenames.txt polygons.txt
