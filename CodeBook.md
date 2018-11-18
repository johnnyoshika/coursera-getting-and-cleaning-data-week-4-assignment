## Project
* Coursera
* Getting and Cleaning Data
* Week 4 Assignment

## Data
* Obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Source of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Tidy data
* The script to tidy data is in `run_analysis.R`

## Description of run_analysis.R
* Creates a `results` directory if it doesn't exist
* Reads in the following data:

| Variable Name | File |
| -------------------------- | -------------------------- |
| activity_labels | ./dataset/activity_labels.txt |
| features | ./dataset/features.txt |
| subject_test | ./dataset/test/subject_test.txt |
| X_test | ./dataset/test/X_test.txt |
| y_test | ./dataset/test/y_test.txt |
| subject_train | ./dataset/train/subject_train.txt |
| X_train | ./dataset/train/X_train.txt |
| y_train | ./dataset/train/y_train.txt |

* Merges activity IDs, subject IDs, and data into the following variables
  * test
  * train
* Part 1 of the assignment requires that the training and test data is merged into one dataframe. That's stored in `full_dataset`.
* Part 2 of the assignment requires that we extract mean and standard deviation only. That's stored in `mean_and_std`.
* Part 3 of the assignment requires that we use descriptive activity names. That's stored in `activities`.
* Part 4 of the assignment requires that we use descriptive variable names. That's stored in `activities` and its content is written to `./results/activities.csv`.
* Part 5 of the assignment requires that we take the mean of all variables, after they're grouped into subject and activity. That's stored in `activity_means` and its content is written to `./results/activity_means.txt`.


