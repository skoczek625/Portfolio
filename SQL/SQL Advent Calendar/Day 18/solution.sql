SELECT
    a.activity_name,
    AVG(ar.rating) AS average_rating
FROM activities a
    JOIN activity_ratings ar
    ON a.activity_id = ar.activity_id
GROUP BY ar.activity_id
ORDER BY average_rating DESC
LIMIT 2;