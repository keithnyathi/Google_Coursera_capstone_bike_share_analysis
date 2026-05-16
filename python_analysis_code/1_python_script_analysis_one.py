# %%
import pandas as pd
from sqlalchemy import create_engine

# Connect to database
engine = create_engine('postgresql://postgres:1998@localhost:5432/bike_ride_data')

# Only pull the relevant data for analysis
query = "SELECT* FROM trips_2025 WHERE ride_length < 1 OR ride_length >= 1440"
df_error_ride_data = pd.read_sql(query,engine)

print("Data loaded successfully")

# %%
print(df_error_ride_data.head(50))

# %%
# Information about the bikes ride data that is errounous 

df_error_ride_data.info()

# %%
# Basic statistics of the data (searching to see which is relevant)
df_error_ride_data.describe()

# %%
# filter for only the data with rides longer than 1 day 
system_error_mask = df_error_ride_data['is_system_timeout'] == True
df_error_ride_data[system_error_mask]['ride_id'].count()

# out of the 152709 entries, 5474 of those are bike rides where ride time exceeded 24 hours 
# meaning the bike wasnt docked by the rider but by the system 

# %%
#How many of these rides are members?
members_greater_one_day = (df_error_ride_data['is_system_timeout'] == True) & (df_error_ride_data['member_casual'] == 'member')


members_riders = df_error_ride_data[members_greater_one_day]['ride_id'].count() # count how many of the rides > 1 day and are members there are 

total_errors = df_error_ride_data[system_error_mask]['ride_id'].count() # count all the >1 ride system errors

percentage_of_members = (members_riders / total_errors)* 100 # calculate the percentage of the members 

percentage_of_members

# Out of the 5474 rides that were > 24 hrs , 872 of those belonged to the annual members. 
# 15.9 % of the rides are member riders



# %%
# How many of the rides are casual riders?
casual_riders = total_errors - members_riders #calculate casual riders
casual_percentage = (casual_riders / total_errors) * 100 #calculate percentage
casual_percentage

# 4602 of the rides are casual riders
# 84.07 % are casual riders meaning there is a somehow a correlation between the casual riders and the docking system problem obeserved in the data

# %%
# Do these > 24 hrs system timeout errors happen to a particular bike type?
more_than_one_day_rides = df_error_ride_data[system_error_mask]
bike_type_column = more_than_one_day_rides.loc[:,['rideable_type']]
electric_bikes = bike_type_column == 'electric_bike'
electric_bikes.count()
e_bike_percentage =( (electric_bikes.count()) / bike_type_column.count()) * 100
e_bike_percentage
bike_type_column.count()
electric_bikes.count()




