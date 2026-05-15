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
 
-- NOTES
-- Annual members show an increased and more visible usage of the bikes for days (Mon - Friday)
-- which are work days on the calender further suggesting that annual members ride the bike as a transport means to and from work
-- Casual riders also have a high frequency of bike riding on weekends than the rest of the weekdays, hinting at them using the bikes as for leisure related purposes (traveling tourists, one time users, etc)

