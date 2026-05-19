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


/*

N.B For station-based analysis, 20% of entries were excluded due to missing station identifiers, predominantly associated with free-locking electric bike trips.
 
   Summary
  
 🔍Methodology & Volume
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Counted the number of bike rides
    - Grouped the data by station name and the rider type
    - Ordered the results by the ride count
    - Limited the results to the top ten stattions
 📊Key Metrics 
    - The analysis shows the top ten sations, and in the result "DuSable Lake Shore Dr & Monroe st" and "Kingsbury St & Kinzie St" are the popularly used
      sattions for casual riders and annual members respectively

 💡Data Interpretation & Business Takeaway
  -For the Casual rider , the station "DuSable Lake Shore Dr & Monroe St" is the most popular station as 
     it is connected to a number of tourist attractions and leisure establishments within the area luring in the casual riders 
 -For the annual members "Kingsbury St & Kinzie St" is the place to be as it sees quite a number of the members take off from its docking area
     This is likely because it is located right in a dense hub of tech headquarters and transit connections,
     as well as busy office buildings buzzing with workers who commute there daily using the bikes
*/
