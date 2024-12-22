SELECT
	vendor_id,
    vendor_name,
    vendor_type,
	CASE 
		WHEN LOWER(vendor_type) LIKE '%fresh%'
		THEN 'Świeże'
			ELSE 'Inne'
	END
    AS vendor_type_condensed
FROM farmers_market.vendor;

SELECT
	market_date,
    market_day
FROM farmers_market.market_date_info
LIMIT 5;

SELECT
	market_date,
    market_day,
	CASE
		WHEN market_day = 'Saturday' OR market_day = 'Sunday'
        THEN 1
        ELSE 0
	END
    AS weekend_flag
FROM farmers_market.market_date_info
LIMIT 5;

SELECT
	market_date,
    customer_id,
    vendor_id,
    ROUND(quantity * cost_to_customer_per_qty, 2) AS price,
    CASE
		WHEN quantity * cost_to_customer_per_qty > 50
			THEN 1
            ELSE 0
	END
    AS price_over_50
FROM farmers_market.customer_purchases
ORDER BY price DESC
LIMIT 20;

SELECT
	market_date,
    customer_id,
    vendor_id,
    ROUND(quantity * cost_to_customer_per_qty, 2) AS price,
    CASE
		WHEN quantity * cost_to_customer_per_qty < 5.00
			THEN 'Poniżej 5$'
		WHEN quantity * cost_to_customer_per_qty < 10.00
			THEN '5$-9,99$'
		WHEN quantity * cost_to_customer_per_qty < 20.00
			THEN '10$-19.99$'
		ELSE '20$ i więcej'
	END 
    AS price_bin
FROM farmers_market.customer_purchases
LIMIT 20;

SELECT
	booth_number,
    booth_price_level,
    CASE
		WHEN booth_price_level = 'A' THEN 1
        WHEN booth_price_level = 'B' THEN 2
        WHEN booth_price_level = 'C' THEN 3
	END
    AS booth_price_level_numeric
FROM farmers_market.booth
ORDER BY booth_price_level_numeric;

SELECT
	vendor_id,
    vendor_name,
    vendor_type,
    CASE
		WHEN vendor_type = 'Arts & Jewelry'
        THEN 1 ELSE 0
	END AS vendor_type_arts_jewerly,
    CASE
		WHEN vendor_type = 'Eggs & Meats'
        THEN 1 ELSE 0
	END AS vendor_type_eggs_meats,
    CASE
		WHEN vendor_type = 'Fresh Focused'
        THEN 1 ELSE 0
	END AS vendor_type_fresh_focused,
    CASE
		WHEN vendor_type = 'Fresh Variety: Veggies & More'
        THEN 1 ELSE 0
	END AS vendor_type_fresh_variety,
    CASE
		WHEN vendor_type = 'Prepared Foods'
        THEN 1 ELSE 0
	END AS vendor_type_prepared_food
FROM farmers_market.vendor;

SELECT
	customer_id,
    CASE
		WHEN customer_zip = '22801'
        THEN 'Lokalny'
        ELSE 'Nielokalny'
	END AS customer_location_type
FROM farmers_market.customer
ORDER BY customer_location_type;

SELECT
	booth_number,
    CASE
		WHEN booth_price_level = 'A'
        THEN 1 ELSE 0
	END AS booth_price_level_A,
    CASE
		WHEN booth_price_level = 'B'
        THEN 1 ELSE 0
	END AS booth_price_level_B,
    CASE
		WHEN booth_price_level = 'C'
        THEN 1 ELSE 0
	END AS booth_price_level_C
FROM farmers_market.booth;

SELECT
	product_id,
    product_name,
    CASE
		WHEN product_qty_type = 'Unit'
        THEN 'na sztuki'
        ELSE 'luzem'
	END
    AS prod_qty_type_condensed
FROM farmers_market.product;

SELECT
	product_id,
    product_name,
    product_qty_type,
    CASE
		WHEN product_qty_type = 'Unit'
        THEN 'na sztuki'
        ELSE 'luzem'
	END AS prod_qty_type,
	CASE
		WHEN LOWER(product_name) LIKE ('%pepper%')
        THEN 1 ELSE 0
	END AS pepper_flag
FROM farmers_market.product;