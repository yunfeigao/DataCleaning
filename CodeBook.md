### What is the whole dataset about?

The data contains the quantative information about the measurement of how different people perform in different activities.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist, which contains the embedded accelerometer and gyroscope. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.

Then a set of variables were estimated from these time domain and frequency domain signals, including the mean(), std() and other statistics. This final dataset includes the average of all these mean and std variables, for each activity and each participant.


### What does each row represent?

Each row in the dataset represent the average values of all the mean and std variables in one activity performed by one participant. 


### What doesn each column represent?

The first column contains the ID number of the participant, which ranges from 1 to 30.
The second column contains the activity names that is performed by the participant, which includes the following 6: 
        WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
The other columns contain the **average values** of the mean or standard deviation of the measurement along X, Y, or Z direction in either time or frequency domain.


### What does the name of each variable mean?

The name of each variable (from column 3 to the end) contains the information of the following:
* time domain or frequency domain
* type of acvitity measurement
* mean or standard deviation
* along which axis, or the total value

For example, the number 0.2773308 at the 4th row and 3rd column means that it is the **average value of the measurement** for **participant 1** while he is **WALKING**. The variable name "**TimeDomain_MeanOf_BodyAcc_InX**" means that the measurement is in **time domain**, it is the **mean** value of the **Body Acceleration** in **X direction**.










