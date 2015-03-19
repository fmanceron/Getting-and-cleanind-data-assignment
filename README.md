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




 
 