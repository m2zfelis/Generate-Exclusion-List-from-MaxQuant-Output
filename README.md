# Generate-Exclusion-List-from-MaxQuant-Output
Imports the msms.txt file from MaxQuant to generate an exclusion list for data-dependent mass spectrometry experiments. This can be imported into Xcalibur methods.

There are two files:

 - exclusion_list.R
    * This is the main R script for generating the exclusion list. Note that this script is for TMT 6-plex experiments, and will not work for other N-plexes, nor will it work for other quantitation approaches.
 - Mass List Table.csv
    * This is a template for the Xcalibur exclusion list format. Any changes to the Xcalibur format may require modification of the script as well as this template file.
