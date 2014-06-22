---
title: "Project Work <br/> Getting and cleaning data <br/>"
output: html_document
---
## Transforming data into a tidy data set
This is a text explaining how the script run_analysis.R transforms a data set regarding wearable computing, see this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) into a tidy data set. The data set consists of measurments by accelerometers from Samsung Galaxy S smartphones. The data set and a full description can be found here
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

### Tidy data set
The general properties regarding a tidy data set are outlaid in the paper [Tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) by [Hadley Wickham](http://had.co.nz/). Our project work to transformed the above data is done according to the four principles outlied by one of the course instructors git hub repository [Jeff Leek](https://github.com/jtleek/datasharing/blob/master/README.md). Namely,

1. Each variable measured forms a column.
2. Each different observation forms a row.
3. There is only one table for each kind of variable.
4. If there is multiple tables, they should include a column that allows them to be linked.

### The project script
The specification of the script **run_analysis.R** is

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The tasks of the script are outlied outlied as steps 0 to 6 commented in the code. See **CodeBook.md** for information about the processed data set.

0. Read and download the data.
1. Adjoin the test and training data to one table, after which each column corresponds to a feature and each row corresponds to a subject and activity in the adjoined table.
 Adjoin the corresponding labels and subjects for the test and training data.
2. Fetch subset corresponding to only measures regarding the mean and standard deviations for the features.
3. Rename the variables to more informative names. Where the abbreviations f,t,X,Y,Z are written out to frequency, time, x,y,z -cord(coordinate) and unnecessary characters are removed.
4. Add the two variables subject(voleenter) and activity(label) whoose information is found at the adjoined labels and subjects table in step 1.
5. Form a new tidy data set by taking the mean of each measured variable grouped by activity(label) and volunteer(subject).
6. Order this new tidy data set according to the first variable activity and rename the variables to more informative names by concatenating mean infront of each variable name.

The data set formed from steps 5-6 is tidy since each variable forms a separate column and each observation forms a row.
Lastly the above tidy data set and variable names are saved with names **meanTestTrain.csv** and **variableNames.txt** and uploaded to this repository.