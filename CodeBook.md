##Project Work <br/> Getting and cleaning data <br/>
### CodeBook
This is a text describing the data set regarding wearable computing, see this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) into a tidy data set. The data set consists of measurments by accelerometers from Samsung Galaxy S smartphones. The data set and a full description can be found here
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

The text also describes a tidy data set which is outputted by the script **run_analysis.R** runned on this data set.

### The project data
The above data for the project can be downloaded at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. For the project we are interested in all data measuring mean or standard deviation of the different features.
The data of interest consists of a group of 30 volunteers (subjects) who performs one of the different activities(labels)

1. Walking
2. Walking upstairs
3. Walking downstairs
4. Sitting
5. Standing
6. Laying

where different measures was performed with the smartphones embedded accelerometer and gyroscope, further the data was split into two groups where 70% of the volunteers was selected to generate training data and 30% to generate test data. For more details see the **README.txt** file at **Data1/SmartPhoneActivity/UCI HAR Dataset/README.txt** in this repository(or see url to full description at top). 
The data of interest at the above url consists of the following files,

**test/X_train.txt** data of size 7352 rows and 561 columns where each column corresponds to a feature specified at **features.txt** and each row corresponds to one volunteer(subject) performing one of the above activities(label) specified at **train/subject_train.txt** and **test/y_test.txt** respectively. Further the file **activity_labels.txt** is linking the labels at **test/y_test.txt** with the corresponding above activity(same encoding as in the above table). The descriptions for the **train.txt** files are equivalent.
Information of the 561 different features is found at **Data1/SmartPhoneActivity/UCI HAR Dataset/features.txt**.

### The tidy data output
The tidy data set **meanTestTrain.csv** consists of the 81 variables found at **variableNames.txt**. The variables are formed by taking the mean of each variable grouped by volunteer(subject) and activity(label) where the values of the first and second variables are

- activityid ranges from 1 to 6 corresponding to the activity in the above table.
- subjectid ranges from 1 to 30 corresponding to one of the  30 volunteers.

The rest of the variables are in the manner 
averagetimegravityaccmeanxcord meaning the average of the variable timegravityaccmeanxcord(see **Data1/SmartPhoneActivity/UCI HAR Dataset/features.txt**) from this repository <https://github.com/hjerpe/GetDataProjectWork>.