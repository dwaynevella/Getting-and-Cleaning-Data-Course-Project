# Getting-and-Cleaning-Data-Course-Project

The file run_analysis.R contains the code used the extract, tidy and summarise the data.

The file CombinedFiltered.txt contains the first, tidy data set extracting the mean and standard deviation for each measurement.

The file SummarisedDataset.txt contains the second, independent tidy data set with the average of each variable for each activity and each subject.

The analysis file starts by first reading the train and testing dataset. It then labels the read datasets. It then merges the two datasets to create one called combinedData.

The columns representing the mean and std are then extracting using the grepl command on the column names of the combinedData dataset. 

The dplyr group by is used to group by subject and activity to work out the mean and sd of each measurement of every activity to create the summarised dataset.
