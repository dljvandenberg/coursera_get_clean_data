# Coursera course Getting and Cleaning Data - Course project

The ```run_analysis.R``` script processes files from the UCI HAR Dataset to generate a tidy dataset with columns ```subject```, ```activity_name``` and 66 measured variables averaged over the ```subject``` and ```activity_name``` groups.

Input data is processed in the following steps:

* Read training and test datasets with measurements from ```train/X_train.txt``` and ```test/X_test.txt```

* Add column names retrieved from ```features.txt```

* Add ```activity_name``` column by reading activity labels from ```train/y_train.txt``` and ```test/y_test.txt``` and converting labels to names using mapping defined in ```activity_labels.txt```

* Add ```subject``` column from ```train/subject_train.txt``` and ```test/subject_test.txt```

* Merge training and test datasets vertically

* Select relevant variables, i.e. columns ```subject```, ```activity_name``` and variable names containing ```mean()``` or ```std()```

* Calculate averages of each variable for each ```subject``` and for each ```activity_name```

* Sort by ```subject``` and ```activity_name```

Output is written to file ```averages.txt```