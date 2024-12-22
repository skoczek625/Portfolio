SELECT *
FROM farmers_market.product
LIMIT 10;

DESCRIBE product;

SELECT
	product_id,
    COUNT(*)
FROM farmers_market.product
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT *
FROM farmers_market.product_category;

SELECT
	COUNT(*) 
FROM farmers_market.product;

SELECT
	pc.product_category_id,
    pc.product_category_name,
    COUNT(product_id) AS count_of_products
FROM farmers_market.product_category AS pc
LEFT JOIN farmers_market.product AS p
	ON pc.product_category_id = p.product_category_id
GROUP BY pc.product_category_id;

SELECT
DISTINCT product_qty_type
FROM farmers_market.product;

SELECT *
FROM farmers_market.vendor_inventory
LIMIT 10;

SELECT
	market_date,
    vendor_id,
    product_id,
    COUNT(*)
FROM farmers_market.vendor_inventory
GROUP BY market_date, vendor_id, product_id
HAVING COUNT(*) > 1;

SELECT
	MIN(market_date),
    MAX(market_date)
FROM farmers_market.vendor_inventory;

SELECT
	vendor_id,
    MIN(market_date),
    MAX(market_date)
FROM farmers_market.vendor_inventory
GROUP BY vendor_id
ORDER BY MIN(market_date), MAX(market_date);

SELECT
	EXTRACT(YEAR FROM market_date) AS market_year,
    EXTRACT(MONTH FROM market_date) AS market_month,
    COUNT(DISTINCT vendor_id) AS vendors_with_inventory
FROM farmers_market.vendor_inventory
GROUP BY EXTRACT(YEAR FROM market_date), EXTRACT(MONTH FROM market_date)
ORDER BY EXTRACT(YEAR FROM market_date), EXTRACT(MONTH FROM market_date);

SELECT *
FROM farmers_market.vendor_inventory
WHERE vendor_id = 7
ORDER BY market_date, product_id;

SELECT *
FROM farmers_market.customer_purchases
LIMIT 10;

SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id = 7 AND product_id = 4
ORDER BY market_date, transaction_time;

SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id = 7 AND product_id = 4 AND customer_id = 12
ORDER BY customer_id, market_date, transaction_time;

SELECT
	market_date,
    vendor_id,
    product_id,
    SUM(quantity) quantity_sold,
    SUM(quantity * cost_to_customer_per_qty) total_sales
FROM farmers_market.customer_purchases
WHERE vendor_id = 7 AND product_id = 4
GROUP BY market_date, vendor_id, product_id
ORDER BY market_date, vendor_id, product_id;

SELECT *
FROM farmers_market.vendor_inventory AS vi
	LEFT JOIN
		(
			SELECT
				market_date,
                vendor_id,
                product_id,
                SUM(quantity) AS quantity_sold,
                SUM(quantity * cost_to_customer_per_qty) AS total_sales
			FROM farmers_market.customer_purchases
            GROUP BY market_date, vendor_id, product_id
		) AS sales
        ON vi.market_date = sales.market_date
			AND vi.vendor_id = sales.vendor_id
            AND vi.product_id = sales.product_id
	ORDER BY vi.market_date, vi.vendor_id, vi.product_id
    LIMIT 10;
    
    SELECT
		vi.market_date,
        vi.vendor_id,
        v.vendor_name,
        vi.product_id,
        p.product_name,
        vi.quantity AS quantity_available,
        sales.quantity_sold,
        vi.original_price,
        sales.total_sales
	FROM farmers_market.vendor_inventory AS vi
		LEFT JOIN
			(
				SELECT
					market_date,
                    vendor_id,
                    product_id,
                    SUM(quantity) AS quantity_sold,
                    SUM(quantity * cost_to_customer_per_qty) AS total_sales
				FROM farmers_market.customer_purchases
                GROUP BY market_date, vendor_id, product_id
			) AS sales
		ON vi.market_date = sales.market_date
			AND vi.vendor_id = sales.vendor_id
            AND vi.product_id = sales.product_id
		LEFT JOIN farmers_market.vendor v
			ON vi.vendor_id = v.vendor_id
		LEFT JOIN farmers_market.product p
			ON vi.product_id = p.product_id
	WHERE vi.vendor_id = 7
		AND vi.product_id = 4
ORDER BY vi.market_date, vi.vendor_id, vi.product_id;