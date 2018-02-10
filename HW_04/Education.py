#Modules
import os
import pandas as pd
import numpy as np

#Import csv with school data
SchoolFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','schools_complete.csv')

#Import csv with student data
StudentFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','students_complete.csv')

#Convert school csv to dataframe
school_df = pd.read_csv(SchoolFile)

#Convert student csv to dataframe
student_df = pd.read_csv(StudentFile)

#Rename 'School ID' and 'name' columns in school dataframe
school_df.rename(columns={'name': 'school_name', 'School ID' : 'school_id'}, inplace=True)

#Rename 'Stucdent ID' and 'school' columns in student dataframe
student_df.rename(columns={'school': 'school_name', 'Student ID' : 'student_id', 'name' : 'student_name'}, inplace=True)

#Merge the two dataframes based on school name to create ed dataframe
ed_df = pd.merge(school_df, student_df, on='school_name')

#Pivot table
pd.pivot_table(school_df,index=["school_name"])

#Export to csv
ed.df.to_csv('ed.csv')
