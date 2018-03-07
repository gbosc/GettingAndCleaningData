
##########################################################################################
## Course: Getting And Cleaning Data
## Week 4: Project Assignment
## Student: Gilles Bosc
##   The purpose of this project assignment is to download a dataset of data collected
##   from the accelerometers from the Samsung Galaxy 5 smartphone; unzip the dataset;
##   merge the training and test datasets into a single dataset. 
##
##   The new single dataset should be tidy and have the following characteristics:
##   1) It should only contain the 'mean' and 'standard deviation' measurements
##   2) The activities in the dataset should have descriptive activity names
##   3) The dataset columns should have descriptive variable names
##   
##   Then, using the dataset created above, create a new independent tidy dataset that
##   contains "the average of each variable for each activity and each subject".
##  
##   The Project Assignment outputs should be as follows:
##   a) A Github repo, containing the following files:
##        i) A codebook file called "CodeBook.md"
##       ii) A "README.md" file
##      iii) A script file named "run_analysis.R"
##
##########################################################################################

## Step 1: download the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip")

## Step 2: Unzip the dataset.
unzip("dataset.zip", unzip="internal")

## Step 3: Navigate to the correct location and read the "X_test.txt", "y_test.txt" and "subject_test.txt" datasets into R
setwd("./UCI HAR Dataset/test")

## Note: X_test is a data frame containing 2947 observations of 561 variables (the measurements)
X_test <- read.table("X_test.txt")

## Note: y_test is a data frame containing 2947 observations of 1 variable (the activity). 
## There are 6 possible values: 1, 2, 3, 4, 5, 6
y_test <- read.table("y_test.txt")

## Note: subject_test is a data frame containing 2947 observations of 1 variable (the subject)
## The possible subject values are: 1 to 30
subject_test <- read.table("subject_test.txt")

## Step 4: Navigate to the correct location and read the "X_train.txt", "y_train.txt" and "subject_train.txt" datasets into R
setwd("../train")

## Note: X_train is a data frame containing 7352 observations of 561 variables (the measurements)
X_train <- read.table("X_train.txt")

## Note: y_train is a data frame containing 7352 observations of 1 variable (the activity). 
## There are 6 possible values: 1, 2, 3, 4, 5, 6
y_train <- read.table("y_train.txt")

## Note: subject_train is a data frame containing 7352 observations of 1 variable (the subject)
## The possible subject values are: 1 to 30
subject_train <- read.table("subject_train.txt")

## Step 5: Navigate to the correct location and read the "activity_labels.txt" and "features.txt" datasets into R
setwd("..")

## Note: activity_label is a data frame with 6 rows and 2 columns. 
## Column V1 is the activity number, column V2 is the activity description.
activity_labels <- read.table("activity_labels.txt")

## Note: features is a data frame with 561 rows and 2 columns. 
## Column "V2" contains the names of the columns in the X_test and X_train datasets.
features <- read.table("features.txt")

## Step 6: fix the variable names in some of the data frame datasets in R
colnames(activity_labels) <- c("activityid", "activityname")

colnames(subject_test) <- c("subjectid")
colnames(subject_train) <- c("subjectid")

colnames(y_test) <- c("activityid")
colnames(y_train) <- c("activityid")

## Prepare a list of all the measure variable names.
## Remove the following special characters from the variable names: (),- 
allmeasurenames <- features$V2
allmeasurenames <- gsub("-", "", gsub("(", "", allmeasurenames, fixed=TRUE))
allmeasurenames <- gsub(",", "", gsub(")", "", allmeasurenames, fixed=TRUE))

## fix the variable names in the two main data frame datasets in R
colnames(X_test) <- allmeasurenames
colnames(X_train) <- allmeasurenames

## Step 7: get the list of just the mean() and std() variable names.
## In the first step, get all variable names that have either 'mean' or 'std'.
## In the second step we need to remove the variable names that contain 'meanFreq'.
## In steps 3, 4 and 5, remove the special characters: ()-
keepmeasurenames <- grep("-std|-mean", features$V2, value=TRUE)
keepmeasurenames <- grep("-std|-mean", features$V2, value=TRUE)[!grepl("meanF", keepmeasurenames)]
keepmeasurenames <- gsub("(", "", keepmeasurenames, fixed=TRUE)
keepmeasurenames <- gsub(")", "", keepmeasurenames, fixed=TRUE)
keepmeasurenames <- gsub("-", "", keepmeasurenames, fixed=TRUE)

## Step 8: reduce the size of the X_test and X_train datasets to just the mean and std columns
X_test <- X_test[,keepmeasurenames]
X_train <- X_train[,keepmeasurenames]

## Step 9: use the cbind function to combine the 3 test datasets together and the 3 train datasets together
X_test <- cbind(subject_test, y_test, X_test)
X_train <- cbind(subject_train, y_train, X_train)

## Step 10: use the rbind function to combine the test and train datasets together
## into a single dataset.
X_combined <- rbind(X_test, X_train)

## Step 11: Use the functions from the dplyr package to merge the X_combined measures dataset to
## the activity_labels dataset in order to pull in the activityname.

## Load in the 'dplyr' package
library(dplyr)

## Use the 'tbl_df' function to change the dataformat of the X_combined and activity_labels datasets so that 
## functions such as 'merge' and group_by can be used.
X_combined <- tbl_df(X_combined)
activity_labels <- tbl_df(activity_labels)

## Apply the merge, select and arrange functions to tidy up the X_combined dataset
## The end result is the dataset as per the assignment instructions (points 1 to 4)
X_combined <-
   X_combined %>%
   merge(activity_labels, by.x="activityid", by.y="activityid") %>%
   select(activityname, subjectid, tBodyAccmeanX:fBodyBodyGyroJerkMagstd) %>%
   arrange(activityname, subjectid)

## Step 12: Create a second tidy dataset where the measures are grouped by activityname and subjectid
## and the measures are all averaged.

byactsubj_X_combined <- X_combined %>% group_by(activityname, subjectid) %>% summarise_all(mean)

## =========================================================================================================

## Step 13: Write out the final datasets (the write.table function will convert them to data frames).
setwd("..")
write.table (X_combined, file="X_combined.txt", row.name=FALSE)
write.table (byactsubj_X_combined, file="byactsubj_X_combined.txt", row.name=FALSE)





