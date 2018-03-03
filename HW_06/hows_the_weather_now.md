

```python
#Three Observable Trends
## -As cities near the equator, their temperature today generally increased
## -As cities near the equator, their humidity today generally increased
## -As cities near the equator, their cloudiness today generally increased
## -Wind speed (at least today) is not correlated to distance from the equator
```


```python
import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import random as rd
import requests as req
```


```python
# Save config information.
api_key = "5115432d993d25be015121f9b5f69e81"
url = "http://api.openweathermap.org/data/2.5/weather?"
units = "imperial"

# Build partial query URL
query_url = url + "appid=" + api_key + "&units=" + units + "&q="
```


```python
CityData = os.path.join('Resources', 'worldcitiespop.csv')
city_df = pd.read_csv(CityData, encoding = "ISO-8859-1")
city_df.shape
city_df.shape
```

    /Users/christopher/anaconda3/envs/PythonData/lib/python3.6/site-packages/IPython/core/interactiveshell.py:2698: DtypeWarning: Columns (3) have mixed types. Specify dtype option on import or set low_memory=False.
      interactivity=interactivity, compiler=compiler, result=result)





    (1048575, 7)




```python
city_df.head()
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
      <th>Country</th>
      <th>City</th>
      <th>AccentCity</th>
      <th>Region</th>
      <th>Population</th>
      <th>Latitude</th>
      <th>Longitude</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ad</td>
      <td>aixas</td>
      <td>Aixàs</td>
      <td>6</td>
      <td>NaN</td>
      <td>42.48</td>
      <td>1.47</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ad</td>
      <td>aixirivali</td>
      <td>Aixirivali</td>
      <td>6</td>
      <td>NaN</td>
      <td>42.47</td>
      <td>1.50</td>
    </tr>
    <tr>
      <th>2</th>
      <td>ad</td>
      <td>aixirivall</td>
      <td>Aixirivall</td>
      <td>6</td>
      <td>NaN</td>
      <td>42.47</td>
      <td>1.50</td>
    </tr>
    <tr>
      <th>3</th>
      <td>ad</td>
      <td>aixirvall</td>
      <td>Aixirvall</td>
      <td>6</td>
      <td>NaN</td>
      <td>42.47</td>
      <td>1.50</td>
    </tr>
    <tr>
      <th>4</th>
      <td>ad</td>
      <td>aixovall</td>
      <td>Aixovall</td>
      <td>6</td>
      <td>NaN</td>
      <td>42.47</td>
      <td>1.48</td>
    </tr>
  </tbody>
</table>
</div>




```python
city_list_prep = city_df['City'].tolist()
```


```python
city_list = ['Chicago',]
```


```python
for i in range(10):
    x = (random.choice(city_list_prep))
    city_list.append(x)
```


```python
weather_data = []
cities = city_list

# Loop through the list of cities and perform a request for data on each
for city in cities:
    response = req.get(query_url + city).json()
    weather_data.append(response)

weather_data
```




    [{'base': 'stations',
      'clouds': {'all': 1},
      'cod': 200,
      'coord': {'lat': 41.88, 'lon': -87.62},
      'dt': 1520037300,
      'id': 4887398,
      'main': {'humidity': 55,
       'pressure': 1031,
       'temp': 38.53,
       'temp_max': 41,
       'temp_min': 35.6},
      'name': 'Chicago',
      'sys': {'country': 'US',
       'id': 966,
       'message': 0.0046,
       'sunrise': 1520079724,
       'sunset': 1520120595,
       'type': 1},
      'visibility': 16093,
      'weather': [{'description': 'clear sky',
        'icon': '01n',
        'id': 800,
        'main': 'Clear'}],
      'wind': {'deg': 80, 'speed': 4.7}},
     {'cod': '404', 'message': 'city not found'},
     {'base': 'stations',
      'clouds': {'all': 100},
      'cod': 200,
      'coord': {'lat': 6.18, 'lon': -75.66},
      'dt': 1520040170,
      'id': 3670061,
      'main': {'grnd_level': 833.68,
       'humidity': 100,
       'pressure': 833.68,
       'sea_level': 1021.22,
       'temp': 61.09,
       'temp_max': 61.09,
       'temp_min': 61.09},
      'name': 'San Antonio de Prado',
      'rain': {'3h': 1.2025},
      'sys': {'country': 'CO',
       'message': 0.0039,
       'sunrise': 1520075646,
       'sunset': 1520118898},
      'weather': [{'description': 'light rain',
        'icon': '10n',
        'id': 500,
        'main': 'Rain'}],
      'wind': {'deg': 53.5042, 'speed': 1.74}},
     {'base': 'stations',
      'clouds': {'all': 90},
      'cod': 200,
      'coord': {'lat': 52.75, 'lon': -1.01},
      'dt': 1520038200,
      'id': 2644667,
      'main': {'humidity': 92,
       'pressure': 995,
       'temp': 27.9,
       'temp_max': 30.2,
       'temp_min': 26.6},
      'name': 'Hoby',
      'sys': {'country': 'GB',
       'id': 5106,
       'message': 0.0046,
       'sunrise': 1520059587,
       'sunset': 1520099183,
       'type': 1},
      'visibility': 3000,
      'weather': [{'description': 'light snow',
        'icon': '13n',
        'id': 600,
        'main': 'Snow'}],
      'wind': {'deg': 70, 'speed': 19.46}},
     {'cod': '404', 'message': 'city not found'},
     {'base': 'stations',
      'clouds': {'all': 68},
      'cod': 200,
      'coord': {'lat': 32.78, 'lon': 69.08},
      'dt': 1520040171,
      'id': 1131479,
      'main': {'grnd_level': 768.1,
       'humidity': 87,
       'pressure': 768.1,
       'sea_level': 1028.28,
       'temp': 28.19,
       'temp_max': 28.19,
       'temp_min': 28.19},
      'name': 'Babu Khel',
      'sys': {'country': 'AF',
       'message': 0.0037,
       'sunrise': 1520041769,
       'sunset': 1520083335},
      'weather': [{'description': 'broken clouds',
        'icon': '04n',
        'id': 803,
        'main': 'Clouds'}],
      'wind': {'deg': 239.504, 'speed': 2.08}},
     {'cod': '404', 'message': 'city not found'},
     {'cod': '404', 'message': 'city not found'},
     {'base': 'stations',
      'clouds': {'all': 90},
      'cod': 200,
      'coord': {'lat': 49.93, 'lon': 11.58},
      'dt': 1520038560,
      'id': 3220846,
      'main': {'humidity': 73,
       'pressure': 999,
       'temp': 23.97,
       'temp_max': 24.8,
       'temp_min': 23},
      'name': 'Birken',
      'sys': {'country': 'DE',
       'id': 4962,
       'message': 0.0045,
       'sunrise': 1520056381,
       'sunset': 1520096341,
       'type': 1},
      'visibility': 10000,
      'weather': [{'description': 'light snow',
        'icon': '13n',
        'id': 600,
        'main': 'Snow'}],
      'wind': {'deg': 90, 'speed': 3.36}},
     {'base': 'stations',
      'clouds': {'all': 40},
      'cod': 200,
      'coord': {'lat': 39.09, 'lon': -9.04},
      'dt': 1520038800,
      'id': 2262581,
      'main': {'humidity': 82,
       'pressure': 999,
       'temp': 56.32,
       'temp_max': 57.2,
       'temp_min': 55.4},
      'name': 'Meca',
      'sys': {'country': 'PT',
       'id': 5961,
       'message': 0.0045,
       'sunrise': 1520060758,
       'sunset': 1520101845,
       'type': 1},
      'visibility': 10000,
      'weather': [{'description': 'scattered clouds',
        'icon': '03n',
        'id': 802,
        'main': 'Clouds'}],
      'wind': {'deg': 230, 'speed': 16.11}},
     {'cod': '404', 'message': 'city not found'}]




```python
# Extract interesting data from responses
lat_data = [data.get("coord").get("lat") for data in weather_data]
temp_data = [data.get("main").get("temp") for data in weather_data]
hum_data = [data.get("main").get("humidity") for data in weather_data]
cloud_data = [data.get("clouds").get("all") for data in weather_data]
wind_data = [data.get("wind").get("speed") for data in weather_data]

weather_data = {"temp": temp_data, "lat": lat_data, 'hum': hum_data, 'cloud' : cloud_data, 'wind': wind_data,}
weather_data = pd.DataFrame(weather_data)
weather_data.head()
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    <ipython-input-158-d85541e59759> in <module>()
          1 # Extract interesting data from responses
    ----> 2 lat_data = [data.get("coord").get("lat") for data in weather_data]
          3 temp_data = [data.get("main").get("temp") for data in weather_data]
          4 hum_data = [data.get("main").get("humidity") for data in weather_data]
          5 cloud_data = [data.get("clouds").get("all") for data in weather_data]


    <ipython-input-158-d85541e59759> in <listcomp>(.0)
          1 # Extract interesting data from responses
    ----> 2 lat_data = [data.get("coord").get("lat") for data in weather_data]
          3 temp_data = [data.get("main").get("temp") for data in weather_data]
          4 hum_data = [data.get("main").get("humidity") for data in weather_data]
          5 cloud_data = [data.get("clouds").get("all") for data in weather_data]


    AttributeError: 'NoneType' object has no attribute 'get'



```python
# Build a scatter plot for each data type
plt.scatter(weather_data["lat"], weather_data["temp"], marker="o")

# Incorporate the other graph properties
plt.title("Does Latitude Affect Temperature?")
plt.ylabel("Temperature (Farenhight)")
plt.xlabel("Latitude")
plt.grid(True)

# Save the figure
plt.savefig("lat_tem.jpg")

# Show plot
plt.show()
```


```python
# Build a scatter plot for each data type
plt.scatter(weather_data["lat"], weather_data["hum"], marker="o")

# Incorporate the other graph properties
plt.title("Does Latitude Affect Humidity?")
plt.ylabel("Humidity (%)")
plt.xlabel("Latitude")
plt.grid(True)

# Save the figure
plt.savefig("lat_hum.jpg")

# Show plot
plt.show()
```


```python
# Build a scatter plot for each data type
plt.scatter(weather_data["lat"], weather_data["cloud"], marker="o")

# Incorporate the other graph properties
plt.title("Does Latitude Affect Cloud Cover?")
plt.ylabel("Cloudiness (%)")
plt.xlabel("Latitude")
plt.grid(True)

# Save the figure
plt.savefig("lat_cloud.jpg")

# Show plot
plt.show()
```


```python
# Build a scatter plot for each data type
plt.scatter(weather_data["lat"], weather_data["wind"], marker="o")

# Incorporate the other graph properties
plt.title("Does Latitude Affect Wind Speed?")
plt.ylabel("Wind Speed (mph)")
plt.xlabel("Latitude")
plt.grid(True)

# Save the figure
plt.savefig("lat_wind.jpg")

# Show plot
plt.show()
```
