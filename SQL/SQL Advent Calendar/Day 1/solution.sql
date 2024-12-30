SELECT 
    customer_name,
    COUNT(DISTINCT(activity)) AS activity_count
FROM rentals
GROUP BY customer_name
HAVING activity_count > 1
ORDER BY customer_name;