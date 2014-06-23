## initialisation
library(reshape2)
setwd("/Users/alver/Coursera/Subject3/project/")

## define file names
filename_test_subject <- "UCI HAR Dataset/test/subject_test.txt"
filename_test_label <- "UCI HAR Dataset/test/y_test.txt"
filename_test_set <- "UCI HAR Dataset/test/X_test.txt"

filename_train_subject <- "UCI HAR Dataset/train/subject_train.txt"
filename_train_label <- "UCI HAR Dataset/train/y_train.txt"
filename_train_set <- "UCI HAR Dataset/train/X_train.txt"

filename_features <- "UCI HAR Dataset/features.txt"
filename_activity <- "UCI HAR Dataset/activity_labels.txt"

# reads files
df_test_subject <- read.table(filename_test_subject, col.names = c("SubjectID")) 
df_test_label <- read.table(filename_test_label, col.names = c("ActivityID"))
df_test_set <- read.table(filename_test_set)

df_train_subject <- read.table(filename_train_subject, col.names = c("SubjectID")) 
df_train_label <- read.table(filename_train_label, col.names = c("ActivityID"))
df_train_set <- read.table(filename_train_set)

## auxiliary tables
df_features <- read.table(filename_features, col.names = c("ID", "Name"))
df_activity <- read.table(filename_activity, col.names = c("ID", "Name"))

##forms a vector containing the numbers of columns with mean() and std() in the names
id_means <- character()
id_means <- grep("mean\\(\\)|std\\(\\)", df_features$Name)
id_means <- sub("^", "V", id_means)
cat(paste(shQuote(id_means, type="cmd"), collapse=", "))

##forms a vector containing the names of columns with mean() and std() in the names
v_names <- character()
v_names <- grep("mean\\(\\)|std\\(\\)", df_features$Name, value = "TRUE")
## removes brackets
v_names <- gsub("\\(\\)", "", v_names)
## changes some symbols
v_names <- gsub("-", "_", v_names)
v_names <- sub("^t{1}", "time_", v_names)
v_names <- sub("^f{1}", "frequency_", v_names)

## Extracts only the measurements on the mean and standard deviation for each measurement
df_test_ms <- df_test_set[, id_means]
df_train_ms <- df_train_set[, id_means]

## Combine subject_test, y_test and X_test
df_test_ms_combine <- cbind(df_test_subject, df_test_label, df_test_ms)

## Combine subject_train, y_train and X_train
df_train_ms_combine <- cbind(df_train_subject, df_train_label, df_train_ms)

## Merges the training and the test sets to create one data set
data <- rbind(df_test_ms_combine, df_train_ms_combine)

## Rename the columns of data frame
for(i in 3:ncol(data)) names(data)[i]<-v_names[i-2]

## Converts ActivityID to the descriptive var name
data$ActivityID <- factor(data$ActivityID, levels=df_activity$ID, labels=df_activity$Name)

## Creates an independent tidy data set with the average of each variable 
## for each activity and each subject. 

data_melt <- melt(data, id.var = c("SubjectID", "ActivityID"))
tidy_data <- dcast(data_melt, SubjectID + ActivityID ~ variable, mean)

## rename the columns
for(i in 3:ncol(tidy_data)) names(tidy_data)[i]<-sub("^", "mean_", v_names[i-2])

## writes the table
write.csv(tidy_data, file="./tidy_data.csv")
