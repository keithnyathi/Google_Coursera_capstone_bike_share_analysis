-- Question
-- How do mean trip durations fluctuate across the days of the week when comparing annual members and casual riders?

SELECT
    ROUND(AVG(ride_length),2) AS Average_ride_time,
    weekday,
    member_casual AS rider_type
FROM trips_2025
WHERE
    is_system_timeout != TRUE
    AND ride_length > 1
GROUP BY
    weekday,
    member_casual
ORDER BY
    Average_ride_time DESC


/*
   Summary
  
 🔍Methodology
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Calculated the average ride length grouped by member type and weekday
    - Ordered the results by the average ride length in descending order
 📊Key Metrics 
    - Casual riders have higher average riding times during the entire 7 days of the week, however Saturday and Sunday are the days where they ride longest in comparison to the rest of the week
    - Annual members take up the bottom 7 positions as they don't ride as long on average, for members as well Saturday and Sunday are the days when they ride longest  

 💡Data Interpretation & Business Takeaway
    -- Since the casual riders have a noticeably higher average ride time , their influence is visible on the average 
        ride time by day of the week, weekends (Sat and Sun) have the highest average ride time due to casual riders riding the most
        during the weekend because most of the leisure bike riding, city exploration etc is done commonly during the weekends when the users aren't working
    -- The notion of riding during the weekends not for work related engagements but for relaxation,exploring,leisure proves true even with annual members as their 
        average ride time also peaks during the weekend when they're likely not working.
    
*/

