## GETTING AND CLEANING DATA MODULE ASSIGNMENT

## Jayashree Krishnamoorthy - 20 January 2020
## Coursera - Getting and Cleaning Data - Assignment
## John Hopkins University

## See associated README.md and Codebook.md files
## for background information and explanation of this script
## These are available at:
## https://github.com/jayashreekris/Courseera-GettingandCleaningData

## This scripts produces the following output files in the current R working dir
## 1) Data_Extract.csv (consolidated raw data set)
## 2) Assignment_Output.csv (analysis output data set, csv format)
## 3) Assignment_Output.txt (analysis output data set, txt format, no row names)

## The required data input files should be located in the R working dir
## These features.txt , subject_test.txt , subject_train.txt , x_test.txt ,
## y_test.txt , x_train.txt , y_train.txt
## These files have been sourced from:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## The ultimate source of this data is:
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support
## Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
## Vitoria-Gasteiz, Spain. Dec 2012
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


## 1  -------------- Create All Data Set by combining test and train data

features <- read.table("./UCI HAR Dataset/features.txt")
var_names <- as.vector(features[,2])
var_names <- c("Subject" , "Activity" , var_names)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data <- cbind(subject_test , y_test , x_test)
colnames(test_data) <- var_names

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
sample_type_train <- rep("Train", nrow(x_train))
train_data <- cbind(subject_train , y_train , x_train)
colnames(train_data) <- var_names

all_data <- rbind(train_data , test_data)
all_data[,2] <- as.factor(as.character(all_data[,2]))

## 2  -------------- Extract Only Mean and STD Variables

mean_true <- grep("mean()" , var_names , fixed = TRUE) 
mean_data <- all_data[ , mean_true]

std_true <- grep("std()" , var_names)
std_data <- all_data[ , std_true]

subject_true <- grep("Subject" , var_names)
subject_data <- all_data[ , subject_true]

activity_true <- grep("Activity" , var_names)
activity_data <- all_data[ , activity_true]

data_extract <- 
  cbind(subject_data , activity_data , mean_data , std_data)


## 3  -------------- Use Descriptive Activity Names

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_variables <- activity_labels[,2]

activity_variables_tidy <- gsub("WALKING" , "Walking" , activity_variables)
activity_variables_tidy <- gsub("UPSTAIRS" , "Upstairs" , activity_variables_tidy)
activity_variables_tidy <- gsub("DOWNSTAIRS" , "Downstairs" , activity_variables_tidy)
activity_variables_tidy <- gsub("SITTING" , "Sitting" , activity_variables_tidy)
activity_variables_tidy <- gsub("STANDING" , "Standing" , activity_variables_tidy)
activity_variables_tidy <- gsub("LAYING" , "Laying" , activity_variables_tidy)
activity_variables_tidy <- gsub("[[:punct:]]" , "" , activity_variables_tidy)
activity_labels[,2] <- activity_variables_tidy

data_extract[,2] <- factor(data_extract[,2] , levels = activity_labels[,1] ,
                           labels = activity_labels[,2])


## 4  -------------- Appropriately Label Data Set With Descriptive Variable Names

extract_variables <- colnames(data_extract)
write.csv(extract_variables,"extract_variables.csv")

extract_variables_tidy <- sub("[0-9]" , "" , extract_variables)
extract_variables_tidy <- sub("^t" , "T" , extract_variables_tidy)
extract_variables_tidy <- sub("^f" , "F" , extract_variables_tidy)
extract_variables_tidy <- sub("mean" , "Mean" , extract_variables_tidy)
extract_variables_tidy <- sub("std" , "Std" , extract_variables_tidy)
extract_variables_tidy <- sub("BodyBody" , "Body" , extract_variables_tidy)
extract_variables_tidy <- gsub("[[:punct:]]" , "" , extract_variables_tidy)
extract_variables_tidy <- sub("MeanX" , "XMean" , extract_variables_tidy)
extract_variables_tidy <- sub("MeanY" , "YMean" , extract_variables_tidy)
extract_variables_tidy <- sub("MeanZ" , "ZMean" , extract_variables_tidy)
extract_variables_tidy <- sub("StdX" , "XStd" , extract_variables_tidy)
extract_variables_tidy <- sub("StdY" , "YStd" , extract_variables_tidy)
extract_variables_tidy <- sub("StdZ" , "ZStd" , extract_variables_tidy)
extract_variables_tidy[1] <- "SubjectID"
extract_variables_tidy[2] <- "Activity"

colnames(data_extract) <- extract_variables_tidy

write.csv(data_extract , "data_extract.csv")

## 5  -------------- Generate Output by Activity and Save to Assignment_Output.CSV File

library(dplyr)

output_data <- arrange(data_extract , SubjectID)
output <- group_by(output_data, SubjectID, Activity)
output <- summarise_all(output,funs(mean))

write.csv(output , "Assignment_Output.csv")
write.table(output , "Assignment_Ouput.txt" , row.name = FALSE)
