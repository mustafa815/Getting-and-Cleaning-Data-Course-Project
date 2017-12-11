run_analysis <- function(){
  
  # Column names (read the table and store only the second column)
  vars <- read.table("./UCI HAR Dataset/features.txt")[,2]
  
  # Store the activity labels
  als <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  # Store the subject test & train (ids)
  s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  # Store the activities for test and train (act_Id)
  a_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  a_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  
  # Store the actual data
  test_data_raw <- read.table("./UCI HAR Dataset/test/X_test.txt")
  train_data_raw <- read.table("./UCI HAR Dataset/train/X_train.txt")
  
  # Enhance the naming
  colnames(s_test) <- "subject_id"
  colnames(s_train) <- "subject_id"
  colnames(a_test) <- "activity_id"
  colnames(a_train) <- "activity_id"
  colnames(als) <- c("activity_id", "activity_type")
  colnames(test_data_raw) <- vars
  colnames(train_data_raw) <- vars
  
  # 1- Merges the training and the test sets to create one data set
  test_data <- cbind(a_test, s_test, test_data_raw)
  train_data <- cbind(a_train, s_train, train_data_raw)
  all_data <- rbind(train_data, test_data)
  
  # 2- Extracts only the measurements on the mean and standard deviation for each measurement
  # Will use grepl to only choose the mean, std, along with the ids
  col_names <- colnames(all_data)
  m_and_s <- all_data[,grepl("mean|std|subject_id|activity_id", col_names)]
  
  # 3- Uses descriptive activity names to name the activities in the data set
  # Will merege the extracted data set with the proper names of the activities 
  m_and_s <- merge(m_and_s, als, by = "activity_id")
  
  # 4- Appropriately labels the data set with descriptive variable names
  # Will remove all t, f, and acc, etc with the full words
  names(m_and_s) <- gsub("Acc", "Acceleration", names(m_and_s))
  names(m_and_s) <- gsub("^t", "Time", names(m_and_s))
  names(m_and_s)<-  gsub("BodyBody", "Body", names(m_and_s))
  names(m_and_s) <- gsub("^f", "Frequency", names(m_and_s))
  names(m_and_s)<-  gsub("Gyro", "Gyroscope", names(m_and_s))
  names(m_and_s)<-  gsub("Mag", "Magnitude", names(m_and_s))
  
  # 5- From the data set in step 4, creates a second, independent tidy data set 
  # with the average of each variable for each activity and each subject.
  
  
  # Will utilze ddply, and numcolwise to operate on a column rather than a vector
  tidy_data <- ddply(m_and_s, .(subject_id, activity_id), numcolwise(mean)) 
  write.table(tidy_data, file="tidy_data.txt")
  
  
}
