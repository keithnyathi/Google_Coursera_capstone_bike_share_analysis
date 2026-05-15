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
    ride_length >= 1440 -- rides that took more than 24 hrs
GROUP BY
    rider_type -- groupby rider type


--NOTES
/*
 - About 98% of the rides that exceeded 24 hours had NULL end stations and as such are considered to have been locked via a system timeout
   with most users being casual riders and will be treated as having occured as a result of riders not being familiar with the docking system or failing to dock
   at the end stations 
*/