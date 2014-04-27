setwd("~/Coursera/DataSciences/GettingAndCleaningData/Project")


if(!file.exists("data")){
   dir.create("data")
}

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(
   url
   , 'data/dataSet.zip', 
   method='curl')

unzip('data/dataSet.zip')