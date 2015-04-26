One of the most exciting areas in all of data science right now is wearable computing.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

This data was processed using the run_analysis.R script to get a tidy data set.
This file will explain  briefly the processing steps:

#Data transformation
Merge training and test sets"
Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt)  are merged to obtain a single data set. 
Variables are labelled with the names assigned by original collectors (features.txt).

Extract mean and standard deviation variables:
From the merged data set is extracted and intermediate data set with only the values of estimated mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std").
Use descriptive activity names

The labels were read from the files y_train.txt and y_test.txt and merged in one single column which was
added the  data set with the activity description. activity_labels.txt.
Label variables appropriately

Labels given from the original collectors were changed: to obtain valid R names without parentheses, dashes and commas to obtain more descriptive labels
Create a tidy data set

From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject.

The tidy data set contains 10299 observations with 81 variables divided in:

    an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
    an identifier of the subject who carried out the experiment (Subject): 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
    a 79-feature vector with time and frequency domain signal variables (numeric)


For variables derived from mean and standard deviation estimation, the previous labels are augmented with the terms "Mean" or "StandardDeviation".

The data set is written to the file tidy.txt.
