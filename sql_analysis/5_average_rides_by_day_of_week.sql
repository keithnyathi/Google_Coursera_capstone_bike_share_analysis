-- Question
-- What is the average ride_length by day of the week

SELECT
    ROUND(AVG(ride_length),2) AS Average_ride_time,
    weekday
FROM trips_2025
WHERE
    is_system_timeout != TRUE
    AND ride_length > 1
GROUP BY
    weekday
ORDER BY
    Average_ride_time DESC


-- NOTES
-- Since the casual riders havea noticeably higher average ride time , their influence is visible on the average 
-- ride time by day of the week, weekends (Sat and Sun) have the highest average ride time due to casual riders riding the most
-- during the weekend 