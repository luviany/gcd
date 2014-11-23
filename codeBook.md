CodeBook for Getting and Cleaning Data Course Project


trainData <- reading data from X_train.txt
trainLabels <- reading from y_train.txt
trainSubject <- read from subject_train.txt

testData <- reading from test.txt
testLabels <- reading from y_test.txt  
testSubject <- reading from subject_test.txt

mergedAll <- combined dataset from all files above


featureNames <- reading from features.txt
names(mergedAll)[3:563] <- featureNames ## variables names while protecting the first two colums 

mergedAllExtracted <- this dataset contains the values in mergedAll that match mean(average) or std(standard deviation)

activityLabels <- reading from activity_labels.txt

mergedAllExtracted$label <- activityLabels[mergedAllExtracted$label, 2] ##adding the labels to activity column

###looking for various patters and replacing them in the variable names to make them easier to read

descriptiveName  <- contains the list of variable names to be transformed and injected back into the dataset

patterns:
pattern="BodyBody",replacement="Body", 
pattern="^t",replacement="time", 
pattern="^f",replacement="freq", 
pattern="-?std[()][)]-?",replacement="Std"
pattern="-?mean[(][)]-?",replacement="Mean"



tidyDataSetAverages <- copy of mergedAllExtracted dataset
## finding the mean for each group (.SD) organised by (and excluding ) label and subject
tidyDataSetAverages <- tidyDataSetAverages[,lapply(.SD,mean), by = "label,subject"] 

## writing the requiered file to the working directory
write.table(tidyDataSetAverages, "tidyDataSet.txt", row.names = FALSE, sep = ",")

