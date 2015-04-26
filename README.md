Introduction
============
This script is meant to tidy data from an experiment, which consists of readings from a smartphone's accelerometer.


How to use
==========

1. Make sure the data set folder "UCI HAR Dataset" is inside R's working directory (i.e., if the working directory is called "work", then the data set folder should be "work/UCI HAR Dataset").
2. Source the script "run_analysis.R" in R.
3. Execute the `main` function. The result is saved in "output.txt".


Implementation
==============

The bulk of the logic is done inside function `main`. Function `read.dataset` was created to abstract code that is repeated for reading both train and test data set.

main
----
`main` operates in the following steps:

1. Read the feature names from file "UCI HAR Dataset/features.txt".
2. Read activity labels from file "UCI HAR Dataset/activity_labels.txt".
3. Read the train data set (using function `read.dataset`).
4. Read the test data set (using function `read.dataset`).
5. Merge the train and test data sets.
6. Remove irrelevant columns from the data set. The assignment's description wasn't very clear on exactly which columns should be removed, so I decide to keep only the columns that match "mean(" or "std" (thus, columns with "meanFreq" and "gravityMean" are excluded). The columns "activity" and "subject" are also kept.
7. For each "activty" and "subject" pair, calculate the mean of each variable.
8. Write the output of step 7 to file "output.txt".

read.dataset
------------
`read.dataset` operates in the following steps:

1. Reads the variables from file "UCI HAR Dataset/<type>/X_<type>.txt".
2. Assigns the appropriate variables names to the data set.
3. Adds column "activity" to the data set, with data read from file "UCI HAR Dataset<type>/y_<type>.txt". The activities are also converted to the appropriate labels.
4. Adds column "subject" to the data set, with data read from file "UCI HAR Dataset/<type>/subject_<type>.txt".
5. Returns the data set.
