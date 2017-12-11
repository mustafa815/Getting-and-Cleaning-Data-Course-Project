# Getting-and-Cleaning-Data-Course-Project

# The script takes the following steps
1- It reads all the tables related to the data, features, activity types, subject ids, and the actual data. 
The idea here is that we need to structure the data from different components (column names in one place, and ids in another place)

2- It enhances the naming of the elements of the data, from y to subject_id, and so on.
3- It creates the training and testing data with the column names that we created above
4- It merges the two data sets (rbind) to create the full data set

5- It simply uses the grepl function to extract only the two values we are interested in, mean and std
6- It merges between the proper list of activity names and the resulting data, by the id
7- It enhances the names of some columns, using full words instead of one letter for example. For this gsub was heavily used
8- Finally we utilzed ddply to create the tidy data with only the mean values
9- The script creates the tidy data file as txt file.
