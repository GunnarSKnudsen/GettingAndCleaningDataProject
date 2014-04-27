setwd("~/Coursera/DataSciences/GettingAndCleaningData/Project")
library(plyr)
library(data.table)


## Download file(s):
if(!file.exists("data")){
   dir.create("data")

   url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   download.file(
      url
      , 'data/dataSet.zip', 
      method='curl')
   unzip('data/dataSet.zip')
}


#Fetch variable names used for features - Used in testData and trainData, aswell as testData_MeanSTD and trainData_MeanSTD
features <- read.table("data/dataSet/features.txt",header=FALSE,colClasses="character")

#Fetch descriptive names for activities
activities <- read.table("data/dataSet/activity_labels.txt")


#Read the data into variables:

## Fetch data from test

### test data main:
testData <- read.table("data/dataSet/test/X_test.txt",header=FALSE)
colnames(testData) <- features$V2
#### New table only containing means and std's
testData_MeanSTD <- testData[, grep("-mean\\(\\)|-std\\(\\)", features[, 2])]

### Subject:
testDataSubject <- read.table("data/dataSet/test/subject_test.txt",header=FALSE)
colnames(testDataSubject) <- "Subject"
head(testDataSubject)

### Activity:
testDataActivity <- read.table("data/dataSet/test/y_test.txt",header=FALSE)
colnames(testDataActivity) <- "Activity"
testDataActivity$Activity <- factor(testDataActivity$Activity,levels=activities$V1,labels=activities$V2)
head(testDataActivity)

## Fetch data from training

## train data main:
trainData <- read.table("data/dataSet/train/X_train.txt",header=FALSE)
colnames(trainData) <- features$V2
#### New table only containing means and std's
trainData_MeanSTD <- trainData[, grep("-mean\\(\\)|-std\\(\\)", features[, 2])]

### Subject
trainDataSubject <- read.table("data/dataSet/train/subject_train.txt",header=FALSE)
colnames(trainDataSubject) <- "Subject"
head(trainDataSubject)

### Activity
trainDataActivity <- read.table("data/dataSet/train/y_train.txt",header=FALSE)
colnames(trainDataActivity) <- "Activity"
trainDataActivity$Activity <- factor(trainDataActivity$Activity,levels=activities$V1,labels=activities$V2)
head(trainDataActivity)


##Merge to single table:
### All data:
testDataMerged <- cbind(testDataSubject, testDataActivity)
testDataMerged <- cbind(testDataMerged, testData)
testDataMerged <- cbind(testDataMerged, Heading = rep("Test", nrow(testData)))

trainDataMerged <- cbind(trainDataSubject, trainDataActivity)
trainDataMerged <- cbind(trainDataMerged, trainData)
trainDataMerged <- cbind(trainDataMerged, Heading = rep("Training", nrow(trainData)))

mergedData <- rbind(testDataMerged, trainDataMerged)
#dim(mergedData)
#head(mergedData)

### Only means and STD's:
testDataMerged_MeanSTD <- cbind(testDataSubject, testDataActivity)
testDataMerged_MeanSTD <- cbind(testDataMerged_MeanSTD, testData_MeanSTD)
testDataMerged_MeanSTD <- cbind(testDataMerged_MeanSTD, Heading = rep("Test", nrow(testData)))

trainDataMerged_MeanSTD <- cbind(trainDataSubject, trainDataActivity)
trainDataMerged_MeanSTD <- cbind(trainDataMerged_MeanSTD, trainData_MeanSTD)
trainDataMerged_MeanSTD <- cbind(trainDataMerged_MeanSTD, Heading = rep("Training", nrow(trainData)))

mergedData_MeanSTD <- rbind(testDataMerged_MeanSTD, trainDataMerged_MeanSTD)
#dim(mergedData_MeanSTD)
#head(mergedData_MeanSTD)


## Generate .csv with all the merged data:
write.table(mergedData, file="mergedData.csv", sep=",", row.names=FALSE)

## Generate .csv with all Means and STD's
write.table(mergedData_MeanSTD, file="mergedData_MeanSTD.csv", sep=",", row.names=FALSE)

## Generate table with Averages
DT <- data.table(mergedData_MeanSTD)
tidy_MeanSTD<-DT[,lapply(.SD,mean),by="Activity,Subject"]
#head(tidy_MeanSTD)
#dim(tidy_MeanSTD)
write.table(tidy_MeanSTD,file="tidy_MeanSTD.csv",sep=",",row.names = FALSE)



## Generate tidy data-set, with average for each activity and subject:
DT <- data.table(mergedData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
#head(tidy)
#dim(tidy)
write.table(tidy,file="tidy.csv",sep=",",row.names = FALSE)