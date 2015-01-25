# Gettingdataproject
Course project for Coursera / Johns Hopkins "Getting and Cleaning Data" class

## Introduction

This repository contains copies of the R script `run_analysis.R` and associated Code
Book I developed for the "Getting and Cleaning Data" course project,
offered by Coursera in collaboration with Johns Hopkins Bloomberg
School of Public Health in January 2015.  It is published here to the
purpose of obtaining peer review and grading, as required in order to
successfully complete the class.

The purpose of this project is to demonstrate the ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis.  The source data represent
pre-processed measurements collected from the sensor signals in the
Samsung Galaxy S smartphone, as thirty volunteers performed six
different physical activities.


### Files included

* `README.md` : this text
* `run_analysis.R`: the R script performing the computational section
of the assignment
* `CodeBook.md` : text describing variables, data and transformation
  the scripts operates on, as well as the structure of the output
  (submitted separately).

-------

## Source dataset

A full description of the source dataset and how it was put together is
available at
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
from the UCI Machine Learning repository.

[Source dataset in ZIP format](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

----

## The script `run_analysis.R`

### Required libraries and preliminary steps
1. Ensure that the `dplyr` library is available in your R installation.  If not,
this can be accomplished at the R prompt with:

    ```r
    install.packages("dplyr")
    ```

2. Obtain a copy of the
   [source dataset in ZIP format](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
   and expand the contents in a convenient location on your system.

3. Place a copy of the `run_analysis.R` script found in this repository inside
   the directory created in the previous step, so that the `train` and
`test` subdirectories are present where the script is.

### Analysis performed
The script specifications as published on the class website are:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each
measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data
set with the average of each variable for each activity and each
subject.

In the following sections, I illustrate how I chose to implement each of these
steps.

#### 1. Merges the training and the test sets to create one data set.

The script reads in the contents of the files `subject_test.txt`, `y_test.txt`
and `X_test.txt` from the `test` subdirectory with three calls to
`read.table()`, and glues together the three resulting data frames "side by
side" using `cbind()` and assigning the returned data frame to `testData`.

After performing analogous steps in the `train` subdirectory to collect the
training data in `trainData`, the two resulting data frames are combined
row-wise with `rbind()`, saving the now complete set in `data`.

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

This involves selecting only the variables with the strings `"mean()"` or `"std()"` in their
names.  At this stage we do not even have the names yet, however, so we first read them
from the file `features.txt` and assign them to our main dataframe, together
with the names "Subject" and "Activity" for the first two columns.  Reading from
`features.txt` gives us a factor for the feature names, so they also have to be
converted to character:

```r
f <- read.table('features.txt')
featureNames <- as.character(f[,2])
names(data) <- c("Subject", "Activity", featureNames)
```

Discarding the variables that do not satisfy our requirements is done by
creating a selection vector using a regular expression search on the frame
names, and reassigning the subset to our main frame.

```r
interestingFeaturesIndices <- grep("mean\\(\\)|std\\(\\)", names(data))
data <- data[,c(1, 2, interestingFeaturesIndices)]
```

#### 3. Uses descriptive activity names to name the activities in the data set

The six activity names are found in the file `activity_labels.txt` shipped with the
source dataset.  I chose to convert the activity column to a factor and use the
activity names as labels.  This works because the level numbers naturally match across the
two tables.

```r
activity_labels <- read.table("activity_labels.txt")
data$Activity <- factor(data$Activity, labels=activity_labels[,2])
```

#### 4. Appropriately labels the data set with descriptive variable names.

The variables names in the source dataset are problematic for various reasons,
however after discarding most of them in step #2 the main remaining issue is the
presence of characters in them that are not allowed in R identifiers.  I solve
this and attempt to improve readability with three separate regexp search and
replace operations.
```r
names(data) <- gsub("\\(\\)|-", "", names(data))  # remove all brackets in column names
names(data) <- gsub("mean", "Mean", names(data))  # capitalize "mean"
names(data) <- gsub("std", "Std", names(data))    # capitalize "std"
```

More information on this transformation can be found in the Code Book made
available in this reposity.

#### 5. From the data set in step 4, creates a second, independent tidy data
set with the average of each variable for each activity and each
subject.

This step was made very simple and concise thanks to the `summarise_each()`
function made available by the `dplyr` library.  I could aggregate the
information as required and save the results to a text file with:

```r
output <- summarise_each(group_by(data, Subject, Activity), funs(mean))
write.table(output, file = "tidy.txt", row.names = FALSE)
```

----

## Output

Upon successful execution, the resulting dataframe with 180 observations of 68
variables is dumped to a text file `tidy.txt`, which can be read back into R with:

```r
read.table("tidy.txt", header = TRUE)
```

The first row in the output file is an additional header row with the chosen column names.

----

## Licensing information

All code and text in this repository are released in the public domain and may
be freely shared and redistributed, as long as attribution to the original
author and repository is preserved and they are not plagiarized for future
offerings of the class.

The source dataset was first published in:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge
L. Reyes-Ortiz.  
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly
Support Vector Machine.  
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*
