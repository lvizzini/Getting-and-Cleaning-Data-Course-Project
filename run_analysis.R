#i. Download the dataset from web and read: train, test, subject and activity datasets.
#destination dir
Dir <- "C:/Users/lvizzini/Desktop/Coursera"

#download data in a .zip file named: data
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = paste(Dir, "/", "Data.zip", sep = ""))

#unzip file Data.zip in a folder named: UCI HAR Dataset
unzip(zipfile = paste(Dir, "/", "Data.zip", sep = ""), exdir =Dir)

#read training data
x_tr <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/train/X_train.txt"))
y_tr <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/train/Y_train.txt"))
s_tr <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/train/subject_train.txt"))

#read test data
x_ts <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/test/X_test.txt"))
y_ts <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/test/Y_test.txt"))
s_ts <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/test/subject_test.txt"))

#read feature
f <- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/features.txt"),as.is=TRUE)

#read activity labels as character
l<- read.table(paste(sep = "", Dir, "/UCI HAR Dataset/activity_labels.txt"),as.is=TRUE)

#ii. Select rows from feature dataset wihtin '-mean' and '-std' string and rename column names into 'mean' and 'std'.
# select rows of feature containing mean or std
c<- grep("-(mean|std).*", f[,2])

#select col names from feature
cnames<- f[c, 2]

#substitute -mean with Mean in col names
cnames <- gsub("-mean", "mean", cnames)
cnames <- gsub("-std", "std", cnames)
cnames <- gsub("[-()]", "", cnames)
cnames<-tolower(cnames)

#iii. Bind by rows training, test and subject data frame
d_x <- rbind(x_tr, x_ts)
d_y <- rbind(y_tr, y_ts)
d_s <- rbind(s_tr, s_ts)

#iv. Extract data by selected columns from step ii
d_x <-d_x[c]

#v. Create a data frame named data with subject, y and x mesures
data <- cbind(d_s, d_y, d_x)
 
#define col names of data
colnames(data) <- c("subject", "activity", cnames)

#transforming as a factor subject and activity col
data$activity <- factor(data$activity, levels =l[,1], labels = l[,2])
data$subject <- as.factor(data$subject)

#vi. Create tidy data frame and write a txt file
library(reshape2)
m_data <- melt(data, id = c("subject", "activity"))
tidy <- dcast(m_data, subject + activity ~ variable, mean)

#write in a txt tidy data frame
write.table(tidy, "C:/Users/lvizzini/Desktop/Coursera/tidy.txt", row.names = FALSE, quote = FALSE)

