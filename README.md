# Project Assignment Guidelines
## Components of the assignment
The project assignment for this "Getting an Cleaning Data" course is composed of the following files:

 - This README.md markdown file located on the following GitHub repo:
 
		https://github.com/fmanceron/Getting-and-cleaning-data-assignment
		
 - A CodeBook.md file located in the same GitHub repository explaining the data manipulations
 
 - A features_info.txt file located in the same GitHub repository explaining the measures made, as a complementary explanation to the CodeBook 

 - An 'R' code file called run_analysis.r containing the code and instruction list. 
		Directories structures to be able to run the code will be explained there.
		
		The code file is ready to be executed, provided the code and data files are in the appropriate directory, as described in the code file.


 - A tidy data file called tidy_data.txt, produced by the run_analysis.r program in the working directory, as described in the instruction list

		This text file should be read and checked by executing the following commands once you have downloaded it to your working directory
				
				xxx <- read.table(file='tidy_data.txt',header=T)
				str(xxx)
				head(select(xxx,1:4),32)
				tail(select(xxx,1:4),32)

The following steps have been carried out from the raw to the tidy data:

		### 1 Merges the training and the test sets to create one data set.	
			## 1.1 first read all necessary tables
			## 1.2 consistent merging of the test and training data
		### 2 Uses descriptive features names to name the features in the data set
			## 2.1 removing duplicates
			## 2.2 renaming the measures names as features names
		### 3 Extracts only the measurements on the mean and standard deviation for each measurement.	
		### 4 Appropriately labels the data set with descriptive variable names	
			## 4.1 rename "mean" features
			## 4.2 rename "std" features
			## 4.3 name activities as required in question 3 of the assignment
		### 5 then creates a second, independent tidy data set with the average of each variable for each activity and each subject.	
			## 5.1 name subjects and activities
			## 5.2 bind the data frames
			## 5.3 create the tidy data set
		### 6 save the tidy_data to a text file	
			
			