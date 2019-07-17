##Read the Data from the data repository.

library(httr)
library(dplyr)

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url,"C:/Users/BhavaniC/Downloads/get_data.zip",method = "curl")
unzip("C:/Users/BhavaniC/Downloads/get_data.zip") 
  

##Extract only mean and std of the features;

features <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/features.txt")
wanted <- grep("mean\\()|std\\()",features$V2)
features.names <- features[wanted,2]
features.names <- gsub("[()]","",features.names)
features.names <- tolower(features.names)

## Read data sets and merge test and train data sets.

x_test <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/test/X_test.txt")[features.names]
y_test <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/test/y_test.txt")
s_test <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/test/subject_test.txt")

test <- cbind(s_test,y_test,x_test)

x_train <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/train/X_train.txt")[features.names]
y_train <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/train/y_train.txt")
s_train <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/train/subject_train.txt")

train <- cbind(s_train,y_train,x_train)




all_dat <- rbind(train,test)

##Assign column names 

colnames(all_dat) <- c("subject","activity",features.names)

##Read Activity Label Data

act_labels <- read.table("C:/Users/BhavaniC/Downloads/get_data/UCI HAR Dataset/activity_labels.txt")

##Create factors from the activity and subject columns.

all_dat$activity <- factor(all_dat$activity,levels = act_labels$V1,labels = act_labels$V2)

all_dat$subject <- as.factor(all_dat$subject)


##Create Tidy data set with averages by activity and subject 

melted <- melt(all_dat, id = c("subject", "activity"))
tidy <- melted %>% group_by(subject,activity,variable) %>% summarise(mean = mean(value))

##Write the data set to tidy.txt

write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)