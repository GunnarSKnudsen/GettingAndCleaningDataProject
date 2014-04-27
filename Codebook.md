
## Scripts:
* downloadData.R
* run_analysis.R

### downloadData.R
contains script to download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
File is no longer in use - data is now downloaded directly in run_analysis.R.

### run_analysis.R
line 1:3: Sets workpath and loads needed packages.
line 6:16: Fetches data
line 20: Reads variable names ("Features")
line 23: Reads activities

line 31:32: reads test data and adds column names.
line 34: Reads only data which is mean or STD

line 37:38: Reads Test subjects
line 42:44: Reads activities, and sets descriptive activity names to be used in dataframe from hereon.

line 49:65: Does the same thing but for training variables.

line 69:77: Merges all read data into one nicely formatted data.frame
line 82:90: Merges all read data, which includes mean and STD's into one nicely formatted data.frame.


line 96:115: Writes four csv files:
* mergedData.csv
* mergedData_MeanSTD.csv
* tidy.csv
* tidty_MeanSTD.csv

### mergedData.csv
size: 10299 x 564
Contains all data

### mergedData_MeanSTD.csv
10299 x 69
Contains all data which is relevant for Means and STD

### tidy.csv
180 x 480
Contains Mean for all variables, for each activity and subject


### tidy_MeanSTD.csv
180 x 69
Contains Mean for all variables relevant for means and STD, for each activity and subject

See the features.txt file for variable names
