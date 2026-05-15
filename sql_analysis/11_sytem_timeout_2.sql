--Question
--How many ride trips were less than  a minute long and also did not have any end station data?


SELECT
    member_casual AS rider_type,
    COUNT(*) AS system_error_rides,
    rideable_type

FROM
    trips_2025
WHERE
      ride_length < 1 -- Bike trip did not occur as the ride time is under one minute 
     AND end_station_name IS NULL -- bike was unlocked and docked at start_station therefore no end_Station recorded
     AND end_station_id IS NULL
GROUP BY
    rider_type, rideable_type 
ORDER BY
    system_error_rides DESC 

--NOTES
/*
 - From the data, this is a hardware related discovery, tying electric bikes to a unique issue of being unlocked for seconds and then
  redocked back to the start_station, likely due to one of two reasons
   1. Battery issue - riders might have unlocked the bikes and then noticed a low battery and then redocked them
   2. Bike mechanical issue - riders might have unlcoked the bike, then relaized the bike's mechanic/motor wasnt working properly
   
*/


