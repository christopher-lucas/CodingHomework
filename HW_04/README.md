
# District and Campus Performance Research


```python
import os
import pandas as pd
import numpy as np
```

# District Performance


```python
SchoolFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','schools_complete.csv')
StudentFile = os.path.join('04 Pandas', 'PyCitySchools', 'raw_data','students_complete.csv')
school_df = pd.read_csv(SchoolFile)
student_df = pd.read_csv(StudentFile)
school_df.rename(columns={'name': 'campus', 'School ID' : 'school_id'}, inplace=True)
student_df.rename(columns={'school': 'campus', 'Student ID' : 'student_id', 'name' : 'student_name'}, inplace=True)
ed_df = pd.merge(school_df, student_df, on='campus')
grouped_campus = ed_df.groupby('campus')
campus_count = len(grouped_campus)
total_students = ed_df[('student_id')].count()
total_budget = school_df[('budget')].sum()
average_math_score = round(ed_df[('math_score')].mean())
average_reading_score = round(ed_df[('reading_score')].mean())
count_passing_math_df = pd.DataFrame(ed_df.loc[(ed_df['math_score'] > 70)])
percent_passing_math_prep = round(count_passing_math_df['math_score'].count()/ed_df['student_id'].count(),2)
percent_passing_math = (percent_passing_math_prep)
count_passing_reading_df = pd.DataFrame(ed_df.loc[(ed_df['reading_score'] > 70)])
percent_passing_reading_prep = round(count_passing_reading_df['reading_score'].count()/ed_df['student_id'].count(),2)
percent_passing_reading = (percent_passing_reading_prep)
overall_passing_rate_prep = (percent_passing_math + percent_passing_reading)
overall_passing_rate = overall_passing_rate_prep / 2
district_summary_df = pd.DataFrame({"Total Students":[total_students],
                          "Total Schools":[campus_count],
                          "Total Budget":[total_budget],
                          "Average Math Score":[average_math_score],
                          "Average Reading Score":[average_reading_score],
                          "Percent Passing Math":[percent_passing_math],
                          "Percent Passing Reading":[percent_passing_reading], 
                          "Overall Passing Rate":[overall_passing_rate]})

district_summary_df = district_summary_df [["Total Schools", "Total Students", "Total Budget",
                                         "Average Math Score", "Average Reading Score", 
                                         "Percent Passing Math", "Percent Passing Reading", 
                                         "Overall Passing Rate"]]

district_summary_df["Total Budget"] = district_summary_df["Total Budget"].map("$ {:,.2f}".format)
district_summary_df["Total Students"] = district_summary_df["Total Students"].map("{:,}".format)
district_summary_df["Percent Passing Math"] = district_summary_df["Percent Passing Math"].map("{:.2%}".format)
district_summary_df["Percent Passing Reading"] = district_summary_df["Percent Passing Reading"].map("{:.2%}".format)
district_summary_df["Overall Passing Rate"] = district_summary_df["Overall Passing Rate"].map("{:.2%}".format)

district_summary_df
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Schools</th>
      <th>Total Students</th>
      <th>Total Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>15</td>
      <td>39,170</td>
      <td>$ 24,649,428.00</td>
      <td>79</td>
      <td>82</td>
      <td>72.00%</td>
      <td>83.00%</td>
      <td>77.50%</td>
    </tr>
  </tbody>
</table>
</div>



# Summary by Campus


```python
school_types = school_df.set_index(["campus"])["type"]
student_count = ed_df["campus"].value_counts()
campus_budget = ed_df.groupby(["campus"]).mean()["budget"]
budget_per_student = school_budget / student_count
grouped_campus = ed_df.groupby('campus')
campus_math_average = grouped_campus[('math_score')].mean()
campus_reading_average = grouped_campus[('reading_score')].mean()
percent_passing_math_prep = ed_df[(ed_df["math_score"] > 70)]
percent_passing_math = percent_passing_math_prep.groupby(["campus"]).count()["student_name"] / student_count 
percent_passing_reading_prep = ed_df[(ed_df["reading_score"] > 70)]
percent_passing_reading = percent_passing_reading_prep.groupby(["campus"]).count()["student_name"] / student_count 
overall_passing_rate_prep = (percent_passing_math + percent_passing_reading)
overall_passing_rate = overall_passing_rate_prep / 2

campus_summary = pd.DataFrame({"School Type": school_types,
                               "Total Students": student_count,
                               "Total School Budget": campus_budget,
                               "Budget Per Student": budget_per_student,
                               "Per Student Budget": per_school_capita,
                               "Average Math Score": campus_math_average,
                               "Average Reading Score": campus_reading_average,
                               "Percent Passing Math": percent_passing_math,
                               "Percent Passing Reading": percent_passing_reading,
                               "Overall Passing Rate": overall_passing_rate})


campus_summary = campus_summary[["School Type", "Total Students", "Total School Budget", "Budget Per Student",
                                         "Average Math Score", "Average Reading Score", "Percent Passing Math",
                                 "Percent Passing Reading", "Overall Passing Rate"]]
                              
    
campus_summary["Total School Budget"] = campus_summary["Total Students"].map("${:,.2f}".format)
campus_summary["Budget Per Student"] = campus_summary["Budget Per Student"].map("${:,.2f}".format)
campus_summary["Percent Passing Math"] = campus_summary["Percent Passing Math"].map("{:.2%}".format)
campus_summary["Percent Passing Reading"] = campus_summary["Percent Passing Reading"].map("{:.2%}".format)
campus_summary["Overall Passing Rate"] = campus_summary["Overall Passing Rate"].map("{:.2%}".format)
campus_summary["Total Students"] = campus_summary["Total Students"].map("{:,}".format)


campus_summary
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Budget Per Student</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>District</td>
      <td>4,976</td>
      <td>$4,976.00</td>
      <td>$628.00</td>
      <td>77.048432</td>
      <td>81.033963</td>
      <td>64.63%</td>
      <td>79.30%</td>
      <td>71.97%</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>Charter</td>
      <td>1,858</td>
      <td>$1,858.00</td>
      <td>$582.00</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>89.56%</td>
      <td>93.86%</td>
      <td>91.71%</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>District</td>
      <td>2,949</td>
      <td>$2,949.00</td>
      <td>$639.00</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>63.75%</td>
      <td>78.43%</td>
      <td>71.09%</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>District</td>
      <td>2,739</td>
      <td>$2,739.00</td>
      <td>$644.00</td>
      <td>77.102592</td>
      <td>80.746258</td>
      <td>65.75%</td>
      <td>77.51%</td>
      <td>71.63%</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>Charter</td>
      <td>1,468</td>
      <td>$1,468.00</td>
      <td>$625.00</td>
      <td>83.351499</td>
      <td>83.816757</td>
      <td>89.71%</td>
      <td>93.39%</td>
      <td>91.55%</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>District</td>
      <td>4,635</td>
      <td>$4,635.00</td>
      <td>$652.00</td>
      <td>77.289752</td>
      <td>80.934412</td>
      <td>64.75%</td>
      <td>78.19%</td>
      <td>71.47%</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>Charter</td>
      <td>427</td>
      <td>$427.00</td>
      <td>$581.00</td>
      <td>83.803279</td>
      <td>83.814988</td>
      <td>90.63%</td>
      <td>92.74%</td>
      <td>91.69%</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>District</td>
      <td>2,917</td>
      <td>$2,917.00</td>
      <td>$655.00</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>63.32%</td>
      <td>78.81%</td>
      <td>71.07%</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>District</td>
      <td>4,761</td>
      <td>$4,761.00</td>
      <td>$650.00</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>63.85%</td>
      <td>78.28%</td>
      <td>71.07%</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>Charter</td>
      <td>962</td>
      <td>$962.00</td>
      <td>$609.00</td>
      <td>83.839917</td>
      <td>84.044699</td>
      <td>91.68%</td>
      <td>92.20%</td>
      <td>91.94%</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>District</td>
      <td>3,999</td>
      <td>$3,999.00</td>
      <td>$637.00</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>64.07%</td>
      <td>77.74%</td>
      <td>70.91%</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>Charter</td>
      <td>1,761</td>
      <td>$1,761.00</td>
      <td>$600.00</td>
      <td>83.359455</td>
      <td>83.725724</td>
      <td>89.89%</td>
      <td>92.62%</td>
      <td>91.25%</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>Charter</td>
      <td>1,635</td>
      <td>$1,635.00</td>
      <td>$638.00</td>
      <td>83.418349</td>
      <td>83.848930</td>
      <td>90.21%</td>
      <td>92.91%</td>
      <td>91.56%</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>Charter</td>
      <td>2,283</td>
      <td>$2,283.00</td>
      <td>$578.00</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>90.93%</td>
      <td>93.25%</td>
      <td>92.09%</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>Charter</td>
      <td>1,800</td>
      <td>$1,800.00</td>
      <td>$583.00</td>
      <td>83.682222</td>
      <td>83.955000</td>
      <td>90.28%</td>
      <td>93.44%</td>
      <td>91.86%</td>
    </tr>
  </tbody>
</table>
</div>



# Rock Star Campuses


```python
rock_star_campuses = campus_summary.sort_values(["Overall Passing Rate"], ascending=False)
rock_star_campuses.head(5)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Budget Per Student</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Wilson High School</th>
      <td>Charter</td>
      <td>2,283</td>
      <td>$2,283.00</td>
      <td>$578.00</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>90.93%</td>
      <td>93.25%</td>
      <td>92.09%</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>Charter</td>
      <td>962</td>
      <td>$962.00</td>
      <td>$609.00</td>
      <td>83.839917</td>
      <td>84.044699</td>
      <td>91.68%</td>
      <td>92.20%</td>
      <td>91.94%</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>Charter</td>
      <td>1,800</td>
      <td>$1,800.00</td>
      <td>$583.00</td>
      <td>83.682222</td>
      <td>83.955000</td>
      <td>90.28%</td>
      <td>93.44%</td>
      <td>91.86%</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>Charter</td>
      <td>1,858</td>
      <td>$1,858.00</td>
      <td>$582.00</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>89.56%</td>
      <td>93.86%</td>
      <td>91.71%</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>Charter</td>
      <td>427</td>
      <td>$427.00</td>
      <td>$581.00</td>
      <td>83.803279</td>
      <td>83.814988</td>
      <td>90.63%</td>
      <td>92.74%</td>
      <td>91.69%</td>
    </tr>
  </tbody>
</table>
</div>



# Support Campuses


```python
support_campuses = campus_summary.sort_values(["Overall Passing Rate"], ascending=True)
support_campuses.head(5)
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Budget Per Student</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Rodriguez High School</th>
      <td>District</td>
      <td>3,999</td>
      <td>$3,999.00</td>
      <td>$637.00</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>64.07%</td>
      <td>77.74%</td>
      <td>70.91%</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>District</td>
      <td>2,917</td>
      <td>$2,917.00</td>
      <td>$655.00</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>63.32%</td>
      <td>78.81%</td>
      <td>71.07%</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>District</td>
      <td>4,761</td>
      <td>$4,761.00</td>
      <td>$650.00</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>63.85%</td>
      <td>78.28%</td>
      <td>71.07%</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>District</td>
      <td>2,949</td>
      <td>$2,949.00</td>
      <td>$639.00</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>63.75%</td>
      <td>78.43%</td>
      <td>71.09%</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>District</td>
      <td>4,635</td>
      <td>$4,635.00</td>
      <td>$652.00</td>
      <td>77.289752</td>
      <td>80.934412</td>
      <td>64.75%</td>
      <td>78.19%</td>
      <td>71.47%</td>
    </tr>
  </tbody>
</table>
</div>



# Math Score by Grade


```python
ninth_grade = ed_df[(ed_df["grade"] == "9th")]
tenth_grade = ed_df[(ed_df["grade"] == "10th")]
eleventh_grade = ed_df[(ed_df["grade"] == "11th")]
twelfth_grade = ed_df[(ed_df["grade"] == "12th")]

freshman_scores = ninth_grade.groupby(["campus"]).mean()["math_score"]
sophmore_scores = tenth_grade.groupby(["campus"]).mean()["math_score"]
junior_scores = eleventh_grade.groupby(["campus"]).mean()["math_score"]
senior_scores = twelfth_grade.groupby(["campus"]).mean()["math_score"]

grade_level_scores = pd.DataFrame({"Freshman": freshman_scores, "Sophmore": sophmore_scores,
                             "Junior": junior_scores, "Senior": senior_scores})

grade_level_scores = grade_level_scores[["Freshman", "Sophmore", "Junior", "Senior"]]

grade_level_scores

```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Freshman</th>
      <th>Sophmore</th>
      <th>Junior</th>
      <th>Senior</th>
    </tr>
    <tr>
      <th>campus</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>77.083676</td>
      <td>76.996772</td>
      <td>77.515588</td>
      <td>76.492218</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.094697</td>
      <td>83.154506</td>
      <td>82.765560</td>
      <td>83.277487</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>76.403037</td>
      <td>76.539974</td>
      <td>76.884344</td>
      <td>77.151369</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>77.361345</td>
      <td>77.672316</td>
      <td>76.918058</td>
      <td>76.179963</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>82.044010</td>
      <td>84.229064</td>
      <td>83.842105</td>
      <td>83.356164</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>77.438495</td>
      <td>77.337408</td>
      <td>77.136029</td>
      <td>77.186567</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.787402</td>
      <td>83.429825</td>
      <td>85.000000</td>
      <td>82.855422</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>77.027251</td>
      <td>75.908735</td>
      <td>76.446602</td>
      <td>77.225641</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>77.187857</td>
      <td>76.691117</td>
      <td>77.491653</td>
      <td>76.863248</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.625455</td>
      <td>83.372000</td>
      <td>84.328125</td>
      <td>84.121547</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>76.859966</td>
      <td>76.612500</td>
      <td>76.395626</td>
      <td>77.690748</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>83.420755</td>
      <td>82.917411</td>
      <td>83.383495</td>
      <td>83.778976</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.590022</td>
      <td>83.087886</td>
      <td>83.498795</td>
      <td>83.497041</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.085578</td>
      <td>83.724422</td>
      <td>83.195326</td>
      <td>83.035794</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.264706</td>
      <td>84.010288</td>
      <td>83.836782</td>
      <td>83.644986</td>
    </tr>
  </tbody>
</table>
</div>



# Reading Scores by Grade


```python
ninth_grade = ed_df[(ed_df["grade"] == "9th")]
tenth_grade = ed_df[(ed_df["grade"] =="10th")]
eleventh_grade = ed_df[(ed_df["grade"] == "11th")]
twelfth_grade = ed_df[(ed_df["grade"] == "12th")]

freshman_scores = ninth_grade.groupby(["campus"]).mean()["reading_score"]
sophmore_scores = tenth_grade.groupby(["campus"]).mean()["reading_score"]
junior_scores = eleventh_grade.groupby(["campus"]).mean()["reading_score"]
senior_scores = twelfth_grade.groupby(["campus"]).mean()["reading_score"]

grade_level_scores = pd.DataFrame({"Freshman": freshman_scores, "Sophmore": sophmore_scores,
                             "Junior": junior_scores, "Senior": senior_scores})

grade_level_scores = grade_level_scores[["Freshman", "Sophmore", "Junior", "Senior"]]

grade_level_scores
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Freshman</th>
      <th>Sophmore</th>
      <th>Junior</th>
      <th>Senior</th>
    </tr>
    <tr>
      <th>campus</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>81.303155</td>
      <td>80.907183</td>
      <td>80.945643</td>
      <td>80.912451</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.676136</td>
      <td>84.253219</td>
      <td>83.788382</td>
      <td>84.287958</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>81.198598</td>
      <td>81.408912</td>
      <td>80.640339</td>
      <td>81.384863</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>80.632653</td>
      <td>81.262712</td>
      <td>80.403642</td>
      <td>80.662338</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>83.369193</td>
      <td>83.706897</td>
      <td>84.288089</td>
      <td>84.013699</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>80.866860</td>
      <td>80.660147</td>
      <td>81.396140</td>
      <td>80.857143</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.677165</td>
      <td>83.324561</td>
      <td>83.815534</td>
      <td>84.698795</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>81.290284</td>
      <td>81.512386</td>
      <td>81.417476</td>
      <td>80.305983</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>81.260714</td>
      <td>80.773431</td>
      <td>80.616027</td>
      <td>81.227564</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.807273</td>
      <td>83.612000</td>
      <td>84.335938</td>
      <td>84.591160</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>80.993127</td>
      <td>80.629808</td>
      <td>80.864811</td>
      <td>80.376426</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>84.122642</td>
      <td>83.441964</td>
      <td>84.373786</td>
      <td>82.781671</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.728850</td>
      <td>84.254157</td>
      <td>83.585542</td>
      <td>83.831361</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.939778</td>
      <td>84.021452</td>
      <td>83.764608</td>
      <td>84.317673</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.833333</td>
      <td>83.812757</td>
      <td>84.156322</td>
      <td>84.073171</td>
    </tr>
  </tbody>
</table>
</div>




```python
spending_bins = [0, 584, 630, 640, 660]
group_names = ["Low", "Moderate", "Adequate", "High"]

campus_summary["Spending Per Student"] = pd.cut(budget_per_student, spending_bins, labels=group_names)
math_score_cost = campus_summary.groupby(["Spending Per Student"]).mean()["Average Math Score"]
reading_score_cost = campus_summary.groupby(["Spending Per Student"]).mean()["Average Reading Score"]
math_percentage_cost = campus_summary.groupby(["Spending Per Student"]).mean()["Average Math Score"]
reading_percentage_cost = campus_summary.groupby(["Spending Per Student"]).mean()["Average Reading Score"]
overall_passing_cost = campus_summary.groupby(["Spending Per Student"]).mean()["Average Reading Score"]

budget_summary = pd.DataFrame({"Average Math Score" : math_score_cost,
                                 "Average Reading Score": reading_score_cost,
                                 "Percent Passing Math": math_percentage_cost,
                                 "Percent Passing Reading": reading_percentage_cost,
                                 "Overall Passing Rate": overall_passing_cost})

budget_summary = spending_summary[["Average Math Score", 
                                     "Average Reading Score", 
                                     "Percent Passing Math", "Percent Passing Reading",
                                     "Overall Passing Rate"]]
budget_summary
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
    <tr>
      <th>Spending Per Student</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Low</th>
      <td>83.455399</td>
      <td>83.933814</td>
      <td>83.933814</td>
      <td>83.933814</td>
      <td>83.933814</td>
    </tr>
    <tr>
      <th>Moderate</th>
      <td>81.899826</td>
      <td>83.155286</td>
      <td>83.155286</td>
      <td>83.155286</td>
      <td>83.155286</td>
    </tr>
    <tr>
      <th>Adequate</th>
      <td>78.990942</td>
      <td>81.917212</td>
      <td>81.917212</td>
      <td>81.917212</td>
      <td>81.917212</td>
    </tr>
    <tr>
      <th>High</th>
      <td>77.023555</td>
      <td>80.957446</td>
      <td>80.957446</td>
      <td>80.957446</td>
      <td>80.957446</td>
    </tr>
  </tbody>
</table>
</div>




```python
spending_bins = [0, 2000, 3000, 5000]
group_names = ["Small", "Medium", "Large"]

campus_summary["Student Population"] = pd.cut(student_count, spending_bins, labels=group_names)
math_score_cost = campus_summary.groupby(["Student Population"]).mean()["Average Math Score"]
reading_score_cost = campus_summary.groupby(["Student Population"]).mean()["Average Reading Score"]
math_percentage_cost = campus_summary.groupby(["Student Population"]).mean()["Average Math Score"]
reading_percentage_cost = campus_summary.groupby(["Student Population"]).mean()["Average Reading Score"]
overall_passing_cost = campus_summary.groupby(["Student Population"]).mean()["Average Reading Score"]

population_summary = pd.DataFrame({"Average Math Score" : math_score_cost,
                                 "Average Reading Score": reading_score_cost,
                                 "Percent Passing Math": math_percentage_cost,
                                 "Percent Passing Reading": reading_percentage_cost,
                                 "Overall Passing Rate": overall_passing_cost})

population_summary = population_summary[["Average Math Score", 
                                     "Average Reading Score", 
                                     "Percent Passing Math", "Percent Passing Reading",
                                     "Overall Passing Rate"]]
population_summary
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
    <tr>
      <th>Student Population</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Small</th>
      <td>83.502373</td>
      <td>83.883125</td>
      <td>83.502373</td>
      <td>83.883125</td>
      <td>83.883125</td>
    </tr>
    <tr>
      <th>Medium</th>
      <td>78.429493</td>
      <td>81.769122</td>
      <td>78.429493</td>
      <td>81.769122</td>
      <td>81.769122</td>
    </tr>
    <tr>
      <th>Large</th>
      <td>77.063340</td>
      <td>80.919864</td>
      <td>77.063340</td>
      <td>80.919864</td>
      <td>80.919864</td>
    </tr>
  </tbody>
</table>
</div>




```python
math_score_cost = campus_summary.groupby(["School Type"]).mean()["Average Math Score"]
reading_score_cost = campus_summary.groupby(["School Type"]).mean()["Average Reading Score"]
math_percentage_cost = campus_summary.groupby(["School Type"]).mean()["Average Math Score"]
reading_percentage_cost = campus_summary.groupby(["School Type"]).mean()["Average Math Score"]
overall_passing_cost = campus_summary.groupby(["School Type"]).mean()["Average Reading Score"]

type_summary = pd.DataFrame({"Average Math Score" : math_score_cost,
                                 "Average Reading Score": reading_score_cost,
                                 "Percent Passing Math": math_percentage_cost,
                                 "Percent Passing Reading": reading_percentage_cost,
                                 "Overall Passing Rate": overall_passing_cost})

type_summary = type_summary[["Average Math Score", 
                                     "Average Reading Score", 
                                     "Percent Passing Math", "Percent Passing Reading",
                                     "Overall Passing Rate"]]
type_summary
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
    <tr>
      <th>School Type</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Charter</th>
      <td>83.473852</td>
      <td>83.896421</td>
      <td>83.473852</td>
      <td>83.473852</td>
      <td>83.896421</td>
    </tr>
    <tr>
      <th>District</th>
      <td>76.956733</td>
      <td>80.966636</td>
      <td>76.956733</td>
      <td>76.956733</td>
      <td>80.966636</td>
    </tr>
  </tbody>
</table>
</div>


