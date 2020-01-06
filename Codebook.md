This codebook explains the step by step process of creating and analysing run.analysis script creating a final data set. The R file is the part of Getting and Cleaning Data Course Project by John Hopkins.  

Prelim steps:
a. Download the dataset
Download the data and extract it under the folder called UCI HAR Dataset


b. Read the data
The zip folder contains 6 different files.

features <- features.txt : 561 rows, 2 columns

activities <- activity_labels.txt : 6 rows, 2 columns

X_train = X_train.txt : 7352 rows, 561 columns

Y_train = Y_train.txt : 7352 rows, 561 columns

Subject_train = Subject_train.txt : 7352 rows, 561 columns

X_train = X_test.txt : 7352 rows, 561 columns

Y_train = Y_test.txt : 7352 rows, 561 columns

Subject_train = Subject_test.txt : 7352 rows, 561 columns


Code for the questions:

1. Merges the training and the test sets to create one data set

d_Train: Merge X_train, Y_train and Sub_train using cbind function
d_Test: Merge X_test, Y_test and Sub_test using cbind function
d.all: Merge d_train and d_test using rbind function resulting 14704 rows and 563 columns 


2. Extracts only the measurements on the mean and standard deviation for each measurement

d_mean_std (14704 rows, 68 columns) is created by subsetting Merged_Data, selecting only columns: subject_Id, Id and the measurements on the mean and standard deviation (std) for each measurement

3. Uses descriptive activity names to name the activities in the data set

Join the "Activity_Name" in the table by using "Id" variable and then removing "Id" variable from the dataset

4. Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities

Replace special characters like '//' by blank.
Replace std by StandardDeviation
Replace mean by Mean
Replace freq by Frequency
Replace Acc by Accelerometer
Replace Gyro by Gyroscope
Replace BodyBody by Body
Replace Mag by Magnitude
Replace start with character f  by Frequency
Replace start with character t by Total


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

FinalData (126 rows, 68 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.