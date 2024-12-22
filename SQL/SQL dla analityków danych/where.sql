SELECT
	product_id,
    product_name,
    product_category_id
FROM farmers_market.product
WHERE
	product_category_id = 1
    LIMIT 5;
    
    SELECT 
		market_date,
        customer_id,
        vendor_id,
        product_id,
        quantity,
        ROUND(quantity * cost_to_customer_per_qty, 2) AS price
	FROM farmers_market.customer_purchases
    WHERE customer_id = 4
    ORDER BY market_date, vendor_id, product_id
    LIMIT 5;
    
    SELECT
		market_date,
        customer_id,
        vendor_id,
        product_id,
        quantity,
        ROUND(quantity * cost_to_customer_per_qty, 2) AS price
        FROM farmers_market.customer_purchases
        WHERE customer_id = 3
			OR customer_id =4
		ORDER BY market_date, customer_id, vendor_id, product_id;
    
    SELECT
		market_date,
        customer_id,
        vendor_id,
        product_id,
        quantity,
        ROUND(quantity * cost_to_customer_per_qty, 2) AS price
        FROM farmers_market.customer_purchases
        WHERE customer_id > 3
			AND customer_id <= 5
		ORDER BY market_date, customer_id, vendor_id, product_id
        LIMIT 10; 
        
        SELECT
        product_id,
        product_name
        FROM farmers_market.product
        WHERE
			product_id = 10
            OR (product_id > 3
				AND product_id < 8);

SELECT
		product_id,
        product_name
	FROM farmers_market.product
    WHERE 
		(product_id = 10
        OR product_id > 3)
        AND product_id < 8;
        
        SELECT
			market_date,
            customer_id,
            vendor_id,
            ROUND(quantity * cost_to_customer_per_qty, 2) AS price
            FROM farmers_market.customer_purchases
            WHERE 
				customer_id = 4
                AND vendor_id = 7
			ORDER BY market_date, price
            LIMIT 20;
            
            SELECT
				customer_id,
                customer_first_name,
                customer_last_name
			FROM farmers_market.customer
            WHERE customer_first_name = 'Carlos'
				OR customer_last_name = 'Diaz';
                
                SELECT *
                FROM farmers_market.vendor_booth_assignments
                WHERE vendor_id = 9
					AND market_date <= '2019-05-09' 
				ORDER BY market_date;
                
                SELECT *
                FROM farmers_market.vendor_booth_assignments
                WHERE vendor_id = 9
					AND market_date BETWEEN '2019-05-04' and '2019-05-15'
				ORDER BY market_date;
                
SELECT
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE
	customer_last_name = 'Diaz'
    OR customer_last_name = 'Edwards'
    OR customer_last_name = 'Wilson'
ORDER BY customer_last_name, customer_first_name;

SELECT
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE
	customer_last_name IN ('Diaz', 'Edwards', 'Wilson')
ORDER BY customer_last_name, customer_first_name;

SELECT
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE
	customer_first_name IN ('Renee', 'Rene', 'Renne', 'Reennee');
    
SELECT
	customer_id,
    customer_first_name,
    customer_last_name
FROM farmers_market.customer
WHERE
	customer_first_name LIKE 'Jer%';
    
    SELECT *
    FROM farmers_market.product
    WHERE
		product_size IS NULL ;
        
SELECT *
FROM farmers_market.product
WHERE
	product_size IS NULL
    OR TRIM(product_size) = '';
    
SELECT
	market_date,
    transaction_time,
    customer_id,
    vendor_id,
    quantity
FROM farmers_market.customer_purchases
WHERE
	customer_id = 1
    AND vendor_id = 7
    AND quantity > 1
ORDER BY market_date, transaction_time
LIMIT 20;

SELECT
	market_date,
    transaction_time,
    customer_id,
    vendor_id,
    quantity
FROM farmers_market.customer_purchases
WHERE
	customer_id = 1
    AND vendor_id = 7
    AND quantity <= 1;
    
SELECT
	market_date,
    transaction_time,
    customer_id,
    vendor_id,
    quantity
FROM farmers_market.customer_purchases
WHERE
	customer_id = 1
    AND vendor_id = 7;
    
    SELECT
		market_date,
        market_rain_flag
	FROM farmers_market.market_date_info
    WHERE
		market_rain_flag = 1;
        
SELECT
	market_date,
    customer_id,
    vendor_id,
    ROUND(quantity * cost_to_customer_per_qty,2) AS price
FROM farmers_market.customer_purchases
WHERE
	market_date IN 
		(
			SELECT market_date
            FROM farmers_market.market_date_info
            WHERE market_rain_flag = 1
		)
	LIMIT 10;
    
    SELECT
		product_id,
        product_name,
        product_category_id
	FROM farmers_market.product
    WHERE
		product_id IN (4, 9);
        
SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id > 7
	AND vendor_id <= 10;
    
SELECT *
FROM farmers_market.customer_purchases
WHERE vendor_id BETWEEN 8 AND 10;

SELECT market_date, market_rain_flag
FROM farmers_market.market_date_info
WHERE market_rain_flag = 0;

SELECT market_date, market_rain_flag
FROM farmers_market.market_date_info
WHERE NOT market_rain_flag = 1;