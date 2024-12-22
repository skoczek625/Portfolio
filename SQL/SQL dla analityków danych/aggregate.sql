# SELECT DISTINCT
SELECT
	market_date,
    customer_id
FROM farmers_market.customer_purchases
ORDER BY market_date, customer_id;

SELECT
	market_date,
    customer_id
FROM farmers_market.customer_purchases
GROUP BY 1, 2
ORDER BY market_date, customer_id;

SELECT
	market_date,
    customer_id,
    COUNT(*) AS items_purchased
FROM farmers_market.customer_purchases
GROUP BY  market_date, customer_id
ORDER BY market_date, customer_id
LIMIT 10;


SELECT *
FROM farmers_market.customer_purchases;


SELECT
	market_date,
    customer_id,
    SUM(quantity) AS items_purchased
FROM farmers_market.customer_purchases
GROUP BY market_date, customer_id
ORDER BY market_date, customer_id;

SELECT
	market_date,
    customer_id,
    COUNT(distinct product_id) AS different_products_purchased
FROM farmers_market.customer_purchases c 
GROUP BY market_date, customer_id
ORDER BY market_date, customer_id;

SELECT
	market_date,
    customer_id,
    SUM(quantity) AS items_purchases,
    COUNT(DISTINCT product_id) AS different_products_purchases
FROM farmers_market.customer_purchases
GROUP BY market_date, customer_id
ORDER BY market_date, customer_id;

SELECT
	market_date,
    customer_id,
    vendor_id,
    quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE customer_id = 3
ORDER BY market_date, vendor_id;

SELECT
	customer_id,
    market_date,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM farmers_market.customer_purchases
WHERE customer_id = 3
GROUP BY market_date
ORDER BY market_date;

SELECT
	customer_id,
    vendor_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM farmers_market.customer_purchases
WHERE customer_id = 3
GROUP BY customer_id, vendor_id
ORDER BY customer_id, vendor_id;

SELECT
	customer_id,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM farmers_market.customer_purchases
GROUP BY customer_id
ORDER BY customer_id;

SELECT
	c.customer_first_name,
    c.customer_last_name,
    cp.customer_id,
    v.vendor_name,
    cp.vendor_id,
    cp.quantity * cp.cost_to_customer_per_qty AS price
FROM farmers_market.customer c
	LEFT JOIN farmers_market.customer_purchases cp
		ON c.customer_id = cp.customer_id
	LEFT JOIN farmers_market.vendor v
		ON cp.vendor_id = v.vendor_id
	WHERE cp.customer_id = 3
    ORDER BY cp.customer_id, cp.vendor_id;
    
    SELECT
		c.customer_first_name,
        c.customer_last_name,
        cp.customer_id,
        v.vendor_id,
        ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS total_spent
	FROM farmers_market.customer c
    LEFT JOIN farmers_market.customer_purchases cp
		ON c.customer_id = cp.customer_id
	LEFT JOIN farmers_market.vendor v
		ON cp.vendor_id = v.vendor_id
	WHERE cp.customer_id = 3
    GROUP BY c.customer_first_name, 
			 c.customer_last_name,
             cp.customer_id,
             v.vendor_name,
             cp.vendor_id
	ORDER BY cp.customer_id, cp.vendor_id;
    
    SELECT
		c.customer_first_name,
        c.customer_last_name,
        cp.customer_id,
        v.vendor_id,
        ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS total_spent
	FROM farmers_market.customer c
    LEFT JOIN farmers_market.customer_purchases cp
		ON c.customer_id = cp.customer_id
	LEFT JOIN farmers_market.vendor v
		ON cp.vendor_id = v.vendor_id
	WHERE cp.vendor_id = 7
    GROUP BY c.customer_first_name, 
			 c.customer_last_name,
             cp.customer_id,
             v.vendor_name,
             cp.vendor_id
	ORDER BY cp.customer_id, cp.vendor_id;
    
    SELECT
		c.customer_first_name,
        c.customer_last_name,
        cp.customer_id,
        v.vendor_id,
        ROUND(SUM(quantity * cost_to_customer_per_qty), 2) AS total_spent
	FROM farmers_market.customer c
    LEFT JOIN farmers_market.customer_purchases cp
		ON c.customer_id = cp.customer_id
	LEFT JOIN farmers_market.vendor v
		ON cp.vendor_id = v.vendor_id
    GROUP BY c.customer_first_name, 
			 c.customer_last_name,
             cp.customer_id,
             v.vendor_name,
             cp.vendor_id
	ORDER BY cp.customer_id, cp.vendor_id;
    
    SELECT *
    FROM farmers_market.vendor_inventory
    ORDER BY original_price;
    
    # select min and max price from vendor inventory
    SELECT
		MIN(original_price) AS minimum_price,
        MAX(original_price) AS maximum_price
	FROM farmers_market.vendor_inventory
    ORDER BY original_price;
    
    SELECT
		pc.product_category_name,
        p.product_category_id,
        MIN(vi.original_price) AS minimum_price,
        MAX(vi.original_price) AS maximum_price
	FROM farmers_market.vendor_inventory vi
		INNER JOIN farmers_market.product p
			ON vi.product_id = p.product_id
		INNER JOIN farmers_market.product_category pc
			ON p.product_category_id = pc.product_category_id
	GROUP BY pc.product_category_name, p.product_category_id;
    
    #show product category ids for products in vendor inventory
    SELECT DISTINCT p.product_category_id 
    FROM farmers_market.vendor_inventory vi
		JOIN farmers_market.product p
			ON vi.product_id = p.product_id;
            
    #count products in vendor inventory by product category
    SELECT pc.product_category_name as category_name, count(vi.product_id) as products_quantity
    FROM farmers_market.product p
		LEFT JOIN farmers_market.vendor_inventory vi
			ON vi.product_id = p.product_id
		RIGHT JOIN farmers_market.product_category pc
			ON p.product_category_id = pc.product_category_id
	GROUP BY pc.product_category_name;
    
    #count product sales by day
    SELECT
		market_date,
        COUNT(product_id) AS product_count
	FROM farmers_market.vendor_inventory
    GROUP BY market_date
    ORDER BY market_date;
    
    # count distinct products in vendor between two date
    SELECT
		vendor_id,
        COUNT(DISTINCT product_id) AS different_products_offered
	FROM farmers_market.vendor_inventory
    WHERE market_date BETWEEN '2019-05-02' AND '2019-12-16'
    GROUP BY vendor_id
    ORDER BY vendor_id;
    
    # average original price?
    SELECT
		vendor_id,
        COUNT(DISTINCT product_id) AS different_products_offered,
        AVG(original_price) AS average_product_price
	FROM farmers_market.vendor_inventory
    WHERE market_date BETWEEN '2019-05-02' AND '2019-12-16'
	GROUP BY vendor_id
    ORDER BY vendor_id;
    
    SELECT
		vendor_id,
        COUNT(DISTINCT product_id) AS different_products_offered,
        SUM(quantity * original_price) AS value_of_inventory,
        SUM(quantity) AS inventory_item_count,
        ROUND(SUM(quantity * original_price) / SUM(quantity), 2) AS average_item_price
        FROM farmers_market.vendor_inventory
         WHERE market_date BETWEEN '2019-05-02' AND '2019-12-16'
	GROUP BY vendor_id
    ORDER BY vendor_id;
    
     SELECT
		vendor_id,
        COUNT(DISTINCT product_id) AS different_products_offered,
        SUM(quantity * original_price) AS value_of_inventory,
        SUM(quantity) AS inventory_item_count,
        ROUND(SUM(quantity * original_price) / SUM(quantity), 2) AS average_item_price
FROM farmers_market.vendor_inventory
	WHERE market_date BETWEEN '2019-05-02' AND '2019-12-16'
	GROUP BY vendor_id
    HAVING inventory_item_count >= 100
    ORDER BY vendor_id;
    
    SELECT
		cp.market_date,
        cp.vendor_id,
        cp.customer_id,
        cp.product_id,
        cp.quantity,
        p.product_name,
        p.product_size,
        p.product_qty_type
	FROM farmers_market.customer_purchases cp
		INNER JOIN farmers_market.product p 
			ON cp.product_id = p.product_id;
            
SELECT
	cp.market_date,
    cp.vendor_id,
    cp.customer_id,
    cp.product_id,
    CASE WHEN product_qty_type = "unit" THEN quantity ELSE 0 END AS quantity_units,
	CASE WHEN product_qty_type = "lbs" THEN quantity ELSE 0 END AS quantity_lbs,
	CASE WHEN product_qty_type NOT IN ("unit", "lbs") THEN quantity ELSE 0 END AS quantity_other,
	p.product_qty_type
FROM farmers_market.customer_purchases cp
	INNER JOIN farmers_market.product p
		ON cp.product_id = p.product_id;
        
# sum by product_qty type
SELECT
	cp.market_date,
    cp.customer_id,
    SUM(CASE WHEN product_qty_type = "unit" THEN quantity ELSE 0 END) AS qty_units_purchased,
    SUM(CASE WHEN product_qty_type = "lbs" THEN quantity ELSE 0 END) AS qty_lbs_purchased,
    SUM(CASE WHEN product_qty_type NOT IN ("unit", "lbs") THEN quantity ELSE 0 END) AS qty_other_purchased
FROM farmers_market.customer_purchases cp
	INNER JOIN farmers_market.product p
		ON cp.product_id = p.product_id
GROUP BY market_date, customer_id
ORDER BY market_date, customer_id;

SELECT *
FROM farmers_market.vendor_booth_assignments;

# EXCERSISE 1 count booth quantity by vendor
SELECT
	vendor_id,
    COUNT(booth_number) AS booth_quantity
FROM farmers_market.vendor_booth_assignments  
GROUP BY vendor_id
ORDER BY vendor_id;

# EXCERSISE 2 first and end day availability of products from Fresh Fruits & Vegetables category
show tables;
SELECT
	pc.product_category_name,
	p.product_name,
    MIN(vi.market_date) AS first_day_available,
    MAX(vi.market_date) AS last_day_available
FROM vendor_inventory vi
	JOIN product p
		ON vi.product_id = p.product_id
	JOIN product_category pc
		ON p.product_category_id = pc.product_category_id
WHERE pc.product_category_name = "Fresh Fruits & Vegetables"
GROUP BY vi.product_id, p.product_category_id;

SELECT *
FROM product_category;

# EXCERSISE 3 check which client spend more than 100 dollar whenever in market and sort them by last name and first name
SELECT *
FROM customer_purchases;

SELECT
	c.customer_first_name,
    c.customer_last_name,
    MAX(cp.quantity * cp.cost_to_customer_per_qty) AS spend_money
FROM customer c
	JOIN customer_purchases cp
		ON c.customer_id = cp.customer_id
	GROUP BY c.customer_first_name, c.customer_last_name
    HAVING spend_money > 100 
    ORDER BY c.customer_last_name, c.customer_first_name;