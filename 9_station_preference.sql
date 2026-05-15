-- Question
-- Which station is most preferred by casual riders and which is preferred by members


SELECT
    start_station_name,
    COUNT(ride_id) AS ride_count,
    member_casual AS rider_type
FROM
    trips_2025
WHERE
    is_system_timeout != TRUE
    AND ride_length > 1 
    AND start_station_name IS NOT NULL  -- This filters out 20% start station data values as they are nulls 
GROUP BY
    start_station_name, rider_type
ORDER BY
    ride_count DESC
LIMIT
    10

--NOTES
/*

N.B For station-based analysis, 20% of entries were excluded due to missing station identifiers, predominantly associated with free-locking electric bike trips.
 
 -For the Casual rider , the station "DuSable Lake Shore Dr & Monroe St" is the most popular as 
     connected to a number of tourist attractions and leisure establishments within the area luring in the casual riders 
 -For the annual members "Kingsbury St & Kinzie St" is the place to be as it sees quite a number of the members take off from its docking area
     This is likely because it is located right in a dense hub of tech headquarters and transit connections,
     as well as busy office buildings buzzing with workers who commute there daily using the bikes
*/
