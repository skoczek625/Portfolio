SELECT *
FROM farmers_market.product
LEFT JOIN farmers_market.product_category
	ON product.product_category_id = product_category.product_category_id;
    
SELECT
	product.product_id,
    product.product_name,
    product.product_category_id AS product_prod_cat_id,
    product_category.product_category_id AS category_prod_cat_id,
    product_category.product_category_name
FROM farmers_market.product
LEFT JOIN farmers_market.product_category
	ON product.product_category_id = product_category.product_category_id;
    
SELECT
	p.product_id,
    p.product_name,
    pc.product_category_id,
    pc.product_category_name
FROM farmers_market.product AS p
LEFT JOIN farmers_market.product_category AS pc
	ON p.product_category_id = pc.product_category_id
ORDER BY pc.product_category_name, p.product_name;

SELECT *
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id;
    
SELECT c.*
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE cp.customer_id IS NULL;

SELECT *
FROM farmers_market.customer AS c
RIGHT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id;
    
SELECT *
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE cp.customer_id > 0;

SELECT c.*, cp.market_date
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE cp.market_date <> '2019-03-02';

SELECT c.*, cp.market_date
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE (cp.market_date <> '2019-03-02' OR cp.market_date IS NULL);

SELECT DISTINCT c.*
FROM farmers_market.customer AS c
LEFT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
WHERE (cp.market_date <> '2019-03-02' OR cp.market_date IS NULL);

SELECT
	b.booth_number,
    b.booth_type,
    vba.market_date,
    v.vendor_id,
    v.vendor_name,
    v.vendor_type
FROM farmers_market.booth AS b
LEFT JOIN farmers_market.vendor_booth_assignments AS vba
	ON b.booth_number = vba.booth_number
LEFT JOIN farmers_market.vendor AS v
	ON v.vendor_id = vba.vendor_id
ORDER BY b.booth_number, vba.market_date;

SELECT V.*, vba.*
	FROM farmers_market.vendor AS v
    INNER JOIN farmers_market.vendor_booth_assignments AS vba
		ON v.vendor_id = vba.vendor_id
	ORDER BY v.vendor_name, vba.market_date;
    
SELECT *
FROM farmers_market.customer AS c
INNER JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id;
    
SELECT *
FROM farmers_market.vendor_inventory;

SELECT
p.product_id,
p.product_name,
pc.*,
vi.market_date,
vi.quantity
FROM farmers_market.product AS p
LEFT JOIN farmers_market.product_category AS pc
	ON p.product_category_id = pc.product_category_id
LEFT JOIN farmers_market.vendor_inventory AS vi
	ON p.product_id = vi.product_id