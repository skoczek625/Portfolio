SELECT
    category,
    SUM(quantity_sold * price_per_unit) AS total_revenue
FROM candy_sales
GROUP BY category
ORDER BY total_revenue DESC;