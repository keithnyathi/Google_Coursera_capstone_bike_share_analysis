-- Question
/* How many rides can be considered as rides left undocked and locked only when they had passed 24hrs
  (system timeout)?
  */

SELECT
    COUNT(*) AS system_timeout_rides, 
    COUNT(end_station_name) AS actual_end_station_names,
/*Below i calculate out of all the stations that exceeded 24 hrs, which ones have empty end_Station_names 
    and thus can be considered actual system timeout rides */
    COUNT(*) - COUNT(end_station_name) AS null_end_stations, 
    member_casual AS rider_type
FROM trips_2025
WHERE
    ride_length > 1440 -- rides that took more than 24 hrs
GROUP BY
    rider_type -- groupby rider type


--NOTES
/*
  Summary
  
 🔍Methodology
    - Filtered for rides exceeding 24 hours (> 1440 minutes) 
    - Counted the number of ride logs
    - Counted all data contained in the end_station_name column
    - In order to get all rides that exceeded 24 hours with null end_station_name entries 
    - Grouped the data by rider type
 📊Key Metrics 
    - A total of 5585 rides taken exceeded 24 hours 
    - 4677 of these rides were done by casual riders
    - 908 of the rides by annual members


 💡Data Interpretation & Business Takeaway
   - With most users being casual riders, these rides will be treated as having occured as a result of riders not being familiar with the docking system or failing to dock
   at the end stations 
   - I perform a more detailes analysis in Python
*/