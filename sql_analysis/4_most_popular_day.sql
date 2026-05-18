-- Question
-- What is the most popular day or days for the casual vs the annual members?


SELECT
    COUNT(ride_id) AS number_of_rides,
    weekday,
    member_casual
FROM trips_2025
WHERE
    is_system_timeout != TRUE
    AND ride_length > 1
GROUP BY
    weekday,
    member_casual
ORDER BY
    number_of_rides DESC


/*
   Summary
  
 🔍Methodology & Volume
    - Filtered out rides exceeding 24 hours ( > 1440 minutes) and those rides that had ride length less than 1 minute
    - Calculated using aggregation method COUNT, the number of rides taken during the 7 days of the week.
    - Grouped the results by day of the week and the rider type(member or casual)
    - Ordered the results by the number of rides with the most rides first going down
 📊Key Metrics 
    - The query shows that for annual members Mondays to Fridays are the days that see the highest volume of bike traffic
    - When it comes to the casual riders, weekends (Saturday and Sunday) are the days with the most bike traffic 

 💡Data Interpretation & Business Takeaway
   -- Annual members show an increased and more visible usage of the bikes for days (Mon - Friday)
       which are work days on the calender further suggesting that annual members ride the bike as a transport means to and from work or they use the bikes for activities that require repeated attendance during the week
   -- Casual riders also have a high frequency of bike riding on weekends than the rest of the weekdays, hinting at them using the bikes for leisure related purposes (traveling tourists, one time users, etc)

*/
 

