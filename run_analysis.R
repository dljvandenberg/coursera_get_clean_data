# Script for Coursera course Getting and Cleaning Data - Course project
# 
# 1. Merges the training and the test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Preparation

# Set working dir and load libs
setwd("~/git/datasciencecoursera/getdata_project/UCI HAR Dataset")
library(dplyr)


## Read datasets with measurements

# Read training and test datasets
df.train.set <- read.table("train/X_train.txt")
df.test.set <- read.table("test/X_test.txt")


## Add column names

# Read mapping of column numbers and feature names
df.mapping.features <- read.table("features.txt")
v.features <- df.mapping.features[,2]
# Add column names to df.train.set and df.test.set
names(df.train.set) <- v.features
names(df.test.set) <- v.features


## Add activity_name data

# Read activity labels for each window sample
df.train.labels <- read.table("train/y_train.txt")
df.test.labels <- read.table("test/y_test.txt")
# Add column names
names(df.train.labels) <- c("activity_label")
names(df.test.labels) <- c("activity_label")

# Read mapping of activity labels with activity name
df.label.mapping <- read.table("activity_labels.txt")
# Add column names
names(df.label.mapping) <- c("activity_label", "activity_name")
# Convert activity_label to activity_name using df.label.mapping
df.train.activity_names <- subset(merge(df.train.labels, df.label.mapping), select=activity_name)
df.test.activity_names <- subset(merge(df.test.labels, df.label.mapping), select=activity_name)

# Add column "activity_name" to df.train.set and df.test.set datasets
df.train.set <- cbind(df.train.activity_names, df.train.set)
df.test.set <- cbind(df.test.activity_names, df.test.set)


## Add subject data

# Read subjects who performed activity for each window sample
df.train.subjects <- read.table("train/subject_train.txt")
df.test.subjects <- read.table("test/subject_test.txt")
names(df.train.subjects) <- "subject"
names(df.test.subjects) <- "subject"

# Add column "subject" to df.train.set and df.test.set datasets
df.train.set <- cbind(df.train.subjects, df.train.set)
df.test.set <- cbind(df.test.subjects, df.test.set)


## Merge datasets

# Merge df.train.set and df.test.set vertically
df.merged.set <- rbind(df.train.set, df.test.set)


## Select relevant variables

# Select columns "subject", "activity_name" and columns containing "mean()" or "std()"
v.rownames.containing.mean.or.std <- names(df.merged.set)[grepl("mean\\(\\)", names(df.merged.set)) | grepl("std\\(\\)", names(df.merged.set))]
df.selected.set <- subset(df.merged.set, select = c("subject", "activity_name", v.rownames.containing.mean.or.std))


## Generate averages for each activity and each subject

# Aggregate mean values for each variable over "activity_name" and "subject" groups
df.averages <- aggregate(. ~ subject + activity_name, df.selected.set, FUN=mean)
# Sort by "subject" and "activity_name"
df.averages <- arrange(df.averages, subject, activity_name)


## Write output

# Write dataframe with averages to file
write.table(df.averages, file="averages.txt", row.name=FALSE)
