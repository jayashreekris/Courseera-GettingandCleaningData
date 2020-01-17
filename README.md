**README.COM**

**Jayashree Krishnamoorthy – 20 January 2020**

**Getting and Cleaning Data Assignment**

**John Hopkins University**

All associated files can be found in the following GitHub repository:

**https://github.com/jayashreekris/Courseera-GettingandCleaningData**

One of the most exciting areas in all of data science right now is wearable
computing - see for example [this
article ](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most
advanced algorithms to attract new users.

This project takes existing data collected from the accelerometers from the
Samsung Galaxy S smartphone and further analysis the data set to produce a
summary output data set which shows the average value for each of 66 measurement
variables for a set of 30 subjects each doing 6 types of activity. The associate
codebook (codebook.nd) provides detailed information on the measurement
variables and activity types.

The R script (run_analysis.R ) produces the output data set by means of the
following processing steps (see detailed description below and run_analysis.R
for further information):

1.  Constructs an initial raw data set containing all ‘test’ and ‘train’ sample
    data from the existing raw data sets.

2.  Extracts only the measurements on the mean and standard deviation for each
    measurement (and measurement Subject and Activity identifiers) from data
    fram ‘all_data’ (created in 1) into a new data frame ‘extract_data’.

3.  Activity Labels in the ‘extract_data’ data frame are then replaced with
    tidy, descriptive variable name values.

4.  Measurement variables in the ‘data_extract’ data frame are changed to ensure
    that they tidy, descriptive variable names (i.e. readable and composed of
    purely alpha-numeric characters). See Codebook.md for detailed description
    of token-based naming convention applied and full list of variable names.

5.  A second, independent tidy data set with the average of each variable for
    each activity and each subject is created by use of functions from ‘dplyr’
    library applied to the data frame ‘data_extract’. The final output is saved
    as both a txt file (Assignment_Output.txt) and csv file
    (Assignment_Output.txt)

Input data for this analysis is taken from:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

which itself is sourced from:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Raw Data Files Used:

| **Filename**        | **Data**                                                                |
|---------------------|-------------------------------------------------------------------------|
| features.txt        | Variable Names for measures for each record                             |
| Activity_labels.txt | Mapping of code used for each activity to activity description          |
| subject_train.txt   | Subject ID for each record for subjects allocated to the ‘train’ set    |
| subject_test.txt    | Subject ID for each record for subjects allocated to the ‘test’ set     |
| y_train.txt         | Activity code for each record for subjects allocated to the ‘train’ set |
| y_test.txt          | Activity code for each record for subjects allocated to the ‘test’ set  |
| x_train.txt         | Measured data for each record for subjects allocated to the ‘train’ set |
| y_train.txt         | Measured data for each record for subjects allocated to the ‘train’ set |

Output Files Produced by This Work:

| **Filename**          | **Contents**                                                                                                                  |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------|
| README.md             | This readme file                                                                                                              |
| Codebook.md           | Associated Codebook which details the variables, the data used and the data processing applied to input data by this analysis |
| run_analysis.R        | The R script which runs this analysis (assuming input files are in the R working dir)                                         |
| Assignment_Output.txt | Final ouput dataset from this analysis in txt format with no row names                                                        |
| Assignment_Ouput.csv  | Final output dataset from this analysis in csv format                                                                         |
| Data_Extract.csv      | Intermediate tidy data extract of mean and std measurements from input data in csv format                                     |

*Detailed Processing Steps Conducted by R script file ‘run_analysis.R’:*

1.  Constructs an initial raw data set containing all ‘test’ and ‘train’ sample
    data

    1.  Creates variable ‘var_names’ to be used as column headings for
        consolidated raw data set

        1.  Reads ‘features.txt’ for measurement variable names

        2.  Concatenates measurement variable names with ID column titles
            ‘Subject’ and ‘Activity’

    2.  Creates data frame ‘test_data’ containing the raw data from the ‘test’
        subset of subjects

        1.  Reads in and then column binds raw data files ‘subject_test.txt’ ,
            ‘x_test.txt’ and ‘y_test.txt’

        2.  Names data frame columns using var_names (created in 1.1)

    3.  Creates data frame ‘train_data’ containing the raw data from the ‘test’
        subset of subjects

        1.  Reads in and then column binds raw data files ‘subject_train.txt’ ,
            ‘x_train.txt’ and ‘y_train.txt’

        2.  Names data frame columns using var_names (created in 1.1)

    4.  Creates consolidated data frame ‘all_data’

        1.  Row binding the ‘test_data’ data frame and ‘train_data’ data frame

        2.  Converts ‘Activity’ variable to factor with 6 levels to enable later
            analysis

2.  Extracts only the measurements on the mean and standard deviation for each
    measurement (and measurement Subject and Activity identifiers) from data
    fram ‘all_data’ (created in 1) into a new data frame ‘extract_data’

3.  Activity Labels in the ‘extract_data’ data frame are then replaced with
    tidy, descriptive variable name values (e.g. Walking, WalkingUpstairs,
    WalkingDownstairs, Standing, Laying)

    1.  Reads ‘activity_labels.txt’ file into ‘activity_labels’ data frame

    2.  Renames variables in ‘activity_labels’ to a tidy token-based format with
        each token element starting with a capital letter and all
        non-alphanumeric characters removed

    3.  In the ‘data_extract’ dataframe (created in 2) the ‘Activity’ variable
        factor level is replaced with the relevant descriptive variable name
        using the updated ‘activity_labels’ data frame (created in 3.2)

4.  Measurement variables in the ‘data_extract’ data frame are changed to ensure
    that they tidy, descriptive variable names (i.e. readable and composed of
    purely alpha-numeric characters). See Codebook.md for detailed description
    of token-based naming convention applied and full list of variable names.

    1.  Variable names in data_extract data frame (created in 3.3) are renamed
        to match tidy, descriptive naming convention

    2.  The resulting data frame data_extract is written as a csv format output
        file to ‘data_extract.csv’

5.  A second, independent tidy data set with the average of each variable for
    each activity and each subject is created by use of functions from ‘dplyr’
    library applied to the data frame ‘data_extract’ (created in 4.1)

    1.  Data frame ‘data_extract’ is grouped by the ‘Subject’ ID variable and
        then by the ‘Activity’ ID variable using the group_by function

    2.  The mean for each element of the grouped data table created in 5.1 is
        then averaged using the summarise_all function with a funs(mean)
        argument to produce an ‘output’ grouped data frame (consisting of 180
        observations each with 2 ID variables and 66 measurement variables)

    3.  The ‘output’ data frame is written to final ouput files in two formats

        1.  CSV format to ‘Assignment_Output.csv’

        2.  TXT format to ‘Assignment_Output.txt’ (with no row numbering)
