library(plyr)

if(!file.exists("./data")) {dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip", exdir="./data")
path_rf <- file.path("./data" , "UCI HAR Dataset")

## Reading test and train data

x_test <- read.table(file.path(path_rf, "test" , "X_test.txt"), quote="\"", comment.char="")
y_test <- read.table(file.path(path_rf, "test" , "Y_test.txt"), quote="\"", comment.char="")
subject_test <- read.table(file.path(path_rf, "test" , "subject_test.txt"), quote="\"", comment.char="")

x_train <- read.table(file.path(path_rf, "train", "X_train.txt"), quote="\"", comment.char="")
y_train <- read.table(file.path(path_rf, "train", "Y_train.txt"), quote="\"", comment.char="")
subject_train <- read.table(file.path(path_rf, "train", "subject_train.txt"), quote="\"", comment.char="")

## Merging the training and the test sets to create one data set

x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
subject_data <- rbind(subject_test, subject_train)

## Keeping only the mean and standard deviation variables

features <- read.table(file.path(path_rf, "features.txt"), quote="\"", comment.char="")
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std]
names(x_data) <- features[mean_and_std, 2]

## Using descriptive activity names to name the activities in the data set

activity_names <- read.table(file.path(path_rf, "activity_labels.txt"), quote="\"", comment.char="")
y_data[, 1] <- activity_names[y_data[, 1], 2]
names(y_data) <- "activity"

## Appropriately labeling the data set with descriptive variable names

names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)

## From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidy_data, "tidyData.txt", row.name=FALSE)
