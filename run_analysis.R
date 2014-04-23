# Getting and Cleaning Data project

# features are defined in feaures.txt file, read it and get rid of the index number
featureFile <- "features.txt"
features <- read.table("features.txt")
features <- features[, -1]

# activities are defined in "activity_labels.txt" file, since it's just six, create the list manually
activityLookup <- list()
activityLookup <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# find the features we are intersted in, std() and mean() in the name
# create indexes list that contains theindexes of those features
# also, get names so we can use them when needed
indexes <- grep('std\\(', features)
mean_indexes <- grep('mean\\(', features)
indexes <- sort(append(indexes, mean_indexes))
index_names <- features[indexes]

# the data are in these files
train_yFile <- "train/y_train.txt"
train_xFile <- "train/X_train.txt"
test_yFile <- "test/y_test.txt"
test_xFile <- "test/X_test.txt"
subjectFile <- "train/subject_train.txt"
subjectFile_test <- "test/subject_test.txt"

# read in Y values for train, test and then combine them
y <- scan(train_yFile)
y2 <- scan(test_yFile)
y <- append(y, y2)

# do the same for subjects
subject <- scan(subjectFile)
subject_test <- scan(subjectFile_test)
subject <- append(subject, subject_test)

# create a data frame of the values and replace numbers with text for activities by using the
# activity lookup list we created earlier
y_values <- data.frame("subject" = subject, "activity" = y)
y_values$activity <- activityLookup[y_values$activity]

# read in the X measurements and combine them
# combi data frame will contain all the data we want (and need)
combi <- read.table(train_xFile, header = FALSE, strip.white = TRUE)
combi_test <- read.table(test_xFile, header = FALSE, strip.white = TRUE)
combi <- rbind(combi, combi_test)

# remove all other measures except the ones we want
combi <- combi[, indexes]

# add the names
names(combi) <- index_names

# add the subject and activities from the data frame we created earlier
combi$subject <- y_values$subject
combi$activity <- y_values$activity

#now we have all we need in the combi data frame, let's create the tidy data frame
tidy_frame <- aggregate(combi, by = list(combi$activity, combi$subject), FUN = "mean")

# clean up the data a little, get names right and remove extra features from aggregating
names(tidy_frame)[1] <- "activity"
names(tidy_frame)[2] <- "subject"
tidy_frame <- tidy_frame[,-c(69,70)]

#  write the tidy data outout to a file
output_file = "tidy_data.txt"
write.table(tidy_frame, output_file, quote = FALSE)








