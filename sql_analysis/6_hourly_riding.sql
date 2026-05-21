-- Question
-- Which customer demographic dominates daily ridership volume?
-- At what hours of the day do the riders (filtered by type) ride their bikes?

SELECT
    EXTRACT(HOUR FROM started_at) AS ride_hour,
    member_casual AS rider_type,
    COUNT(ride_id) AS total_rides
FROM trips_2025
WHERE
    is_system_timeout != TRUE
    AND EXTRACT(HOUR FROM started_at) IN (6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22)
    AND ride_length > 1
GROUP BY
    ride_hour,rider_type
ORDER BY
    total_rides DESC

/*
   Summary
  
 🔍Methodology
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Extracted the hour from the started_at column as ride_hour
    - Filtered for specific hours during the day relevant to the question
    - Ordered the results by the the number of rides
 📊Key Metrics 
    - Members take more rides during the specific hours (6am - 10am) and (3pm - 8pm) than casual riders
    - For hours such as 7am, 8 am members take twice as many rides as casual riders
    - For the hours of (4,5,6 pm), the late hours of the afternoon , members take between 290,000 to almost 400,000 rides while
      casual riders take between 150,000 to 180,000 rides

 💡Data Interpretation & Business Takeaway
   -- There is an increased number of member riders in general compared to casual riders. The surge in bike ride traffic during these hours for 
       member riders is a result of the riders going and coming from work.
   -- Casual riders do take rides during those hours as well but the number varies quite a lot in comparison to the members 
   

*/

