SELECT
	vendor_id,
    MAX(original_price) AS highest_price
FROM farmers_market.vendor_inventory
GROUP BY vendor_id
ORDER BY vendor_id;

#ROW_NUMBER
SELECT *
FROM farmers_market.vendor_inventory;

SELECT
	vendor_id,
    market_date,
    product_id,
    original_price,
    ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
FROM farmers_market.vendor_inventory
ORDER BY vendor_id, original_price DESC;

SELECT * FROM
	(
		SELECT
			vendor_id,
            market_date,
            product_id,
            original_price,
            ROW_NUMBER() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
		FROM farmers_market.vendor_inventory
        ORDER BY vendor_id) x
	WHERE x.price_rank = 1;
    
    #RANK AND DENSE_RANK
    SELECT
		vendor_id,
        market_date,
        product_id,
        original_price,
        DENSE_RANK() OVER (PARTITION BY vendor_id ORDER BY original_price DESC) AS price_rank
	FROM farmers_market.vendor_inventory
    ORDER BY vendor_id, original_price DESC;
    
    #NTILE
    SELECT
		vendor_id,
        market_date,
        product_id,
        original_price,
        NTILE(10) OVER (ORDER BY original_price DESC) AS price_ntile
	FROM farmers_market.vendor_inventory
    ORDER BY original_price DESC;
    
    SELECT
		vendor_id,
        market_date,
        product_id,
        original_price,
        AVG(original_price) OVER (PARTITION BY market_date) AS average_cost_product_by_market_date
	FROM vendor_inventory;
    
    SELECT * FROM
    (
		SELECT 
			vendor_id,
            market_date,
            product_id,
            original_price,
            ROUND(AVG(original_price) OVER (PARTITION BY market_date ORDER BY market_date), 2)
				AS average_cost_product_by_market_date
			FROM vendor_inventory
	) x
    WHERE x.vendor_id > 0
		AND x.original_price > x.average_cost_product_by_market_date
	ORDER BY x.market_date, x.original_price DESC;
    
    WITH x AS 
    (
		SELECT 
			vendor_id,
            market_date,
            product_id,
            original_price,
            ROUND(AVG(original_price) OVER (PARTITION BY market_date ORDER BY market_date), 2)
				AS average_cost_product_by_market_date
			FROM vendor_inventory
	)
    SELECT *
    FROM x 
        WHERE x.vendor_id > 0
		AND x.original_price > x.average_cost_product_by_market_date
	ORDER BY x.market_date, x.original_price DESC;
    
    # COUNT ALL PRODUCTS BY VENDORS AND EVERY MARKET DAY
    SELECT
		vendor_id,
        market_date,
        product_id,
        original_price,
        COUNT(product_id) OVER (PARTITION BY market_date, vendor_id)
        AS vendor_product_count_per_market_date
	FROM vendor_inventory
    ORDER BY vendor_id, market_date, original_price DESC;
    
    SELECT
		customer_id,
        market_date,
        vendor_id,
        product_id,
        quantity * cost_to_customer_per_qty AS price,
        SUM(quantity * cost_to_customer_per_qty) OVER (ORDER BY market_date, transaction_time, customer_id, product_id) 
			AS running_total_purchases
	FROM customer_purchases;    
    
    SELECT
		customer_id,
        market_date,
        vendor_id,
        product_id,
        quantity * cost_to_customer_per_qty AS price,
        SUM(quantity * cost_to_customer_per_qty)
        OVER (PARTITION BY customer_id ORDER BY market_date, transaction_time, product_id) AS customer_spend_running_total
	FROM customer_purchases;
    
    SELECT
		customer_id,
        market_date,
        vendor_id,
        product_id,
        ROUND(quantity * cost_to_customer_per_qty, 2) AS price,
        ROUND(SUM(quantity * cost_to_customer_per_qty) OVER (PARTITION BY customer_id), 2) AS customer_total_spend
	FROM customer_purchases;
    
# LAG AND LEAD

SELECT
	market_date,
    vendor_id,
    booth_number,
    LAG(booth_number, 1) OVER (PARTITION BY vendor_id ORDER BY market_date, vendor_id) AS previous_booth_number
FROM vendor_booth_assignments
ORDER BY market_date, vendor_id, booth_number;

SELECT * FROM
(
	SELECT
		market_date,
        vendor_id,
        booth_number,
        LAG(booth_number, 1) OVER (PARTITION BY vendor_id ORDER BY market_date, vendor_id) AS previous_booth_number
	FROM vendor_booth_assignments
    ORDER BY market_date, vendor_id, booth_number
) x
WHERE x.market_date = '2019-04-10'
	AND (x.booth_number <> x.previous_booth_number OR previous_booth_number IS NULL);
    
    SELECT
		market_date,
        SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales
	FROM customer_purchases
    GROUP BY market_date
    ORDER BY market_date;
    
SELECT
	market_date,
    SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales,
    LAG(SUM(quantity * cost_to_customer_per_qty), 1) OVER (ORDER BY market_date)
		AS previous_market_date_total_sales
	FROM customer_purchases
    GROUP BY market_date
    ORDER BY market_date;
    
SELECT *
FROM customer_purchases;

# EXCERSISE 1a
SELECT
	DISTINCT market_date,
    customer_id,
    DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date, customer_id)
    AS visit_number
FROM customer_purchases;

 WITH x AS   
(
   SELECT
		DISTINCT market_date, customer_id
        FROM customer_purchases
)
SELECT 
	market_date,
    customer_id,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id, market_date)
    AS visit_number
FROM x;

# EXCERSISE 1b
SELECT
	DISTINCT market_date,
    customer_id,
    DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC, customer_id)
    AS visit_number
FROM customer_purchases;

WITH x AS
(
	SELECT
		DISTINCT market_date,
        customer_id,
        DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date DESC, customer_id)
        AS visit_number
	FROM customer_purchases
) 
	SELECT 
    market_date AS last_visit_date,
    customer_id
    FROM x
WHERE x.visit_number = 1;

# EXCERSISE 2
	SELECT 
    cp.*,
    COUNT(product_id) OVER (PARTITION BY customer_id, product_id ORDER BY customer_id, product_id)
    AS number_of_product_purchases
	FROM customer_purchases cp;
    
# EXCERSISE 3
	SELECT
		market_date,
        SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales,
        LAG(SUM(quantity * cost_to_customer_per_qty), 1) OVER (ORDER BY market_date)
			AS previous_market_date_total_sales
	FROM customer_purchases
    GROUP BY market_date
    ORDER BY market_date;

SELECT
	market_date,
    SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales,
    LEAD(SUM(quantity * cost_to_customer_per_qty), 1) OVER (ORDER BY market_date DESC)
		AS previous_market_date_total_sales
	FROM customer_purchases
    GROUP BY market_date
    ORDER BY market_date;