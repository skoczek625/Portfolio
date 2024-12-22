SELECT * 
FROM farmers_market.product
LIMIT 5;

SELECT product_id, product_name
FROM farmers_market.product
LIMIT 5;

SELECT market_date, vendor_id, booth_number
FROM farmers_market.vendor_booth_assignments
LIMIT 5;

SELECT product_id, product_name
FROM farmers_market.product
ORDER BY product_name
LIMIT 5;

SELECT product_id, product_name
FROM farmers_market.product
ORDER BY product_id DESC
LIMIT 5;

SELECT market_date, vendor_id, booth_number
FROM farmers_market.vendor_booth_assignments
ORDER BY market_date, vendor_id DESC
LIMIT 5;

SELECT 
	market_date,
    customer_id,
    vendor_id,
    quantity,
    cost_to_customer_per_qty
FROM farmers_market.customer_purchases
LIMIT 10;

SELECT 
	market_date,
    customer_id,
    vendor_id,
    quantity,
    cost_to_customer_per_qty,
    round (quantity * cost_to_customer_per_qty, 2) AS price
    FROM farmers_market.customer_purchases
    LIMIT 10;
    
    SELECT *
    FROM farmers_market.customer
    LIMIT 5;
    
    SELECT 
    customer_id,
    CONCAT(customer_first_name, " ", customer_last_name) AS customer_name
    FROM farmers_market.customer
    limit 5;
    
    SELECT
		customer_id,
        CONCAT(customer_first_name, " ", customer_last_name) AS customer_name
        FROM farmers_market.customer
        ORDER BY customer_last_name, customer_first_name
        limit 5;
        
        SELECT
        customer_id,
        UPPER(CONCAT(customer_last_name, ",", customer_first_name)) AS customer_name
        FROM farmers_market.customer
        ORDER BY customer_last_name, customer_first_name
        LIMIT 5;
        
        SELECT
			market_date,
			customer_id,
            vendor_id,
		ROUND(quantity * cost_to_customer_per_qty, 2) AS price
        FROM farmers_market.customer_purchases;
        
        SELECT * FROM farmers_market.vendor;
        
        SELECT 
			vendor_name,
            vendor_id,
            vendor_type
		FROM farmers_market.vendor
        ORDER BY vendor_name;
        
        SELECT *
        FROM farmers_market.customer;
        
        SELECT *
        FROM farmers_market.customer
        ORDER BY customer_last_name, customer_first_name
        LIMIT 10;
        
        SELECT customer_id, customer_first_name
        FROM farmers_market.customer
        ORDER BY customer_first_name;