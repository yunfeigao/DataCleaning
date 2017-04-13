install.packages("dplyr")
library(dplyr)

###################################################################################
## 0. Data loading
###################################################################################

activitylabels <- read.table("./activity_labels.txt", header=FALSE) 
features <- read.table("./features.txt", header=FALSE) 

trainx <- read.table("./train/X_train.txt", header = FALSE) %>% tbl_df()
trainy <- read.table("./train/y_train.txt", header = FALSE) %>% tbl_df()
trainsub <- read.table("./train/subject_train.txt", header = FALSE) %>% tbl_df()

testx <- read.table("./test/X_test.txt", header = FALSE) %>% tbl_df()
testy <- read.table("./test/y_test.txt", header = FALSE) %>% tbl_df()
testsub <- read.table("./test/subject_test.txt", header = FALSE) %>% tbl_df()


###################################################################################
## 1. Merges the training and the test sets to create one data set.
###################################################################################

# combine the subject id (trainsub) and activities labels (trainy) to the 
# feature dataset 
names(trainsub) <- "subID"
names(trainy) <- "actLabel"
trainfull <- cbind(trainsub, trainy, trainx) %>% tbl_df()
featurenames <- as.character(features[, 2])
names(trainfull) <- c("subID", "actLabel", featurenames)

# combine the subject id (testsub) and activities labels (testy) to the 
# feature dataset 
names(testsub) <- "subID"
names(testy) <- "actLabel"
testfull <- cbind(testsub, testy, testx) %>% tbl_df()
names(testfull) <- c("subID", "actLabel", featurenames)

## rbind trainfull and testfull into one data set 
data <- rbind(trainfull, testfull)


###################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement.
###################################################################################

# logic array index for the variables whose names contain str "mean()" and "std()"
meanInd <- grepl("mean\\()", featurenames)
stdInd <- grepl("std\\()", featurenames)
Ind <- c(TRUE, TRUE, meanInd|stdInd)

# subset the full data set with the extracted index
dataSmall <- data[, Ind]


###################################################################################
## 3. Uses descriptive activity names to name the activities in the data set
###################################################################################

# tranform the 2nd column of the activitylabels dataset (activity names) into 
# characters and lower case
activitylabels[, 2] <- tolower(as.character(activitylabels[, 2]))

# rename the 2nd column from activity code (1~6) into real activity names
dataSmall1 <- dataSmall %>% 
        mutate(activitynames=sapply(actLabel, function(x) activitylabels[x, 2])) %>%
        select(1, ncol(dataSmall)+1, 3:ncol(dataSmall))


###################################################################################
## 4. Appropriately labels the data set with descriptive variable names.
###################################################################################

# function that separate one variable name into different parts and rename them
# more descriptively
varNames <- function (x) {
        namev <- strsplit(x, "-")[[1]]
        
        domain <- ifelse(grepl("^t", namev[1]), "TimeDomain", 
                         "FrequencyDomain")
        
        signal <- sub("^f", "", sub("^t", "", namev[1]))
        
        stat <- ifelse(grepl("mean", namev[2]), "MeanOf", 
                       "StandardDevOf")
        
        if(length(namev)==3) {
                axis <- ifelse(namev[3]=="X", "InX", 
                               ifelse(namev[3]=="Y", "InY",
                                      ifelse(namev[3]=="Z", "InZ" ) ) )
                onenamenew <- paste(domain, stat, signal, axis, 
                                    sep = "_")
        } else {onenamenew <- paste(domain, stat, signal, 
                                    sep = "_")}
        onenamenew
}

# apply the renaming function to all variables in the dataset
variableNames <- sapply(names(dataSmall1)[3:ncol(dataSmall1)], varNames)
names(dataSmall1) <- c("Participant_ID", "Activity_Names", variableNames)

###################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
###################################################################################

# group the data by participant ID and activity names, and calculate average values
# for all variables in each group
avgmatrix <- dataSmall1 %>% 
                group_by(Participant_ID, Activity_Names) %>% 
                summarise_all(funs_("mean")) %>%
                arrange(Participant_ID, Activity_Names)
avgmatrix

# output the final tidy data set into .txt file
write.table(avgmatrix, file="tidydataMean.txt", row.names = FALSE)




