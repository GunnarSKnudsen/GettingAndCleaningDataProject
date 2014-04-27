setwd("~/Coursera/DataSciences/GettingAndCleaningData/Project")
library(plyr)
library(data.table)


## Download file(s):
#if(!file.exists("data")){
#   dir.create("data")
#}

#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download.file(
#   url
#   , 'data/dataSet.zip', 
#   method='curl')

#unzip('data/dataSet.zip')


#Fetch variable names used for data.tables
features <- read.table("data/dataSet/features.txt",header=FALSE,colClasses="character")
head(features)
activities <- read.table("data/dataSet/activity_labels.txt")
head(activities)

#Read the data into variables:

## Fetch data from test

### test data main:
testData <- read.table("data/dataSet/test/X_test.txt",header=FALSE)
colnames(testData) <- features$V2
head(testData)

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
head(trainData)

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

testDataMerged <- cbind(testDataSubject, testDataActivity)
head(testDataMerged)
testDataMerged <- cbind(testDataMerged, testData)
head(testDataMerged)
testDataMerged <- cbind(testDataMerged, Heading = rep("Test", nrow(testData)))
head(testDataMerged)



trainDataMerged <- cbind(trainDataSubject, trainDataActivity)
head(trainDataMerged)
trainDataMerged <- cbind(trainDataMerged, trainData)
head(trainDataMerged)
trainDataMerged <- cbind(trainDataMerged, Heading = rep("Training", nrow(trainData)))
head(trainDataMerged)

mergedData <- rbind(testDataMerged, trainDataMerged)

head(mergedData)

#bigData_mean<-sapply(mergedData,mean,na.rm=TRUE)
#bigData_sd<-sapply(mergedData,sd,na.rm=TRUE)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
DT <- data.table(bigData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
head(tidy)


trainDataSubject


head(testDataActivity)


head(cbind(testDataActivity, testDataSubject))

head(testData)
nrow(testDataActivity)



print("hey")


# 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("data/dataSet/activity_labels.txt",header=FALSE,colClasses="character")

activities



testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# 4. Appropriately labels the data set with descriptive activity names


colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")

# 1. merge test and training sets into one data set, including the activities
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
bigData<-rbind(testData,trainData)

head(bigData)

# 2. extract only the measurements on the mean and standard deviation for each measurement
bigData_mean<-sapply(bigData,mean,na.rm=TRUE)
bigData_sd<-sapply(bigData,sd,na.rm=TRUE)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
DT <- data.table(bigData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy2.csv",sep=",",row.names = FALSE)












train_X <- read.table('data/dataSet/train/X_train.txt')
train_Y <- read.table('data/dataSet/train/y_train.txt')
train_subject <- read.table('data/dataSet/train/subject_train.txt')

test_X <- read.table('data/dataSet/test/X_test.txt')
test_Y <- read.table('data/dataSet/test/y_test.txt')
test_subject <- read.table('data/dataSet/test/subject_test.txt')

entire_train <- cbind(train_Y, train_subject, train_X)
entire_test <- cbind(test_Y, test_subject, test_X)

features <- read.table('data/dataSet/features.txt')
activity_labels <- read.table('data/dataSet/activity_labels.txt')

feature_names <- as.character(features[[2]])
activity_names <- as.character(activity_labels[[2]])

mean_features = feature_names[grep('mean', feature_names)]
std_features = feature_names[grep('std', feature_names)]

combined_data <- rbind(entire_train, entire_test)

names(combined_data) <- c('Activity', 'Subject', feature_names)

compact_data <- combined_data[,c('Activity', 'Subject', mean_features, std_features)]
compact_data$Activity <- mapvalues( compact_data$Activity, from=activity_labels[[1]] , to=activity_names)

write.csv(compact_data, 'compact_data.csv', row.names=FALSE)

agg_data <- aggregate(. ~ Activity + Subject, compact_data, FUN=mean)

write.csv(agg_data, 'summary.csv', row.names=FALSE)
