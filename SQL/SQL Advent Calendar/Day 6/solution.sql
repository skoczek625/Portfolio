SELECT 
    pb.bear_id,
    pb.bear_name,
    SUM(t.distance_km) AS total_distance_traveled
FROM polar_bears AS pb
    LEFT JOIN tracking AS t
    ON pb.bear_id = t.bear_id
WHERE
    t.date >= '2024-12-01' AND
    t.date < '2025-01-01'
GROUP BY
    pb.bear_id,
    pb. bear_name
ORDER BY total_distance_traveled DESC
LIMIT 3;