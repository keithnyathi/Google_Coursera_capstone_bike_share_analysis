-- Question
-- Which of the riders casual or member ride the most during the day ?
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
    ride_hour, rider_type


-- NOTES
-- Increased number of member riders in general compared to casual riders
-- member rider numbers surge during the early hours of going to work (6-9) 
-- and the late hours of returning from work (5-9) when compared to other hours during the day
