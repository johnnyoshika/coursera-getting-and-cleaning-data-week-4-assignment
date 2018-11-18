# Create results directory if it doesn't exist
if (!file.exists("./results")){dir.create("./results")}

activity_labels <- read.table("./dataset/activity_labels.txt")
features <- read.table("./dataset/features.txt")

subject_test <- read.table("./dataset/test/subject_test.txt")
X_test <- read.table("./dataset/test/X_test.txt")
y_test <- read.table("./dataset/test/y_test.txt")

subject_train <- read.table("./dataset/train/subject_train.txt")
X_train <- read.table("./dataset/train/X_train.txt")
y_train <- read.table("./dataset/train/y_train.txt")

# 0. Prepare
# merge activity IDs and subject IDs into data sets
test <- cbind(y_test, subject_test, X_test)
train <- cbind(y_train, subject_train, X_train)

# 1. Merges the training and the test sets to create one data set.
full_dataset <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# extracted_features lists features that we're extracting
pattern <- "-mean\\(\\)|-std\\(\\)"
extracted_features <- grep(pattern, features$V2, value = TRUE)
extracted_features <- append(c("activity_id", "subject_id"), extracted_features)# account for activty and subject coluns that we prepended
# columns is a vector of booleans
columns <- grepl(pattern, features$V2)
columns <- append(c(TRUE, TRUE), columns) # account for activty and subject coluns that we prepended
# mean_and_std only contains data with variables with -mean() or _std() in the name.
mean_and_std <- full_dataset[,columns]

# 3. Uses descriptive activity names to name the activities in the data set
# Match by first column and append activity_labels to the end of mean_and_std
# Note: merge's sort is TRUE by default, which will sort by the 'by' column.
# If we wanted to preserve order, we could have used plyr's join instead, as merge's sort = FALSE doesn't preserve order.
# In this assignment, the order doesn't matter, so we'll just proceed with merge.
activities <- merge(mean_and_std, activity_labels, by = "V1")

# 4. Appropriately labels the data set with descriptive variable names
names(activities) <- append(extracted_features, "activity_name")
write.csv(activities, file = "./results/activities.csv")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# split our activities by subject_id and activity_name
split_by <- interaction(activities$subject_id, activities$activity_name)
activites_by_subject_and_activity <- split(activities, split_by, drop = TRUE)
# use -ncol to remove the last column, which is the activity_name, which is a character vector and mean can't be calculated
activity_means <- sapply(activites_by_subject_and_activity, function(x) colMeans(x[,-ncol(x)]))
# activity_means now shows features as rows and groups as columns, so switch them around
activity_means <- t(activity_means)
write.csv(activity_means, file = "./results/activity_means.csv")