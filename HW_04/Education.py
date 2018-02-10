
# coding: utf-8

# In[12]:


import os
import pandas as pd
import numpy as np


# In[13]:


SchoolFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','schools_complete.csv')


# In[36]:


StudentFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','students_complete.csv')


# In[37]:


student_df = pd.read_csv(StudentFile)
school_df = pd.read_csv(SchoolFile)


# In[46]:


school_df.rename(columns={'name': 'school_name'}, inplace=True)


# In[48]:


student_df.rename(columns={'school': 'school_name'}, inplace=True)

