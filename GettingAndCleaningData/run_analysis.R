###############################################################################
# Codes for Coursera Project: Getting and Cleaning Data
# Author: Haobo Jia
# Date: 2014-12-08
# Work on data set: UCI-HAR-Dataset
###############################################################################
# TASKS:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
###############################################################################

###############################################################################
# load packages
library(data.table)
###############################################################################

###############################################################################
# set data path
# path.rawdata <- "g:/Coursera/Data Science/Github/RawData/UCI-HAR-Dataset/"
# set path.rawdata = "", when the dataset in the same directory
path.rawdata <- ""
###############################################################################

###############################################################################
# get variable names from "features.txt"
raw.variable <- read.csv(paste0(path.rawdata,"features.txt"),
                         header = F,sep = "\n",stringsAsFactors=F)
variable <- data.table(variable=sapply(raw.variable[,1],
                                       function(x) unlist(strsplit(x, split=" "))[2]))
rm(raw.variable);gc()
###############################################################################

###############################################################################
# function for cleaning the data
splitvar <- function(x)
{
  tmp <- unlist(strsplit(as.character(x),split=" "))
  return(tmp[tmp!=""])
}
###############################################################################

###############################################################################
## Step 1
# Merges the training and the test sets to create one data set.
###############################################################################
# get train data
train_subject <- read.csv(paste0(path.rawdata,"train/subject_train.txt"),
                          header = F,sep = "\n",stringsAsFactors=F)[,1]
train_y <- read.csv(paste0(path.rawdata,"train/y_train.txt"),
                    header = F,sep = "\n",stringsAsFactors=F)[,1]
raw.train_X <- data.table(
  train_X=read.csv(paste0(path.rawdata,"train/X_train.txt"),
                   header = F,sep = "\n",stringsAsFactors=F)[,1]
)
train <- data.table(t(sapply(1:nrow(raw.train_X), function(i) splitvar(raw.train_X[i,]))))
setnames(train,variable$variable)
rm(raw.train_X);gc()
train[,':=' (y=train_y,
             subject=train_subject,
             set_type="train")]
rm(train_subject,train_y);gc()
###############################################################################

###############################################################################
# get test data
test_subject <- read.csv(paste0(path.rawdata,"test/subject_test.txt"),
                         header = F,sep = "\n",stringsAsFactors=F)[,1]
test_y <- read.csv(paste0(path.rawdata,"test/y_test.txt"),
                   header = F,sep = "\n",stringsAsFactors=F)[,1]
raw.test_X <- data.table(
  test_X=read.csv(paste0(path.rawdata,"test/X_test.txt"),
                  header = F,sep = "\n",stringsAsFactors=F)[,1]
)
test <- data.table(t(sapply(1:nrow(raw.test_X), function(i) splitvar(raw.test_X[i,]))))
setnames(test,variable$variable)
rm(raw.test_X);gc()
test[,':=' (y=test_y,
            subject=test_subject,
            set_type="test")]
rm(test_subject,test_y);gc()
###############################################################################

###############################################################################
# merge train and test
raw.dataset <- rbind(train,test)
rm(train,test,splitvar,path.rawdata);gc()
###############################################################################

###############################################################################
## Step 2
# Extracts only the measurements on the mean and standard deviation for each
# measurement.
###############################################################################
# get mean and std data
submean <- grep("[Mm]ean[:(:]",variable$variable)
substd <- grep("[Ss]td",variable$variable)
subset <- variable[sort(union(submean,substd))]
dataset <- raw.dataset[,c(subset$variable,"y","subject","set_type"),with=FALSE]
rm(raw.dataset,subset,submean,substd,variable);gc()
###############################################################################

###############################################################################
## Step 3
# Uses descriptive activity names to name the activities in the data set
###############################################################################
activity <- data.table(number=1:6,
                       activity=c("WALKING","WALKING_UPSTAIRS",
                                  "WALKING_DOWNSTAIRS",
                                  "SITTING","STANDING","LAYING"))
dataset[,activity:=activity[dataset$y,]$activity]
rm(activity);gc()
###############################################################################

###############################################################################
## Step 4
# Appropriately labels the data set with descriptive variable names.
###############################################################################
dataset[,':='(y=NULL,set_type=NULL)]
colnm <- gsub("-","_",colnames(dataset))
colnm <- gsub("[:():]","",colnm)
colnm <- gsub("^t", "Time", colnm)
colnm <- gsub("^f", "Frequency", colnm)
colnm <- gsub("Acc", "Acceleration", colnm)
colnm <- gsub("Gyro", "Gyroscopic", colnm)
colnm <- gsub("Mag", "Magnitude", colnm)
colnm <- gsub("BodyBody", "Body", colnm)
setnames(dataset,colnm)
###############################################################################

###############################################################################
## Step 5
# From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
###############################################################################
dataset <- dataset[,lapply(.SD,as.numeric),by=.(activity)]
averagedataset <- dataset[,lapply(.SD,mean),by=.(subject,activity)]
colnames(averagedataset)[-(1:2)] <- paste0("Average",colnames(averagedataset)[-(1:2)])
write.table(averagedataset,file="averagedataset.txt",row.name=FALSE,sep = ",")
###############################################################################

