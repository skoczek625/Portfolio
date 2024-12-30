SELECT
    recipient,
    SUM(weight_kg) AS total_weight
FROM gifts
GROUP BY recipient;