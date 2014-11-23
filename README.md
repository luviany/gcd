## Getting and Cleaning Data Course Project

Assumptions: 
The Data is unzipped in "in your working directory" as per request

Here's run_analysis.R works:

1. The script first activates data.table library and cancels warning output
2. The working directory is set (as the data directory) 
3. The files are read and combined thus fulfilling requirement 1*(see Requierements)
4. Variable names are added to the data set to enable matching for the next step
5. Extracting "mean|std" variables with grep thus fulfilling 2*
6. Reading activity names from the file and writing it to the label colum, thus fulfilling 3*
7. Make variable names nicer by replacing annyoing patterns with more leggible version, fulfilling 4*
8. Copy existing dataset to a new one
9. Calculate and order average per activity and subject
9. Write out the resulting tidy data set to the working directory, thus fulfilling 5*


*Requirements
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.

Thank you!