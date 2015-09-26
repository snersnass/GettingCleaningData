# If you want to test, set your own working directory here
setwd("C:\\Users\\PC\\Documents\\R\\coursera\\UCI HAR Dataset")

# Read the data = all data straight from a file is called "raw"
rawActLabels <- read.table("activity_labels.txt")
rawFeatures <-  read.table("features.txt")

testPathPrefix <- "test\\"  #  windows
trainPathPrefix <- "train\\"  #  windows
#testPathPrefix <- "test/"   #  mac
#trainPathPrefix <- "train/"   #  mac

# windows paths
rawTestSubj <- read.table(paste(testPathPrefix,"subject_test.txt", sep=""))
rawTestX <- read.table(paste(testPathPrefix,"X_test.txt", sep=""))
rawTestY <- read.table(paste(testPathPrefix,"Y_test.txt", sep=""))
rawTrainSubj <- read.table(paste(trainPathPrefix,"subject_train.txt", sep=""))
rawTrainX <- read.table(paste(trainPathPrefix,"X_train.txt", sep=""))
rawTrainY <- read.table(paste(trainPathPrefix,"Y_train.txt", sep=""))


# 1. Merge the data sets

library(dplyr)

mergedX <- rbind(rawTestX, rawTrainX)
mergedY <- rbind(rawTestY, rawTrainY)
mergedSubj <- rbind(rawTestSubj, rawTrainSubj)

mergedXTbl <- tbl_df(mergedX)

# 2. Extract only measurements of mean and standard deviation

reqdCols <- rawFeatures[c(grep("-mean\\(\\)|-std\\(\\)", rawFeatures[,2] )),]
meansAndStds <- mergedXTbl[, reqdCols[,1]]
colnames(meansAndStds) <- reqdCols[,2]

# 3. Add the volunteer and activity as the first two columns

singleSet <- cbind(mergedSubj, mergedY, meansAndStds)
colnames(singleSet)[1] <- "Volunteer"
colnames(singleSet)[2] <- "Activity"

# 4. Change the activity to a name
withNames <- mutate(singleSet, Activity = rawActLabels[Activity, 2] )

# 5. Create a tidy data set with average of each variantl for each activity and each subject
groupedByMeansAndStds <- group_by(withNames, Activity, Volunteer)
tidyDataSet <- summarize_each(groupedByMeansAndStds, funs(mean))

# 6. Write table 
write.table(tidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)
