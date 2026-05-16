import pandas as pd
from sqlalchemy import create_engine

# Connect to database
engine = create_engine('postgresql://postgres:1998@localhost:5432/bike_ride_data')

# Only pull the relevant data for analysis
query = "SELECT* FROM trips_2025 WHERE ride_length < 1 OR ride_length >= 1440"
df_errors = pd.read_sql(query,engine)

print("Data loaded successfully")

print(df_errors.head(40))