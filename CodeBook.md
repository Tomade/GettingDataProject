# Code Book #

This document lists and describes the variables produced by
the `run_analysis.R` script in output to the file `tidy.txt`.

For the most part they are a subset of the variables observed in the
source dataset, with names changed slightly in order to produce legal
R identifiers and improve readability. We also introduce the variables
`"Subject"` and `"Activity"` as required by the assignment.

## Note on variable name transformation ##

As part of the analysis, the names of the variables of interest in the
source dataset had to be modified as follows.

First, parentheses and hyphens present in the variable identifiers of the
source dataset were purged, as these are illegal characters in R
identifiers
(as per [relevant R documentation](http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Identifiers)).

In addition the words `mean` and `std` which were originally
delimited by hyphens in the source dataset have been capitalized (thus ending in
*camelCase*).

To illustrate the transformation, an identifier such as
**`tBodyAcc-mean-X()`** gets renamed to **`tBodyAccMeanX`**, resulting in a
legal R identifier which is also shorter and less noisy to the eye
than the original.

## Data dictionary ##

The resulting data set is made of 180 observations of 68 variables, as
described here:

`Subject` -> integer ranging from 1 to 30, identifying each subject
participating in the study.

`Activity` -> six-level factor (``"WALKING", "WALKING_UPSTAIRS",
"WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"``) encoding the
physical activity the subject was engaged into at the time of the
observation.

The remaining 66 variables represent the numeric **aggregate mean
values** of the corresponding measurements in the source dataset,
grouped by subject and activity.  These are named using a
self-describing nomenclature as follows:

* First character: `t` -> Time domain, `f` -> Frequency Domain (FFT)
* `Body` -> Body
* `Gravity` -> Gravity
* `Acc` -> Accelerometer signal
* `Gyro` -> Gyroscope signal
* `Mag` -> Magnitude
* `Jerk` -> Signal as derived in time
* `Std` -> Standard deviation
* `Mean` -> Mean value
* `X`, `Y`, `Z` -> Axis of measurement

These numeric values were already normalised with a [-1, 1] range in
the source dataset and are pure numbers (no units).


|  N | Variable name            | Type   |
|----|--------------------------|--------|
|  1 | Subject                  | int    |
|  2 | Activity                 | Factor |
|  3 | tBodyAccMeanX            | num    |
|  4 | tBodyAccMeanY            | num    |
|  5 | tBodyAccMeanZ            | num    |
|  6 | tBodyAccStdX             | num    |
|  7 | tBodyAccStdY             | num    |
|  8 | tBodyAccStdZ             | num    |
|  9 | tGravityAccMeanX         | num    |
| 10 | tGravityAccMeanY         | num    |
| 11 | tGravityAccMeanZ         | num    |
| 12 | tGravityAccStdX          | num    |
| 13 | tGravityAccStdY          | num    |
| 14 | tGravityAccStdZ          | num    |
| 15 | tBodyAccJerkMeanX        | num    |
| 16 | tBodyAccJerkMeanY        | num    |
| 17 | tBodyAccJerkMeanZ        | num    |
| 18 | tBodyAccJerkStdX         | num    |
| 19 | tBodyAccJerkStdY         | num    |
| 20 | tBodyAccJerkStdZ         | num    |
| 21 | tBodyGyroMeanX           | num    |
| 22 | tBodyGyroMeanY           | num    |
| 23 | tBodyGyroMeanZ           | num    |
| 24 | tBodyGyroStdX            | num    |
| 25 | tBodyGyroStdY            | num    |
| 26 | tBodyGyroStdZ            | num    |
| 27 | tBodyGyroJerkMeanX       | num    |
| 28 | tBodyGyroJerkMeanY       | num    |
| 29 | tBodyGyroJerkMeanZ       | num    |
| 30 | tBodyGyroJerkStdX        | num    |
| 31 | tBodyGyroJerkStdY        | num    |
| 32 | tBodyGyroJerkStdZ        | num    |
| 33 | tBodyAccMagMean          | num    |
| 34 | tBodyAccMagStd           | num    |
| 35 | tGravityAccMagMean       | num    |
| 36 | tGravityAccMagStd        | num    |
| 37 | tBodyAccJerkMagMean      | num    |
| 38 | tBodyAccJerkMagStd       | num    |
| 39 | tBodyGyroMagMean         | num    |
| 40 | tBodyGyroMagStd          | num    |
| 41 | tBodyGyroJerkMagMean     | num    |
| 42 | tBodyGyroJerkMagStd      | num    |
| 43 | fBodyAccMeanX            | num    |
| 44 | fBodyAccMeanY            | num    |
| 45 | fBodyAccMeanZ            | num    |
| 46 | fBodyAccStdX             | num    |
| 47 | fBodyAccStdY             | num    |
| 48 | fBodyAccStdZ             | num    |
| 49 | fBodyAccJerkMeanX        | num    |
| 50 | fBodyAccJerkMeanY        | num    |
| 51 | fBodyAccJerkMeanZ        | num    |
| 52 | fBodyAccJerkStdX         | num    |
| 53 | fBodyAccJerkStdY         | num    |
| 54 | fBodyAccJerkStdZ         | num    |
| 55 | fBodyGyroMeanX           | num    |
| 56 | fBodyGyroMeanY           | num    |
| 57 | fBodyGyroMeanZ           | num    |
| 58 | fBodyGyroStdX            | num    |
| 59 | fBodyGyroStdY            | num    |
| 60 | fBodyGyroStdZ            | num    |
| 61 | fBodyAccMagMean          | num    |
| 62 | fBodyAccMagStd           | num    |
| 63 | fBodyBodyAccJerkMagMean  | num    |
| 64 | fBodyBodyAccJerkMagStd   | num    |
| 65 | fBodyBodyGyroMagMean     | num    |
| 66 | fBodyBodyGyroMagStd      | num    |
| 67 | fBodyBodyGyroJerkMagMean | num    |
| 68 | fBodyBodyGyroJerkMagStd  | num    |


