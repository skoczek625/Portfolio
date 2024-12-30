SELECT 
    *,
    weight - LAG(weight) OVER (ORDER BY day_of_month) AS difference_from_the_previous_days_weight
FROM grinch_weight_log
ORDER BY day_of_month;