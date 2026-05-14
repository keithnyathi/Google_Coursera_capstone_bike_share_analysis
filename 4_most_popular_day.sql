SELECT
    COUNT(ride_id) AS number_of_rides,
    weekday,
    memember_casual
FROM trips_2025
WHERE
    is_system_timeout != TRUE
GROUP BY
    weekday,
    memember_casual
ORDER BY
    number_of_rides DESC