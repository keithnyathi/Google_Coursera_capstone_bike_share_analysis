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


--NOTES
-- For both the members and the casual riders, electric bikes are the most popular mode of transportation
