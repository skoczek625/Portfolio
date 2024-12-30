SELECT
    pb.bear_name,
    MAX(ml.food_weight_kg) AS greatest_meal_kg
FROM polar_bears pb
    JOIN meal_log ml
    ON pb.bear_id = ml.bear_id
WHERE 
    STRFTIME('%m', ml.date) = '12' AND
    STRFTIME('%Y', ml.date) = '2024'
GROUP BY pb.bear_name
ORDER BY greatest_meal_kg DESC;