--Question
-- Among casual riders, members , what is the most popular bike type 

SELECT
    member_casual AS rider_status,
    COUNT(rideable_type) AS bike_type_sum,
    rideable_type
FROM
    trips_2025
WHERE
    is_system_timeout != TRUE AND
    ride_length > 1
GROUP BY
    member_casual, rideable_type
ORDER BY
    bike_type_sum DESC

/*
   Summary
  
 🔍Methodology & Volume
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Counted the number of bikes 
    - Grouped the data by rider type and the bike type
    - Ordered the results by the average ride length
 📊Key Metrics 
    - Annual members ride the bikes much more frequently and as such the count for them is higher but for both the casual riders
      and the members, electric bikes are the most frequently used compared to classic bikes

 💡Data Interpretation & Business Takeaway
   -- For both the members and the casual riders, electric bikes are the most popular mode of transportation likely due to 
      the ease and convenience of riding of the e-bikes. E-bikes don't require manual pedalling and stamina like classic bikes 
      and that might lead users to prefer them as a mode of movement

*/

