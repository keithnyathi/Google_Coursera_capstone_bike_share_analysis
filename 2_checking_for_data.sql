-- Checking the table for any errors in data migration via counting

SELECT 
    EXTRACT(MONTH FROM started_at) AS month_date,
    COUNT(*)
FROM trips_2025
GROUP BY
    month_date
ORDER BY
    month_date

