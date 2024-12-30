WITH dish_calorie_density AS (
    SELECT 
        m.dish_name,
        e.event_name,
        1.0*m.calories / NULLIF(m.weight_g, 0) AS calorie_density
    FROM menu m
        JOIN events e
        ON m.event_id = e.event_id
),
ranked_dishes AS (
    SELECT 
        dish_name,
        event_name,
        calorie_density,
        ROW_NUMBER() OVER (PARTITION BY event_name ORDER BY calorie_density DESC) AS dish_rank
    FROM dish_calorie_density
)
SELECT 
    dish_name,
    event_name,
    calorie_density
FROM ranked_dishes
WHERE 
    dish_rank <= 3
ORDER BY 
    event_name,
    dish_rank;