# s1tsfinder

Tool for the specific purpose of finding areas which guaranteed monthly
Sentinel-1 coverage.

## Inputs

- Requires as input a .GeoJSON file containing all scenes to eintegrate.
- Also recommended is adjustment of buffer radius to determine the degree of
overlap.

## Output

 - A set of .GeoJSON files containing 12 polygons each. These polygons are
 the swaths of the most adequate scenes to guarantee a monthly coverage with
 their associated filenames. Multiple files are generated to address the
 different subregions of the study area.

## Limitations

 - Purpose right now is to just address monthly coverage.
 - An exemplary script is also provided to generate an  input file from a 
   dhus xml query (replacenotes.sh).
 - If a certain point is covered by, e.g., 30 scenes p.a., the number of
 potential monthly subsets (with 1 scene per month) is very large. Intersecting
 areas for *all* these subsets are calculated to recommend the scenes of largest
 coverage. Bring some patience.
