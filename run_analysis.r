#####################################
#1. Unzip the downloaded file. Assume here that the file is loaded to the working directory

unzip("getdata_projectfiles_UCI HAR Dataset.zip")

######################################
# 2. Merge the training and test sets to create one dataset

# Load the list of all features from  "UCI HAR DataSet/features.txt"
features_list <- read.table("UCI HAR DataSet/features.txt", stringsAsFactors = FALSE)
#extract the names of all of the features
features <- features_list[,2]

######################################
## Load the train set observations from  "UCI HAR DataSet/train/X_train.txt"
train <- read.table("UCI HAR DataSet/train/X_train.txt")
# Load the train labels from  "UCI HAR DataSet/train/y_train.txt"
train_labels <- read.table("UCI HAR DataSet/train/y_train.txt")
# Load the train subjects from  "UCI HAR DataSet/train/subject_train.txt"
train_sub <- read.table("UCI HAR DataSet/train/subject_train.txt")
##Merge 3 tables with training data
# 1 subject connected with the observation (train_sub)
# 2. activity performed during the observation (train_labels)
# 3. train data and add the column/ feature names
train_data <- cbind(train_sub, train_labels, train)
names(train_data) <- names
## Remove unnecessary tables from memory
rm("train",  "train_sub")

######################################
# load test observations from "UCI HAR DataSet/test/X_test.txt"
test <- read.table("UCI HAR DataSet/test/X_test.txt")
# Load test labels from "UCI HAR DataSet/test/y_test.txt"
test_labels <- read.table("UCI HAR DataSet/test/y_test.txt")
# Load test subjects from "UCI HAR DataSet/test/subject_test.txt"
test_sub <- read.table("UCI HAR DataSet/test/subject_test.txt")
dim(test); dim( test_labels); dim(test_sub)

# Merge 3 tables
# 1. subject connected with the observation (test_sub)
# 2. activity performed during the observation (test_labels)
# 3. test data and  add the column/ feature names
test_data <- cbind(test_sub, test_labels, test)
names <- c("subject", "activity", features)
names(test_data) <- names

##Remove unnecessary tables
rm("test", "test_labels", "test_sub")

######################################
# Merge the test dataset and training dataset 
merged_data <- rbind(test_data, train_data)

################################################################
# 3. Extracts only measurements on mean & standar deviation  features/ columns

newnames <- names(merged_data)
data_mean_std <- merged_data[,c(1, 2, grep("*std\\(\\)|*mean\\(\\)", newnames, ignore.case = TRUE))]


################################################################
## 4. Use descriptive activity names to name the activities   

activ_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
data_mean_std$activity <- activ_labels[match(data_mean_std$activity, activ_labels[,1]), 2]

###########################################################################
#5. Appropiately labels the data set with descriptive variable names  
names(data_mean_std) <- sub("^t", "time", names(data_mean_std))
names(data_mean_std) <- sub("^f", "frequency", names(data_mean_std))
names(data_mean_std) <- sub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std) <- sub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std) <- sub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std) <- sub("BodyBody", "Body", names(data_mean_std))

##########################################################################
#6. create a second independent tidy data set with the average of each variable for each activity and each subject                  ##

average_activ_sub_data_set <- aggregate(. ~ activity + subject, data_mean_std, mean)
write.table(average_activ_sub_data_set, "tidy_data_set.txt", row.names = FALSE)
