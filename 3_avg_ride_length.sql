SELECT
    ROUND(AVG(ride_length),2) AS average_ride_length,
    memember_casual AS rider_type
FROM trips_2025
WHERE
    is_system_timeout != TRUE
GROUP BY
    memember_casual
ORDER BY
    average_ride_length DESC
