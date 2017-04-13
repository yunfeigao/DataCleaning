### The code is doing the following 6 functions to generate the final tidy dataset:

#### 0. data import

It imports the training set and testing set data, as well as the *feature names* and *activity labels* lookup dataset.


#### 1. data merging

It combines the subject id and activities labels to the feature dataset, for both train and test sets, and then row-bind this two data set together into a full dataset called **data**.


#### 2. column extraction

It extracts only the measurements on the mean and standard deviation for each measurement. 

Two logic array index for the variables whose names contain str "mean()" and "std()" are calucated, its value is "TRUE" wherever there is a string "mean()" or "std()" in that location. And this two index vectors are combined through "or" operation.
Then the full dataset is subsetted into a concise dataset called **dataSmall**, with the index vector.


#### 3. descriptive activity names

It uses descriptive activity names to name the activities in the data set.

First the code does a little data cleaning by setting the activity names into lower case characters in the *activityLabels* data frame. This serves as a lookup table connecting the activity ID number to the real name.

Then the second column of the **dataSmall** data, which contains the activities ID number, is used together with the lookup table to create a new variable called **activitynames**. 

Finally the original activity ID number column is removed from the data set, which is replaced by the **activitynames** column. 


### 4. descriptive variable names

The variable names (column names) are separated into different parts and renamed into the more descriptive names, and put back to replace the original ones.


### 5. average value calculation

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

We first group the data by participant ID and activity names, and calculate average values for all variables in each group, then store it in a new dataset **avgmatrix**, and write it into .txt file.









