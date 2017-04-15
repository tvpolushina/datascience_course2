# Getting And Cleaning Data. Course 2. Data Science specialization

## The Goal

Prepare a tidy dataset from public avaliable raw data. The project should contain supporting information and explanation on the code.

Final submission contains a link to Github repository with files:

1. __README.md__ file explaining how all of the scripts work.
2.  the r code file __run_analisys.R__ with procedures that should be excuted to obtain a tidy dataset.
3. the __code book__ that describes the variables, the data, and any transformations
4. the tidy dataset.

## Description of the project

*One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.*

*A full description is available at the site where the data was obtained:*

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)[1]


*You should create one R script called __run_analysis.R__ that does the following.*

1. *Merges the training and the test sets to create one data set.*
2. *Extracts only the measurements on the mean and standard deviation for each measurement.* 
3. *Uses descriptive activity names to name the activities in the data set*
4. *Appropriately labels the data set with descriptive variable names.* 
5. *From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*


## The Recipe: run_analisys.R
__run_analisys.R__ script uses the  raw data __getdata\_projectfiles\_UCI HAR Dataset.zip__ in the currect directoty to generate a tidy dataset.

The next steps were performed to obtain a tidy data.

* unzip the raw data into the working directory
* merge separate file into train data and merge separate files into test data, afterwards the training and test sets were merged row wise to create one dataset
* extracts only measurements on mean or standar deviation features from the dataset. These features were selected based on column names.
* use descriptive activity names to name the activities in the relevant feature.
* appropiately labels the data set with descriptive variable names  based on information provided in the file 'features_info.txt'
* from the dataset created in the previous step, generate an independent tidy dataset __tidy\_data\_set.txt__ in the working directory




##References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
