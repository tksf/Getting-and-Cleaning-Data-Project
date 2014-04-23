CodeBook for the Getting and Cleaning Data class project
==============


run_analysis.R  
--------------

The script mangles the data to the format desired by athe assignement

It uses multiple variables for defining the file names that are used as input for the script. All are part of the zip file for the assigment.

Other significan variables are:

- activityLookup: list containing valid values for activities. Can be used y indexing it with numeric value of the activity.
- indexes: indexes of the features that we are interested in
- index_names: names of those features

- y: list of y (outcome) values
- subject: the id of the subject
- y_values: data frame combining the two previous variables

- combi: the data frame containing all the data we are interested in. 
- tidy_frame: the data frame containing averages of the measurements as asked in the assiggnment

The flow of the script  
--------------

- define inputfiles to be used by the script
- read in features
- figure out which ones we are interested in std() and mean() measurements
- read in trainign and testing data and combine them
- create combi data frame that has the date in the format we want
- create tidy data from data frame to produce the output expected
- write the output file

