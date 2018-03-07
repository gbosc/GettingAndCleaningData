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

This is the README.md file.

Background on the data/measures contained within the dataset
============================================================

The following passage is from the original dataset's README.txt file. It helps to explain what the data in this 
dataset represents.

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details."

For each record (observation) it is provided:
=============================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 66-measure vector with time and frequency domain variables. 
- An activity name that identifies the activity involved in the experiment. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.md'

- 'CodeBook.md' : A Code Book that explains the contents the of the 'X_combined' and 'byactsubj_X_combined' datasets.

- 'X_combined': Atomic accelerometer measures along with the activityname and the subjectid that pertain to each observation.

- 'byactsubj_X_combined': Accelerometer measures grouped by activity and by subject. Measures in this dataset are the AVERAGES of the mean & std.

Note: the 'X_combined' and 'byactsubj_X_combined' datasets get created when the "run_analysis.R" script is run in R.

