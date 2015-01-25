
# getdata_010
### _CodeBook_

> Tidy data set based on "Human Activity Recognition Using Smartphones Dataset
Version 1.0" located [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The above data was processed as follows:

- Source zip file is loaded and unziped into the ./data director (if it doesn't
exist);
- Test and training data from `./data/UCI HAR Dataset/` are combined and
feature names assigned;
- Activity names are `merge`d into combined data
- Variables for standard deviation (sd) and average (mean) are selected;
- The average (`mean`) is `agregate`d for these selected variables by subject 
and activity type;
- the following files are generated:

| File | Description|
|---|---|
|./tidydata.txt  | the processed tidy data to be used in subsequent projects
|./tidyFeatures.txt | feature names from the original `./data/UCI HAR Dataset/feature.txt file`
