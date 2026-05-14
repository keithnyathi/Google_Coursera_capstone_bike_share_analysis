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




-- Has duplicate values
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\march_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');


--create temp table to store the JUNE table 
CREATE TABLE trips_temp AS SELECT * FROM trips_2025 WITH NO DATA;

-- Copy March csv into temp table
COPY trips_temp
FROM 'C:\\Users\\Public\\Downloads\\december_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- Insert only the unique values from March table into the trips 2025 schema
INSERT INTO trips_2025
SELECT DISTINCT ON(ride_id) * FROM trips_temp
ON CONFLICT (ride_id) DO NOTHING;


TRUNCATE TABLE trips_temp;


COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\april_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\may_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');




COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\june_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');




COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\july_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\august_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\september_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\october_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\november_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY trips_2025
FROM 'C:\\Users\\Public\\Downloads\\december_data.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

TRUNCATE TABLE trips_2025;