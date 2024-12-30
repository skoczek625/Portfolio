SELECT
    v.vendor_name,
    SUM(s.quantity_sold * s.price_per_unit) AS total_revenue
FROM vendors v
    JOIN sales s
    ON v.vendor_id = s.vendor_id
GROUP BY v.vendor_name
ORDER BY total_revenue DESC
LIMIT 2;