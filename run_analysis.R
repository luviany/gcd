## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.

library(data.table)
options(warn = -1)


## set working directory where the files are unzipped and where tidyDataSet.txt is written
## (you migth get errors if you run it more times)

setwd("./UCI HAR Dataset")


## 1. One Dataset out of everything

message("Reading files. This will take the longest... ")

trainData <- read.table("./train/X_train.txt")
trainLabels <- read.table("./train/y_train.txt", col.names="label")
trainSubject <- read.table("./train/subject_train.txt", col.names="subject")

testData <- read.table("./test/X_test.txt")
testLabels <- read.table("./test/y_test.txt", col.names="label")  
testSubject <- read.table("./test/subject_test.txt", col.names="subject")

mergedAll <- rbind(cbind(trainSubject, trainLabels, trainData), cbind(testSubject, testLabels, testData))

## putting the feature names in to make match on the next step
featureNames <- read.table("./features.txt",stringsAsFactors=FALSE)[[2]]
names(mergedAll)[3:563] <- featureNames

message("1. All together")

## 2. the measurements on the mean and standard deviation

mergedAllExtracted <- mergedAll[,grep("mean|std",featureNames)]

message("2. found the mean and std ones")

## 3. Label activity labels with English words

activityLabels <- read.table("./activity_labels.txt", stringsAsFactors=FALSE)
mergedAllExtracted$label <- activityLabels[mergedAllExtracted$label, 2]

message("3. Labeled activities")

## 4. beautify variable names /don't hold it against me if you don't like it 

descriptiveName  <- names(mergedAllExtracted)
names(mergedAllExtracted)[3:79] <- gsub(pattern="BodyBody",replacement="Body",x=descriptiveName)
names(mergedAllExtracted)[3:79] <- gsub(pattern="^t",replacement="time",x=descriptiveName)
names(mergedAllExtracted)[3:79] <- gsub(pattern="^f",replacement="freq",x=descriptiveName)
names(mergedAllExtracted)[3:79] <- gsub(pattern="-?mean[(][)]-?",replacement="Mean",x=descriptiveName)
names(mergedAllExtracted)[3:79] <- gsub(pattern="-?std[()][)]-?",replacement="Std",x=descriptiveName)
## etc etc
names(mergedAllExtracted) <- descriptiveName

message("4. Nicer variable names")

## 5. averages and tidyDateSet.txt

tidyDataSetAverages <- data.table(mergedAllExtracted)
tidyDataSetAverages <- tidyDataSetAverages[,lapply(.SD,mean), by = "label,subject"]
write.table(tidyDataSetAverages, "tidyDataSet.txt", row.names = FALSE, sep = ",")

message("5. Writing the tidyDateSet.txt... you'll find it in the working directory *getwd()")

message("Done and happy!")
