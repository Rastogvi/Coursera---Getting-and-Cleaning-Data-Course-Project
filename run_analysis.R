
## Load Libraries
library(plyr)
library(dplyr)

# Download the data

setwd("")
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

if (!file.exists("./data")) {dir.create("./data")}
download.file(fileurl, destfile ="./data/data.zip")

unzip("./data/data.zip", exdir = "./data")


# Read the data from the files

features = read.table('./data/UCI HAR Dataset/features.txt', header=FALSE)

activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt',header=FALSE)
colnames(activity_labels) = c("Id", "Activity_Name")

x_train = read.table("./data/UCI HAR Dataset/train/X_train.txt")
colnames(x_train) = features[,2]

y_train = read.table("./data/UCI HAR Dataset/train/y_train.txt")
colnames(y_train) = "Id"

sub_train = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
colnames(sub_train) = "Sub_ID"

x_test = read.table("./data/UCI HAR Dataset/train/X_train.txt")
colnames(x_test) = features[,2]

y_test = read.table("./data/UCI HAR Dataset/train/y_train.txt")
colnames(y_test) = "Id"

sub_test = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
colnames(sub_test) = "Sub_ID"


#1. Merges the training and the test sets to create one data set.

# Create train data set by merging x train, y train and sub train

d_train = cbind(x_train, y_train, sub_train)

# Create train data set by merging x test, y test and sub test

d_test = cbind(x_test, y_test, sub_test)

#Merge all data

d.all  = rbind(d_train, d_test)

dim(d.all)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.


d_mean_std = d.all[ , grep("Sub_ID|Id|mean\\(\\)|std\\(\\)", names(d.all))]

dim(d_mean_std)

#3.Uses descriptive activity names to name the activities in the data set

Tidy_Data = left_join(d_mean_std, activity_labels, by = "Id", match = "all")

Tidy_Data = Tidy_Data %>%
  select(-Id)

dim(Tidy_Data)

#4. Appropriately labels the data set with descriptive variable names.

d.new = names(Tidy_Data)
d.new = gsub("[(][)]", "", d.new)
d.new = gsub("^t", "Total_", d.new)
d.new = gsub("^f", "Frequency_", d.new)
d.new = gsub("Acc", "Accelerometer", d.new)
d.new = gsub("Gyro", "Gyroscope", d.new)
d.new = gsub("Mag", "Magnitude", d.new)
d.new = gsub("-mean-", "_Mean_", d.new)
d.new = gsub("-std-", "_StandardDeviation_", d.new)
d.new = gsub('Freq\\.',"Frequency.",d.new)
d.new = gsub('Freq$',"Frequency", d.new)
d.new = gsub('BodyBody',"Body", d.new)
d.new = gsub("-", "_", d.new)
names(Tidy_Data) = d.new


#5 From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject


final_data = ddply(Tidy_Data, c("Sub_ID","Activity_Name"), numcolwise(mean))

write.table(final_data, file = "./data/finaldata.txt", row.names = FALSE)
