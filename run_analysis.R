##This script will ingest raw data and conform it to tidy data standards
##1 Merges the training and the test sets to create one data set.
##2 Extracts only the measurements on the mean and standard deviation for each measurement. 
##3 Uses descriptive activity names to name the activities in the data set
##4 Appropriately labels the data set with descriptive variable names. 
##5 From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.

##STEP0 - Initialization
#Load required libraries
library(plyr)
library(dplyr)

#Set working directory
wd <- getwd()

##STEP1 - Merge all files##################################
##Read all files
x_train_set     <- read.table(file.path(wd,"UCI HAR Dataset/train/X_train.txt"))
y_train_set     <- read.table(file.path(wd,"UCI HAR Dataset/train/y_train.txt"))
sub_train_set   <- read.table(file.path(wd,"UCI HAR Dataset/train/subject_train.txt"))
x_test_set      <- read.table(file.path(wd,"UCI HAR Dataset/test/X_test.txt"))
y_test_set      <- read.table(file.path(wd,"UCI HAR Dataset/test/y_test.txt"))
sub_test_set    <- read.table(file.path(wd,"UCI HAR Dataset/test/subject_test.txt"))

#Join datasets
x_data_set      <- rbind(x_train_set, x_test_set)
y_data_set      <- rbind(y_train_set, y_test_set)
sub_data_set    <- rbind(sub_train_set, sub_test_set)

##STEP2 - Extract fields###################################
#Read in table with features
features <- read.table(file.path(wd,"UCI HAR Dataset/features.txt"))

#Select columns with mean or std function names in the column names
reducedColumns <- grep("-(mean|std)\\(\\)", features[, 2])

#Create a subset with the selected columns
x_data_set <- x_data_set[, reducedColumns]

#Update the column names
names(x_data_set) <- features[reducedColumns, 2]

#Clean up the column names
names(x_data_set) <- gsub("\\(\\)", "", names(x_data_set))

##STEP3 - Append activity names to the data set############
#Read in table with activity names
act_names <- read.table(file.path(wd,"UCI HAR Dataset/activity_labels.txt"))

#Update data set with activity names (make it readable)
y_data_set[, 1] <- act_names[y_data_set[, 1], 2]

#Update column name
names(y_data_set) <- "activity"

##STEP4 - Improve variable names###########################
#Update column name
names(sub_data_set) <- "subject"

#Column bind all the data sets into one
full_data <- cbind(sub_data_set, y_data_set, x_data_set)

##STEP5 - Create 'TIDY' data set
#Calculate required averages for each subject per activity
data_aves <- ddply(full_data, .(subject, activity), function(x) colMeans(x[, 3:68]))

#Write output suppressing the row number
write.table(data_aves, file.path(wd,"data_aves.txt"), row.name=FALSE)