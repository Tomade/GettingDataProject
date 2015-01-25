library(dplyr)

# --- STEP 1: "Merges the training and the test sets to create one data set."
s <- read.table('test/subject_test.txt')
y <- read.table('test/y_test.txt')
x <- read.table("test/X_test.txt")
testData <- cbind(s, y, x)  # subject ID, activity code, feature values

s <- read.table('train/subject_train.txt')
y <- read.table('train/y_train.txt')
x <- read.table("train/X_train.txt")
trainData <- cbind(s, y, x)

data <- rbind(testData, trainData)

# --- STEP 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
# Give features all their names from source data
f <- read.table('features.txt')
featureNames <- as.character(f[,2])
names(data) <- c("Subject", "Activity", featureNames)

# Extract only features with "mean()" or "std()" in their names
interestingFeaturesIndices <- grep("mean\\(\\)|std\\(\\)", names(data))
data <- data[,c(1, 2, interestingFeaturesIndices)]

# --- STEP 3: "Uses descriptive activity names to name the activities in the data set."
activity_labels <- read.table("activity_labels.txt")
data$Activity <- factor(data$Activity, labels=activity_labels[,2])

# --- STEP 4: "Appropriately labels the data set with descriptive variable names."
names(data) <- gsub("\\(\\)|-", "", names(data))  # remove all brackets in column names
names(data) <- gsub("mean", "Mean", names(data))  # capitalize "mean"
names(data) <- gsub("std", "Std", names(data))    # capitalize "std"

# --- STEP 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
output <- summarise_each(group_by(data, Subject, Activity), funs(mean))
write.table(output, file = "tidy.txt", row.names = FALSE)

