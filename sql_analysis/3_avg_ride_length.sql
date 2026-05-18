-- Question
-- What is the average ride length between casual riders and member riders?

SELECT
    ROUND(AVG(ride_length),2) AS average_ride_length,
    member_casual AS rider_type
FROM trips_2025
WHERE
-- Filter out rides where the bike rider didn't dock the bike 
-- Filter out rides where the bike was only unlocked for a few seconds and then redocked
    is_system_timeout != TRUE
    AND ride_length > 1
GROUP BY
-- Group by member type 
    member_casual
ORDER BY
    average_ride_length DESC

/*
   Summary
  
 🔍Methodology & Volume
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Calculated the average ride length grouped by member type 
    - Ordered the results by the average ride length
 📊Key Metrics 
    - Casual members on average ride for longer times (19.93 minutes) when compared to annual members who ride at an average of 12,19 minutes

 💡Data Interpretation & Business Takeaway
    -- Although member riders account for the most frequent type of riders from the data provided,
        casual riders  have the highest average riding time as the riders ride mostly for leisure and annual members ride the bikes
        most likely as a transport means to and from work or other engagements that may not necessarily need them ride for a long time 

*/
