# Project Assignment code book
## Study Design
The raw data for this assignment were downloaded from 
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and unzipped as described in the code instruction list

## Code Book
### raw data acquisition
xtest: 		
	
	raw measurements test table / 2947 obs of 561 variables

xtrain:		
	
	raw measurements data training table / 7352 obs of 561 variables (561 features vector)

		All the measurements are normalized and bounded within [-1,1]
		Each feature vector is a row on the xtext and xtrain tables
		
activities:	

	raw activities data table / matches activity name and activity number / 6 activities

		1 WALKING
		2 WALKING_UPSTAIRS
		3 WALKING_DOWNSTAIRS
		4 SITTING
		5 STANDING
		6 LAYING

features:	

	raw features list / matches feature name and feature number / 561 features
	
	nb_features: number of features in the feature table (561)
	
ytest:		

	raw features obs vector for the test phase / 	vector of 2947 obs

ytrain:		

	raw features obs vector for the training phase / 	vector of 7352 obs

stest:		

	raw subjects obs vector for the test phase / 	vector of 2947 obs

strain:		

	raw subjects obs vector for the training phase / 	vector of 7352 obs

		Note: there are 30 different subjects whose number appears in the stest ans strain tables

### merging the test and training 
xmerge:		

	data frame aggregating all the measurements / (2947+7352=10299)obs of 561 variables
	
	nb_measures: total number of measures (10299) in the xmerge table

ymerge:		

	data frame aggregating all the feature obs / (2947+7352=10299)obs

smerge:		

	data frame aggregating all the subjects obs / (2947+7352=10299)obs

### removing duplicates 
non_duplicated_features_indices: 

	vector containing the indices of the features table which are unique / (477 values out of 561)

clean_features:	

	subset of the features table containing the non duplicates features / 477 values

clean_measures:	

	subset of the xmerge table where only the non duplicated columns have been selected / 10299 obs of 477 variables
				
### selecting the columns that will be used for the tidy data required
The feature_info.txt file explains in details the principles of the study. It can be seen that "the signals used to estimate variables of the feature vector for each pattern" were:
			
			tBodyAcc-XYZ
			tGravityAcc-XYZ
			tBodyAccJerk-XYZ
			tBodyGyro-XYZ
			tBodyGyroJerk-XYZ
			tBodyAccMag
			tGravityAccMag
			tBodyAccJerkMag
			tBodyGyroMag
			tBodyGyroJerkMag
			fBodyAcc-XYZ
			fBodyAccJerk-XYZ
			fBodyGyro-XYZ
			fBodyAccMag
			fBodyAccJerkMag
			fBodyGyroMag
			fBodyGyroJerkMag
		
		'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions

The clean_features table shows that mean ans standard deviation (std) are present for each of those signals.
		
I considered therefore that the objective was to concentrate on these features, which ends up with 33 features for the mean of these signals, and 33 for the std.
		
contains_mean:	

	subset of the clean_measures table, reduced to the 33 features for the mean / 10299 obs of 33 variables

mean_names:		

	vector containing the 33 "raw" names of these features

contains_std:	

	subset of the clean_measures table, reduced to the 33 features for the std / 10299 obs of 33 variables

std_names:		

	vector containing the 33 "raw" names of these features

### creating the tidy data required
clean_data:		

	table obtained by binding the columns of ymerge, smerge,contains_mean,contains_std / 10299 obs of (1 + 1 + 33 + 33 = 68) variables

clean_data_melt: 

	table obtained by melting the clean_data table above, assuming there are 2 id variables (activities and subject) used for subsetting / (10299 * 66 = 679734) rows, and 4 columns (activities subject variable value)
				
tidy_data:		

	table giving the mean of each subset of the clean_data_melt 
	(6 activities * 30 subjects = 180 subsets, for which we compute the mean of the 66 features.
				
		As a result: a table of 180rows and 2+66 = 68 columns for activities, subject, and 66 features.
				