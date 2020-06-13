This repo is the course project of "Getting and Cleaning Data" course offered on Coursera
This file explains the working of the source code
Step 1: Reading the required files: 
        activity_labels.txt, features.txt, X_train.txt, Y_train.txt,
        subject_train.txt, x_test.txt, Y_test.txt, subject_test.txt
Step 2: Sort , filter and subset the columns of only required mean and standard deviation variables
Step 3: Merge the two datasets
Step 4: Modifies activity and subject as factors
Step 5: Calculates the mean of each variable of each subject-variable pair
Step 6: Write the dataset to tidy.txt file
