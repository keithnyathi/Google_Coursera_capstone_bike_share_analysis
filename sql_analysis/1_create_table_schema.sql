-- Create table to load the excel csvs

CREATE TABLE trips_2025 (
    ride_id VARCHAR(50) PRIMARY KEY,
    rideable_type VARCHAR(50),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    ride_length DECIMAL(15,4),
    day_of_week INT,
    weekday VARCHAR(100),
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(100),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(100),
    start_lat  DECIMAL(10, 8),
    start_lng DECIMAL(11,8),
    end_lat DECIMAL(10,8),
    end_lng DECIMAL(11,8),
    memember_casual VARCHAR(20),
    is_system_timeout BOOLEAN


)

COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\january_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

/*Start Here*/
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\february_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');



/* In order to filter for any duplicates that may have been missed in the excel data cleaning i use a temp table 
    to first out the data in the temp table then insert only the distinct values into the trips_2025 table*/


--create temp table to store the each month's table 
CREATE TABLE trips_temp AS SELECT * FROM trips_2025 WITH NO DATA;

-- Copy the month's csv into temp table
COPY trips_temp
FROM 'C:\\Users\\Public\\Downloads\\december_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- Insert only the unique values from month's table into the trips 2025 schema
INSERT INTO trips_2025
SELECT DISTINCT ON(ride_id) * FROM trips_temp
ON CONFLICT (ride_id) DO NOTHING;


--Empty all the data in trips_temp table
TRUNCATE TABLE trips_temp; 


-- Altering name of the column that i made a mistake on
ALTER TABLE trips_2025
RENAME COLUMN memember_casual TO member_casual