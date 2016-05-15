# Steps for the exercise
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Elements in the repository
- readme.md: this file 
- runAnalysis.R: the R script that outputs the result
- tidyData.txt: the output from the code contained in the R script
- codebook.md: the description of the variables in runAnalysis.R

# Original data provided
- activity_labels.txt: list of class labels and their activity name;
- features.txt: list of all features;
- train/X_train.txt: training set;
- train/y_train.txt: training labels;
- train/subject_train.txt: IDs of subjects in the training data;
- test/X_test.txt: test set;
- test/y_test.txt: test labels;
- test/subject_test.txt: IDs of subjects in the testing data;

# The script
- installs the plyr package, which make it useful to split data
- reads in all of the provided data files
- merges the corresponding data sets into one by using <code>rbind</code>
- extracts the columns with <code>mean()</code> and <code>std()</code> values and forms a new data frame with the "activity_id", the "subject_id" and the <code>mean()</code> and <code>std()</code> columns by using <code>grep</code> function
- extracts the desired activity names from the y_data
- binds all the data
- creates the tidy data set with the average of each variable for each activity and each subject by using <code>ddply</code>
