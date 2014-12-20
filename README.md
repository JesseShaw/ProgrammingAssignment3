This file describes the files found in this repo and what they contain.

run_analysis.R: this is the R script that will reconstitute the raw data found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This script assumes the data sets are unzipped and located in R's working directory.  
(The folder name UCI HAR Dataset should be located in R's working directory.)

CodeBook.md describes in detail the origin of the raw data, the transformations the script
executes, and the data dictionary of the resulting file.

SCRIPT SUMMARY
First, the script will load non-standard libraries and set a working directory variable.
Second, the script will read in all six data files and row bind them.
Third, the script will read in the feature data and select only the columns with 
'mean' or 'std' in the name.
Fourth, the script will filter the main data sets down to the 'mean' and 'std' fields.
Fifth, the script adds readable field names as found in the 'activity_labels.txt' file.
Sixth, the script updates the 'activity' and 'subject' column field names.
Seventh, the script column binds all of the data parts together.
Eighth, the script calculates the averages for the measurements, by subject, by activity.
Finally, the script writes out the tidy data!