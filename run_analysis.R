# Adam Hjerpe 2014-06-22
# Project Work Coursera Getting and cleaning data. 
# Transforming a data set into a tidy data set to facilitate eventual 
# further analysis.

# See the README.MD at the repository for details regarding this 
# script and the definition of a tidy data set, see CodeBook.md for 
# information about processed the data set. 

# The tasks of this script is structured with steps 0 to 6
# covered in README.MD.

# 0.
# Download and load data.
setwd("./programming/GetData/GetDataProjectWork/")
if (!file.exists("./Data1")){
    dir.create("./Data1")
    urlFile <- paste0("https://d396qusza40orc.cloudfront.net/", 
                      "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    download.file(url=urlFile, 
                  destfile="./Data1/SmartPhoneActivity.zip")
}

# Remember to unzip file, content of size around 269 mb.
list.files("./Data1/SmartPhoneActivity/UCI HAR Dataset/")

# File name to training/test set.
fileTest <- paste0("./Data1/SmartPhoneActivity/", 
                   "UCI HAR Dataset/test/X_test.txt")
fileTr <- paste0("./Data1/SmartPhoneActivity/", 
                 "UCI HAR Dataset/train/X_train.txt")

# File name for training/test set labels.
fileTestLabel <- paste0("./Data1/SmartPhoneActivity/", 
                        "UCI HAR Dataset/test/y_test.txt")
fileTrLabel <- paste0("./Data1/SmartPhoneActivity/", 
                      "UCI HAR Dataset/train/y_train.txt")

# File name to subjects performing activity in test/train data set.
fileTestSubject <- paste0("./Data1/SmartPhoneActivity/",
                          "UCI HAR Dataset/test/subject_test.txt")
fileTrSubject <- paste0("./Data1/SmartPhoneActivity/", 
                        "UCI HAR Dataset/train/subject_train.txt")

fileActivity <- paste0("./Data1/SmartPhoneActivity/", 
                       "UCI HAR Dataset/activity_labels.txt")

# File name to correspondin name of all feature labels.
fileFeatures <- paste0("./Data1/SmartPhoneActivity/", 
                       "UCI HAR Dataset/features.txt")

# Read data.

# Each row in trainTbl contains 561 variables of different features.
# (specified in features.txt)
testTbl <- read.csv(file = fileTest, sep = "", header = F)
trainTbl <- read.csv(file = fileTr, sep = "", header = F)

# Each row specifies specifies which activity are measured in
# trainTbl.
# (1,..,6) encodes as
#                   (WALKING ,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
#                   SITTING, STANDING, LAYING).
testLbl <- read.csv(file =fileTestLabel, sep = "", header = F)
trainLbl <- read.csv(file = fileTrLabel, sep = "", header = F)

# Each row spiecifies which subject(person) are being measured in 
# train/test table(Tbl). 
testSbj <- read.csv(file = fileTestSubject , sep = "", header = F)
trainSbj <- read.csv(file = fileTrSubject, sep = "", header = F)

# Tbl of names for all 561 features.
featureTbl <- read.csv(file = fileFeatures, sep = "", header = F, 
                       col.names=c("mapToNmb","featureName"))


# 1.
# Adjoin test and training data.
testTrTbl <- rbind(testTbl, trainTbl)
# Adjoin labels for training and test data in corresponding order.
testTrLbl <- rbind(testLbl, trainLbl)
# Adjoin subjects for training and test data in corresponding order.
testTrSbj <- rbind(testSbj, trainSbj)


# 2.
# Get indicating vector corresponding only to columns regarding 
# mean or standard deviation for each measurement.
indMuStd <- grep(pattern="(-mean|-std)", x=featureTbl$featureName)

# Extract subset of columns for testTr data set corresponding to 
# measures regarding mean and standard deviation.
testTrTbl <- testTrTbl[, indMuStd]

# Extract features and labels corresponding to above measures.
featureTbl <- featureTbl[indMuStd, ]

# 3.
# Rename variables to more informative names.
featureTbl$featureName <- sub(x = featureTbl$featureName, 
                              pattern = "\\(\\)", replacement = "")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "-", 
                               replacement = "")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "mean", 
                               replacement = "Mean")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "std", 
                               replacement = "Std")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "X$", 
                               replacement = "Xcord")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "Y$", 
                               replacement = "Ycord")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "Z$", 
                               replacement = "Zcord")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               
                               pattern = "^t", 
                               replacement = "time")
featureTbl$featureName <- gsub(x = featureTbl$featureName, 
                               pattern = "^f", 
                               replacement = "freq")

# Add informative names to the measured variables.
names(testTrTbl) <- featureTbl$featureName

# Cast all variable names to lowercase.
names(testTrTbl) <- tolower(names(testTrTbl))

# 4.
# Add the two variables activity(label) and subject corresponding
# to each row.
testTrTbl$activityid <- testTrLbl[, 1]
testTrTbl$subjectid <- testTrSbj[, 1]

# 5.
# Form new tidy data set with mean of each measured variable grouped 
# by activityid and subjectid.
testTrTblMean <- aggregate(. ~ activityid + subjectid, 
                           FUN=mean, data=testTrTbl)

#6.
# Order table by first variable activityid
testTrTblMean = testTrTblMean[order(testTrTblMean$activityid), ]

# Change variables to appropriate names for the above table.
colInd <- c(3:length(names(testTrTblMean)))
names(testTrTblMean)[colInd] <- paste0("average", 
                                       names(testTrTblMean)[colInd])

# Write tidy data set and variable names to file.
if (!file.exists("./meanTestTrain.txt")){
    write.table(x = testTrTblMean, file = "./meanTestTrain.txt", 
                col.names = names(testTrTblMean))
}
if (!file.exists("./variableNames.txt")){
    write.table(x = names(testTrTblMean), file = "./variableNames.txt", 
                row.names = c(1:length(names(testTrTblMean))))
}
