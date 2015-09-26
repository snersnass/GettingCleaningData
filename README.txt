## Run Analysis notes

# rawFeatures is the 561 column headings for test and train X data files

# There were 30 volunteers identified by numbers 1 to 30

# rawTestSubj and rawTrainSubj identify which volunteer number was for each row in test and train data files

# rawTestY and rawTrainY identify what the volunteer was doing for each row in test and train data files

# There were 6 activities link the number used in the TestY files, to a proper description of the activity
#	These activities are in RawActLabels

# marker please note I changed the order of requirements so I could understand it better
#    if you want to test on a mac, please change which pathPrefix is commented out and should work

## 1. Merge the data sets

# Test X + Train X gives 10299 rows x 561 colums
# Test Y + Train Y gives 10299 activity rows
# Test Subject + Train Subject gives 10299 subject rows

# 2. Extract only measurements of mean and standard deviation
#    Use grep to get just the matching rows
# 		Column 1 of the result is the vector of selected rows
#		Column 2 of the result is the vector of required names
#	 Apply the names

# 3. Add the volunteer and activity as the first two columns

#		These come into the first two columns and both are numbers at this stage

# 4. Change the activity to a name

#		Use RawActLabels to find the activity name that relates to the description
#		Use mutate to swap out this column to labels instead of numbers

# 5. Create a tidy data set with average of each variantl for each activity and each subject

