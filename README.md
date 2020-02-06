# Getting-and-Cleaning-Data-Course-Project
* Goal:The goal of this project is to prepare tidy data that consists of the average (mean) for several variable for each subject and each activity. 
* Steps:
  1. Download the dataset from web and read: train, test, subject, feature and activity datasets.
  2. Select rows from feature dataset wihtin '-mean' and '-std' string and rename column names into 'mean' and 'std'.
  3. Bind by rows training, test and subject data frame
  4. Extract data by selected columns from step iii
  5. Create a data frame named data with subject, y and x mesures
  6. Create tidy data frame that consists of the average (mean) of each variable for each subject and each activity.
