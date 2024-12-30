SELECT
    DISTINCT v.vendor_name
FROM vendors v
    JOIN item_prices ip
    ON v.vendor_id = ip.vendor_id
WHERE ip.price_usd < 10;