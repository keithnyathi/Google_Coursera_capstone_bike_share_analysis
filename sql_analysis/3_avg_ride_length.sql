-- Question
-- What is the average ride length between casual riders and member riders?

SELECT
    ROUND(AVG(ride_length),2) AS average_ride_length,
    member_casual AS rider_type
FROM trips_2025
WHERE
-- Filter out rides where the bike rider didn't dock the bike 
-- Filter out rides where the bike was only unlocked for a few seconds and then redocked
    is_system_timeout != TRUE
    AND ride_length > 1
GROUP BY
-- Group by member type 
    member_casual
ORDER BY
    average_ride_length DESC


-- Although member riders account for the most frequent type of riders from the data provided,
-- casual riders  have the highest average riding time as the riders ride mostly for leisure and annual members ride the bikes
-- most likely as a transport means to and from work
