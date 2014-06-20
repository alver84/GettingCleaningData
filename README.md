---
title: "README"
output: html_document
---

This repo explains how all of the scripts work and how they are connected.

### Purpose
The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set. 

### Goal
The goal is to prepare tidy data that can be used for later analysis.

### Description
This project consists of the next files and directory

* **UCI HAR Dataset**
(unzipped directory of https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
* **README.md** with some instructions
* **CodeBook.md** with discription of data, transpormations, final variables
* **run_analysis.R** is a source code
* **tidy_data.csv** is a tidy data set

### Initialisation
1. Set working directory contaning **UCI HAR Dataset**
2. Install and load **reshape2** library 

### Transformations

1. Reads the corresponding files using read.table(...) function
2. Forming the names of variables and subseting the variables with mean and standard deviation, mean() **only** and std(), for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Merges the training and the test sets to create one data set using cbind(...) and rbind(...) functions.
5. Appropriately labels the data set with descriptive variable names. 
6. Creates a final independent tidy data set with the average of each variable for each activity and each subject using melt(...) and dcast(...) functions. 