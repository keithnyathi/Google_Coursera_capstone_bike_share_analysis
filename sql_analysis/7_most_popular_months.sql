
-- Question
-- What are the peak operational months for Cyclistic, segmented by user type?

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


/*
   Summary
  
 🔍Methodology
    - Filtered out rides exceeding 24 hours (> 1440 minutes) and those rides that had ride length less than 1 minute
    - Calculated the total rides taken using COUNT() aggregation 
    - Used CASE statement to create a column containing the names for months of the year
    - Ordered the results by the ride count
    - Grouped the results by month and rider status (member or casual)
 📊Key Metrics 
    - For both casual and member riders the months of June - September are the most popular for bike riding 


 💡Data Interpretation & Business Takeaway

   -- The popularity for bike riding during the months from June to September is because in the US or the Northern hemisphere, these
       are summer months or warmer months of the year and this makes bike riding much more enjoyable and a popular choice 

*/


