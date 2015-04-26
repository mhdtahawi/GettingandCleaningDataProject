# step one 
# Merges the training and the test sets to create one data set.

require(dplyr)
testData  <- read.table("UCI HAR Dataset/test/X_test.txt") # Read the test dataset
testData[,"Subject"]  <-  read.table("UCI HAR Dataset/test/subject_test.txt") # subjects

trainData  <- read.table("UCI HAR Dataset/train/X_train.txt") # Read the training
trainData[,"Subject"]  <- read.table("UCI HAR Dataset/train/subject_train.txt") #subjects

completeData  <- rbind(testData, trainData) # Merge previous datasets togther

#Get the features we want
names  <- read.table("UCI HAR Dataset/features.txt")
names[,2] = gsub('-mean', 'Mean', names[,2])
names[,2] = gsub('-std', 'Std', names[,2])
names[,2] = gsub('[-()]', '', names[,2])

# step tow
# Extracts only the measurements on the mean and standard deviation for each measurement.

desiredCols  <- grep(".*Mean.*|.*Std.*", names[,2])
names  <- names[desiredCols , ] # reduce the feature names to the desired features only
desiredCols   <- c(desiredCols  , 562) #adding the subject column
subsetData  <- completeData[ , desiredCols]
colnames(subsetData)  <- c( names[,2] , "Subject") 


#step three
#Uses descriptive activity names to name the activities in the data set
testLabels   <- (read.table("UCI HAR Dataset/test/y_test.txt")[, 1])
trainLabels  <- (read.table("UCI HAR Dataset/train/y_train.txt")[, 1])
Activity  <- append (testLabels, trainLabels)

# updating labels to descriptive activites instead of numbers
Activity [ Activity == 1]  <- "WALKING"
Activity [ Activity == 2]  <- "WALKING_UPSTAIRS"
Activity [ Activity == 3]  <- "WALKING_DOWN"
Activity [ Activity == 4]  <- "SITTING"
Activity [ Activity == 5]  <- "STANDING"
Activity [ Activity == 6]  <- "LAYING"

subsetData  <- cbind(subsetData , Activity)

#step four
#Appropriately labels the data set with descriptive variable names. 

names(subsetData) <- gsub('Acc',"Acceleration",names(subsetData))
names(subsetData) <- gsub('GyroJerk',"AngularAcceleration",names(subsetData))
names(subsetData) <- gsub('Gyro',"AngularSpeed",names(subsetData))
names(subsetData) <- gsub('Mag',"Magnitude",names(subsetData))
names(subsetData) <- gsub('^t',"TimeDomain.",names(subsetData))
names(subsetData) <- gsub('^f',"FrequencyDomain.",names(subsetData))
names(subsetData) <- gsub('\\.mean',".Mean",names(subsetData))
names(subsetData) <- gsub('\\.std',".StandardDeviation",names(subsetData))
names(subsetData) <- gsub('Freq\\.',"Frequency.",names(subsetData))
names(subsetData) <- gsub('Freq$',"Frequency",names(subsetData))


# step 5 
#the new  tidy dataset with averages
tidy = ddply(subsetData, c("Subject","Activity"), numcolwise(mean))
write.table(tidy, "tidy.txt", sep="\t" , row.names = F)
