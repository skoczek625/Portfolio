SELECT
    gift_name,
    weight_kg
FROM gifts
WHERE recipient_type = 'good'
ORDER BY gift_name;