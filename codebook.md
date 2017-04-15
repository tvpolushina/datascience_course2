# Information about raw data
Information about the raw data can be found in the links below [1] and data can be obtained from the second link.

[Human Activity Recognition Using Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) [1]

[raw data (ZIP format)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Summary of the experiment 

*"The experiments have been carried out with a group of __30 volunteers__ within an age bracket of 19-48 years. Each person performed __six activities__ (__WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING__) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The __obtained dataset has been randomly partitioned into two sets__, where __70% of the volunteers__ was selected for generating the __training data__ and __30% the test data__."*

...


The list of provided files are:

- 'features_info.txt': Shows __information__ about the __variables used on the feature vector__.


- 'features.txt': __List of all features__.



- 'activity_labels.txt': Links the __class labels__ with their __activity name__.



- 'train/X_train.txt': __Training set__.



- 'train/y_train.txt': __Training labels__.



- 'test/X_test.txt': __Test set__.



- 'test/y_test.txt': __Test labels__.



## Study Design
The goal is to create  __tidy dataset__.

## Load and unzip data to the working directory.

## Merging the training and test data 

Information about training data were loaded from files:

- 'train/X_train.txt' contains the Train set
- 'train/y_train.txt' contains the Train labels
- 'train/subject_train.txt" contains info about the subjects


Infomation about test data were loaded from files:

- 'test/X_test.txt' contains the Test set
- 'test/y_test.txt' contains the Test labels
- 'test/subject_test.txt' contains info about the subjects

All files were loaded to R with   a `read.table(file)` function.
Information from 3 sources about training data and test data were merged separately and at the final stage these two datasets were merged together. 

For each set, we merged 

 1. subject connected with the observation 

 2. activity performed during the observation 

 3. test data and  add the column/ feature names. The feature/ columns names are contained in the 'features.txt' file. `feature_list` contains 561 observations.

Tables were merged column wise

    test_data <- cbind(test_sub, test_labels, test)
    train_data <- cbind(train_sub, train_labels, train)

Names were added with code
    
    features_list <- read.table("UCI HAR DataSet/features.txt", stringsAsFactors = FALSE)
    features <- features_list[,2]
    names <- c("subject", "activity", features) 
    names(test_data) <- names

The two datasets `test_data` & `train_data` contains were merged row wise using a `rbind` to create a `merged_dat`

	merged_data <- rbind(test_data, training_data)

The merged table contains 563 columns and 10299 rows.
  
    dim(merged_data)
    [1] 10299   563
    
Check for missing values
  
  all(colSums(is.na(merged_data)) != 0)
	[1] FALSE



## Extracting only measurements on mean & standar deviation

The function `grep` was used to select only features with column names that contain  __"mean()" or "std()"__. The code is written below. A new dataset contain 68 columns.


    newnames <- names(merged_data)
    data_mean_std <- merged_data[,c(1, 2, grep("*std\\(\\)|*mean\\(\\)", newnames, ignore.case = TRUE))]

## Appropriately labels the data set with descriptive variable names

Sevral column names were updated to increase clarity of features names based on information from 'features_info.txt' file.

- "t" is abbreviation for  "time"
-   "f" is abbreviation for  "frequency"
-   "Acc" is abbreviation for  "Accelerometer"
-   "Gyro" is abbreviation for  "Gyroscope"
-   "Mag" is abbreviation for  "Magnitude"
-   "BodyBody" is abbreviation for  "Body"

These modifications were performed with code:

    names(data_mean_std) <- sub("^t", "time", names(data_mean_std))
    names(data_mean_std) <- sub("^f", "frequency", names(data_mean_std))
    names(data_mean_std) <- sub("Acc", "Accelerometer", names(data_mean_std))
    names(data_mean_std) <- sub("Gyro", "Gyroscope", names(data_mean_std))
    names(data_mean_std) <- sub("Mag", "Magnitude", names(data_mean_std))
    names(data_mean_std) <- sub("BodyBody", "Body", names(data_mean_std))



## Creation of a second independent tidy dataset with the average of each variable for each activity and each subject.

To create the second independent tody dayaset, the  `aggregate` function from  the `{stats}` package was applied. This function splits the data into subsets, here as strata,  `activity + subject` features were used. The tidy dataset was saved with the  `write.table` function to the current directory. 

    
    average_activ_sub_data_set <- aggregate(. ~ activity + subject, data_mean_std, mean)
    write.table(average_activ_sub_data_set, "tidy_data_set.txt", row.names = FALSE)

## Code book

To create a tidy dataset, the pipeline satisfies the general principles 

1. each different observation of a variable is in a different row
2. each variable is in one column
3. there is one table for each type of variable

The tidy dataset `average_activ_sub_data_set` contains 180 observations, since there are 30 subjects and 6 types of activities in initial data, and 68 columns.  In the table, 66 columns out 68 correspond average values for different features.

    dataset.dim(average_activ_sub_data_set)
    [1] 180  68


## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
