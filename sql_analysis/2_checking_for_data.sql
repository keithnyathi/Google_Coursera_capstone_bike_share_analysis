-- Checking the table for any errors in data migration via counting

-- Query will show number of rides grouped by month 
SELECT 
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
    COUNT(*)
FROM trips_2025
GROUP BY
    month_date
ORDER BY
    month_date

