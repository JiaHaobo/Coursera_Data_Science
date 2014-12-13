## Data Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### Subject Set
The column with name "subject" stands for the 30 volunteers. The value of "subject" is from 1 to 30.

### Activity Set
The variable "activity" varies from 1 to 6. The meanings are as follows.

|Value|Activity           |
|-----|-------------------|
|1    | WALKING           |
|2    | WALKING_UPSTAIRS  |
|3    | WALKING_DOWNSTAIRS|
|4    | SITTING           |
|5    | STANDING          |
|6    | LAYING            |

### Features Set

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. _Features are normalized and bounded within [-1,1]._

The detailed descriptions of the Raw Data Set can be find in __feactures\_info.txt__.

By appling the R script **run_analysis.R** on the Raw Data Set, we can get the Tidy Data Set __averagedataset.txt__. All the variable names are assigned descriptively. Since all the features in the Raw Data Set are normalized and bouded within [-1,1], by transformation of **mean** and **std**, the features variables in the Tidy Data Set is also within [-1,1], and have no units. Follows are the list of the variables in the Tidy Data Set _averagedataset.txt_.

|Variables|
|---------|
|AverageTimeBodyAcceleration\_mean\_X|
|AverageTimeBodyAcceleration\_mean\_Y|
|AverageTimeBodyAcceleration\_mean\_Z|
|AverageTimeBodyAcceleration\_std\_X|
|AverageTimeBodyAcceleration\_std\_Y|
|AverageTimeBodyAcceleration\_std\_Z|
|AverageTimeGravityAcceleration\_mean\_X|
|AverageTimeGravityAcceleration\_mean\_Y|
|AverageTimeGravityAcceleration\_mean\_Z|
|AverageTimeGravityAcceleration\_std\_X|
|AverageTimeGravityAcceleration\_std\_Y|
|AverageTimeGravityAcceleration\_std\_Z|
|AverageTimeBodyAccelerationJerk\_mean\_X|
|AverageTimeBodyAccelerationJerk\_mean\_Y|
|AverageTimeBodyAccelerationJerk\_mean\_Z|
|AverageTimeBodyAccelerationJerk\_std\_X|
|AverageTimeBodyAccelerationJerk\_std\_Y|
|AverageTimeBodyAccelerationJerk\_std\_Z|
|AverageTimeBodyGyroscopic\_mean\_X|
|AverageTimeBodyGyroscopic\_mean\_Y|
|AverageTimeBodyGyroscopic\_mean\_Z|
|AverageTimeBodyGyroscopic\_std\_X|
|AverageTimeBodyGyroscopic\_std\_Y|
|AverageTimeBodyGyroscopic\_std\_Z|
|AverageTimeBodyGyroscopicJerk\_mean\_X|
|AverageTimeBodyGyroscopicJerk\_mean\_Y|
|AverageTimeBodyGyroscopicJerk\_mean\_Z|
|AverageTimeBodyGyroscopicJerk\_std\_X|
|AverageTimeBodyGyroscopicJerk\_std\_Y|
|AverageTimeBodyGyroscopicJerk\_std\_Z|
|AverageTimeBodyAccelerationMagnitude\_mean|
|AverageTimeBodyAccelerationMagnitude\_std|
|AverageTimeGravityAccelerationMagnitude\_mean|
|AverageTimeGravityAccelerationMagnitude\_std|
|AverageTimeBodyAccelerationJerkMagnitude\_mean|
|AverageTimeBodyAccelerationJerkMagnitude\_std|
|AverageTimeBodyGyroscopicMagnitude\_mean|
|AverageTimeBodyGyroscopicMagnitude\_std|
|AverageTimeBodyGyroscopicJerkMagnitude\_mean|
|AverageTimeBodyGyroscopicJerkMagnitude\_std|
|AverageFrequencyBodyAcceleration\_mean\_X|
|AverageFrequencyBodyAcceleration\_mean\_Y|
|AverageFrequencyBodyAcceleration\_mean\_Z|
|AverageFrequencyBodyAcceleration\_std\_X|
|AverageFrequencyBodyAcceleration\_std\_Y|
|AverageFrequencyBodyAcceleration\_std\_Z|
|AverageFrequencyBodyAccelerationJerk\_mean\_X|
|AverageFrequencyBodyAccelerationJerk\_mean\_Y|
|AverageFrequencyBodyAccelerationJerk\_mean\_Z|
|AverageFrequencyBodyAccelerationJerk\_std\_X|
|AverageFrequencyBodyAccelerationJerk\_std\_Y|
|AverageFrequencyBodyAccelerationJerk\_std\_Z|
|AverageFrequencyBodyGyroscopic\_mean\_X|
|AverageFrequencyBodyGyroscopic\_mean\_Y|
|AverageFrequencyBodyGyroscopic\_mean\_Z|
|AverageFrequencyBodyGyroscopic\_std\_X|
|AverageFrequencyBodyGyroscopic\_std\_Y|
|AverageFrequencyBodyGyroscopic\_std\_Z|
|AverageFrequencyBodyAccelerationMagnitude\_mean|
|AverageFrequencyBodyAccelerationMagnitude\_std|
|AverageFrequencyBodyAccelerationJerkMagnitude\_mean|
|AverageFrequencyBodyAccelerationJerkMagnitude\_std|
|AverageFrequencyBodyGyroscopicMagnitude\_mean|
|AverageFrequencyBodyGyroscopicMagnitude\_std|
|AverageFrequencyBodyGyroscopicJerkMagnitude\_mean|
|AverageFrequencyBodyGyroscopicJerkMagnitude\_std|
