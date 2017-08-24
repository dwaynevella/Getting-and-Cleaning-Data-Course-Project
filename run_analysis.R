##reading data##

library(dplyr)
library(stringr)

##reading feature and activity labels
featureLabels <- readLines("features.txt")
activityLabels <- readLines("activity_labels.txt")

cleanedfeatureLabels<-gsub("[[:blank:]0-9\\(\\)]", "", featureLabels) #cleaning variable names

##reading test and train X data 
testX <- tbl_df(read.table("test/X_test.txt")) ##reading the test data
trainX <- tbl_df(read.table("train/X_train.txt")) ##reading the test data


## Part 4 - Appropriately labels the data set with descriptive variable names.
colnames(testX)<-cleanedfeatureLabels  ##labeling the Columns
colnames(trainX)<-cleanedfeatureLabels  ##labeling the Columns

testY <- tbl_df(read.table("test/Y_test.txt"))
trainY<-tbl_df(read.table("train/y_train.txt"))


subjecttest <- tbl_df(read.table("test/subject_test.txt"))
subjecttrain<-tbl_df(read.table("train/subject_train.txt"))

traindata<-tbl_df(bind_cols(subjecttrain,trainY,trainX))
testdata <- tbl_df(bind_cols(subjecttest, testY,testX))

colnames(testdata)[1] <- "Subject"
colnames(testdata)[2] <- "Activity"
colnames(traindata)[1] <- "Subject"
colnames(traindata)[2] <- "Activity"


##Part 1 - Merging of dataset
combinedData <-  bind_rows(testdata,traindata) %>% arrange(Subject,Activity) #sorting data in ascending order by subject then by activity

##Part 2 - Extract only the mean and sd of the datasets
tomatch <- c("Activity", "Subject", "mean", "std")
matches <- unique (grep(paste(tomatch,collapse="|"), colnames(combinedData)))
combinedFiltered<-combinedData[matches]


##Part 3 - Uses descriptive activity names to name the activities in the data set
combinedFiltered$Activity<-factor(combinedFiltered$Activity,labels=cleanedactivityLabels) 

#Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summary <- combinedFiltered %>% group_by(Subject, Activity) %>%
summarise_all(funs(mean,sd))

##Outputting the combined filtered dataset and the summarised dataset
write.table(combinedFiltered,'CombinedFiltered.txt')
write.table(summary,"SummarisedDataset.txt")

