
library(downloader)     # unzip
library(dplyr)          # merge, aggregate, select

# first run - create data directory, download and unzip data
if(!file.exists("./data")){dir.create("./data")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
        fileName <- "./data/Dataset.zip"
        download.file(fileUrl, destfile = fileName, mode = "wb")
        unzip(fileName, exdir = "./data")
}

# load comment features (activities and column lables)
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                         col.names = c("activity.id","activity.name"))

labels <- read.table("./data/UCI HAR Dataset/features.txt")

# combine subject, activity and data set for both test and train directories
X <- rbind(
        cbind(
                read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                           col.names = c("subject.id")),
                read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                        col.names = c("activity.id")),
                read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                        col.names = as.character(labels$V2))
        ),
        cbind(
                read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                           col.names = c("subject.id")),
                read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                        col.names = c("activity.id")),
                read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                        col.names = as.character(labels$V2))
        )
      )

# merge in activity names
X <- merge(activities, X, by = "activity.id")

# select std and mean columns
X <- X %>% select(subject.id, activity.name, 
                  grep("\\.(std|mean)\\.", names(X))
                  )

# summarise by mean across subject.id and activity.name
finalSet <- aggregate(. ~ subject.id + activity.name, data = X, FUN = mean)

# Save dataset
write.table(finalSet, file = "./tidydata.txt", row.name = FALSE)

# since original feature names have 'invalid' characters for column names
# create and save feature names from original features.txt file for reference
df <- as.data.frame(c('subject.id', 'action.name',
                      as.character(
                              labels[grep("-(std|mean)\\(\\)", 
                                          as.character(labels$V2) ),2])
                      ))
write.table(df, "./tidyFeatures.txt", col.names = FALSE, quote = FALSE)

