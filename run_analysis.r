###########################
## Code and data locations
###########################

## go to working directory containing the code: 
## if the directory is called wdir (wdir <- c:/............) then use
## setwd(wdir)


## it is required to download and unzip the project data from the link:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## The wworking directory should contain a sub-directory "UCI HAR Dataset", 
## containing the unziped data

#######################
## libraries used
#######################
library(dplyr)                  ## select, rename
library(reshape2)               ## melt, dcast


###################################################################
### 1 Merges the training and the test sets to create one data set.
###################################################################

## 1.1 first read all necessary tables
######################################

## In order to use colClasses, you have to know the class of each column in your 
## data frame. You can read in just a few rows of the table and then create a vector 
## of classes from just the few rows. 
tab5rows <- read.table("./UCI HAR Dataset/test/X_test.txt", header = F, nrows = 5)
classes <- sapply(tab5rows, class)

## read the test table and check dimensions
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = F, colClasses = classes)
dim(xtest)

## read the training table and check dimensions
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = F, colClasses = classes)
dim(xtrain)

## read activity labels table (6 different activities)
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F)
dim(activities)

## read features labels table (561 different features)
features <- read.table("./UCI HAR Dataset/features.txt", header = F)
nb_features <- nrow(features)   ## needed below


## read activity number table associated with the test obs (6 different activities)
tab5rows <- read.table("./UCI HAR Dataset/test/y_test.txt", header = F, nrows = 5)
classes <- sapply(tab5rows, class)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = F, colClasses = classes)
dim(ytest)

## read activity number table associated with the training obs (6 different activities)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = F, colClasses = classes)
dim(ytrain)

## read subjects nb table associated with the test obs (24 different subjects had a test participation)
tab5rows <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = F, nrows = 5)
classes <- sapply(tab5rows, class)
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = F, colClasses = classes)
dim(stest)

## read subjects nb table associated with the training obs (the 30 different subjects had a training participation)
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = F, colClasses = classes)
dim(strain)


## 1.2 consistent merging of the test and training data
#######################################################
## actual merging of the test and training observations
xmerge <- rbind(xtest,xtrain)
nb_measures <- nrow(xmerge)             ## needed below

## consistent merging of the test and training activities
ymerge <- rbind(ytest,ytrain)

## consistent merging of the test and training subjects
smerge <- rbind(stest,strain)


############################################################################
### 2 Uses descriptive features names to name the features in the data set
############################################################################

## Note: I do this prior to selecting the appropriate data

## 2.1 removing duplicates
##########################

## by peforming the following check
unique(features$V2)
## we can notice that the column 2 of the features data frame contains 477
## different values, whereas the dimension of the table is 561
## This implies that there are duplicate activity names, that must be removed from
## the corresponding columns of the 561 measurement vectors in the xmerge table

## the duplicated function returns a logical vector of the dupicated positions
## the which function returns the corresponding indices
non_duplicated_features_indices <- which(!duplicated(features$V2))

## now we can actually remove the duplicates and get clean data
clean_features <- features$V2[non_duplicated_features_indices]
clean_measures <- xmerge[non_duplicated_features_indices]

## 2.2 renaming the measures names as features names
####################################################

colnames(clean_measures) <- clean_features


#######################################################################
### 3 Extracts only the measurements on the mean and standard deviation 
### for each measurement.
#######################################################################

## The choice of the columns to be analysed is explained in the CodeBook
## for now, we assume that the selected columns are the ones for which the
## feature name contains "mean()' or "std()"
## We end up with 33 columns for mean, and also 33 for std

contains_mean <-select(clean_measures, contains('mean()'))
mean_names<-names(contains_mean)
## creates a first subset of 33 "mean" columns

contains_std <-select(clean_measures, contains('std()'))
std_names<-names(contains_std)
## creates a first subset of 33 "std" columns

## before binding these 2 tables, we must proceed with step 4

########################################################################
### 4 Appropriately labels the data set with descriptive variable names.
########################################################################

## here will will make extensive use of the gsub function to make the feature
## names more readable and also detect and fix labels bugs
## as we we will proceed according to the mean or std, there will be 2 runs
## x will be an intermediary variable to go step by step

## 4.1 rename "mean" features
#############################
x <- gsub('Acc', ' acceleration', mean_names)
x <- gsub('Gyro', ' angular velocity', x)
x <- gsub('Jerk', ' jerk', x)
x <- gsub('Mag', ' magnitude', x)
x <- gsub('BodyBody', 'Body', x)
x <- gsub('tB', 'mean t. B', x)
x <- gsub('tG', 'mean t. G', x)
x <- gsub('fB', 'mean f. B', x)
x <- gsub('-mean()', '', x,fixed=T)             ## as there are brackets
x <- gsub('-X', ' - X axis', x)
x <- gsub('-Y', ' - Y axis', x)
names(contains_mean) <- gsub('-Z', '  - Z axis', x)


## 4.2 rename "std" features
#############################
x <- gsub('Acc', ' acceleration', std_names)
x <- gsub('Gyro', ' angular velocity', x)
x <- gsub('Jerk', ' jerk', x)
x <- gsub('Mag', ' magnitude', x)
x <- gsub('BodyBody', 'Body', x)
x <- gsub('tB', 'std t. B', x)
x <- gsub('tG', 'std t. G', x)
x <- gsub('fB', 'std f. B', x)
x <- gsub('-std()', '', x,fixed=T)              ## as there are brackets
x <- gsub('-X', ' - X axis', x)
x <- gsub('-Y', ' - Y axis', x)
names(contains_std) <- gsub('-Z', '  - Z axis', x)

## 4.3 name activities
######################

## as required in qustion 3 of the assignment
## the activity number is in the 1rst column of the ymerge data frame
## it is overriden by the activity name which is in the 2nd column  
## of the activity table
## activities[ymerge[i,1],2] is a factor coerced to a character
for (i in 1:nb_measures) ymerge[i,1] <-  as.character(activities[ymerge[i,1],2])

###############################################################################
### 5 then creates a second, independent tidy data set with the average of each 
### variable for each activity and each subject. 
###############################################################################

## 5.1 name subjects and activities
###################################
smerge <- rename(smerge,subject = V1)
ymerge <- rename(ymerge,activities = V1)

## 5.2 bind the data frames
###########################

clean_data <- cbind(ymerge,smerge,contains_mean,contains_std)

## 5.3 create the tidy data set
################################

## separate id variables from measures variables
clean_data_melt <- melt(clean_data,id.vars=c('activities','subject'))
head(clean_data_melt,1)         ## quick look

## then cast the result which provides the mean by ativities / subject
tidy_data <- dcast(clean_data_melt,activities+subject~variable,mean)
head(tidy_data ,1)         ## quick look
tail(tidy_data ,1)         ## quick look

###############################################################################
### 6 save the tidy_data to a text file 
###############################################################################

write.table(tidy_data, file='tidy_data.txt', row.names=F)