
-- Question
-- What is the most popular month for casual and member riders?

SELECT 
    member_casual AS rider_status,
    EXTRACT(MONTH FROM started_at) AS month_date,
    CASE 
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 1 THEN 'January'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 2 THEN 'February'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 3 THEN 'March'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 5 THEN  'May'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 6 THEN 'June'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 7 THEN 'July'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 8 THEN 'August'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 10 THEN 'October'
        WHEN EXTRACT(MONTH FROM started_at)::INTEGER = 11 THEN 'November'
        ELSE 'December'
    END AS months,
    COUNT(ride_id)AS ride_count
FROM trips_2025
WHERE   
    is_system_timeout != TRUE -- Filter out the system docked bikes
    AND ride_length > 1 -- Filter out redoced after one minute rides
GROUP BY
    month_date, member_casual 
ORDER BY
    ride_count DESC

-- NOTES
-- For both casual and member riders the months of June - September do seem to be the most popular for bikeriding
