SELECT *
FROM market_date_info;

CREATE TABLE farmers_market.datetime_demo AS
	(
		SELECT
			market_date,
            market_start_time,
            market_end_time,
            STR_TO_DATE(CONCAT(market_date, '', market_start_time), '%Y-%m-%d%h:%i %p')
				AS market_start_datetime,
			STR_TO_DATE(CONCAT(market_date, '', market_end_time), '%Y-%m-%d%h:%i %p')
				AS market_end_datetime
		FROM farmers_market.market_date_info
	);
    
    SELECT * FROM datetime_demo;
    
    # EXTRACT
    
    SELECT
		market_start_datetime,
        EXTRACT(DAY FROM market_start_datetime) AS mktsrt_day,
        EXTRACT(MONTH FROM market_start_datetime) AS mktsrt_month,
        EXTRACT(YEAR FROM market_start_datetime) AS mktsrt_year,
        EXTRACT(HOUR FROM market_start_datetime) AS mktsrt_hour,
        EXTRACT(MINUTE FROM market_start_datetime) AS mktsrt_minute
	FROM datetime_demo
    WHERE market_start_datetime = '2019-03-02 08:00:00';
    
    SELECT
		market_start_datetime,
        DATE(market_start_datetime) AS mktsrt_date,
        TIME(market_start_datetime) AS mktsrt_time
	FROM datetime_demo
    WHERE market_start_datetime = '2019-03-02 08:00:00';
    
    #DATE_ADD AND DATE_SUB
    
    SELECT
		market_start_datetime,
        DATE_ADD(market_start_datetime, INTERVAL 30 MINUTE) AS mktstrt_date_plus_30min
	FROM datetime_demo
    WHERE market_start_datetime = '2019-03-02 08:00:00';
    
    SELECT
		market_start_datetime,
        DATE_ADD(market_start_datetime, INTERVAL 30 DAY) AS mktstrt_date_plus_30days
	FROM datetime_demo
    WHERE market_start_datetime = '2019-03-02 08:00:00';
    
    SELECT
		market_start_datetime,
        DATE_ADD(market_start_datetime, INTERVAL -30 DAY) AS mktstrt_date_plus_neg30days,
        DATE_SUB(market_start_datetime, INTERVAL 30 DAY) AS mktstrt_date_minus_30days
	FROM datetime_demo
    WHERE market_start_datetime = '2019-03-02 08:00:00';
    
    #DATEDIFF
    SELECT
		x.first_market,
        x.last_market,
        DATEDIFF(x.last_market, x.first_market) days_first_to_last
        FROM
	(
		SELECT
			min(market_start_datetime) first_market,
            max(market_start_datetime) last_market
		FROM datetime_demo
	) x;
    
    #TIMESTAMPDIFF
    SELECT
		market_start_datetime,
        market_end_datetime,
        TIMESTAMPDIFF(HOUR, market_start_datetime, market_end_datetime) 
			AS market_duration_hours,
		TIMESTAMPDIFF(MINUTE, market_start_datetime, market_end_datetime)
			AS market_duration_mins
	FROM datetime_demo;
    
    SELECT
		customer_id,
        market_date
	FROM customer_purchases
    WHERE customer_id = 1;
    
    SELECT
		customer_id,
        MIN(market_date) AS first_purchases,
        MAX(market_date) AS last_purchases,
        COUNT(DISTINCT market_date) AS count_of_purchase_dates
	FROM customer_purchases
    GROUP BY customer_id;
    
    SELECT
		customer_id,
        MIN(market_date) AS first_purchases,
        MAX(market_date) AS last_purchases,
        COUNT(DISTINCT market_date) AS count_of_purchase_dates,
        DATEDIFF(MAX(market_date), MIN(market_date)) AS days_between_first_last_purchase
	FROM customer_purchases
    GROUP BY customer_id;
    
    SELECT
		customer_id,
        MIN(market_date) AS first_purchase,
        MAX(market_date) AS last_purchase,
        COUNT(DISTINCT market_date) AS count_of_purchase_dates,
        DATEDIFF(MAX(market_date), MIN(market_date)) AS days_between_first_last_purchase,
        DATEDIFF(CURDATE(), MAX(market_date)) AS days_since_last_purchase
	FROM customer_purchases
    GROUP BY customer_id;
    
    SELECT
		customer_id,
        market_date,
        RANK() OVER (PARTITION BY customer_id ORDER BY market_date) AS purchase_number,
        LEAD(market_date, 1) OVER (PARTITION BY customer_id ORDER BY market_date)
			AS next_purchase
	FROM customer_purchases
    WHERE customer_id = 1;
    
    SELECT
		x.customer_id,
        x.market_date,
        RANK() OVER (PARTITION BY x.customer_id ORDER BY x.market_date) AS purchase_number,
        LEAD(x.market_date, 1) OVER (PARTITION BY x.customer_id ORDER BY x.market_date)
			AS next_purchase
	FROM
		(
			SELECT 
				DISTINCT customer_id,
                market_date
            FROM customer_purchases
            WHERE customer_id = 1
		) x;
        
SELECT
	x.customer_id,
    x.market_date,
    RANK() OVER (PARTITION BY x.customer_id ORDER BY x.market_date)
		AS purchase_number,
	LEAD(x.market_date, 1) OVER (PARTITION BY x.customer_id ORDER BY x.market_date)
		AS next_purchase,
	DATEDIFF(LEAD(x.market_date, 1) OVER (PARTITION BY x.customer_id ORDER BY x.market_date),
    x.market_date
    ) AS days_between_purchases
    FROM
    (
		SELECT
			DISTINCT customer_id,
            market_date
            FROM customer_purchases
            WHERE customer_id = 1
	) x;
    
SELECT
	a.customer_id,
    a.market_date AS first_purchase,
    a.next_purchase AS second_purchase,
    DATEDIFF(a.next_purchase, a.market_date) AS time_between_1st_2nd_purchase
FROM
(
	SELECT
		x.customer_id,
        x.market_date,
        RANK() OVER (PARTITION BY x.customer_id ORDER BY x.market_date)
			AS purchase_number,
		LEAD(x.market_date, 1) OVER (PARTITION BY x.customer_id ORDER BY x.market_date)
			AS next_purchase
	FROM
    (
		SELECT
			DISTINCT customer_id,
            market_date
		FROM customer_purchases
	) x
) a
WHERE a.purchase_number = 1;

SELECT
	DISTINCT customer_id,
    market_date
FROM customer_purchases
WHERE DATEDIFF('2019-03-31', market_date) <= 31;

SELECT
	x.customer_id,
    COUNT(DISTINCT x.market_date) AS market_count
FROM
(
	SELECT
		DISTINCT customer_id,
        market_date
	FROM customer_purchases
    WHERE DATEDIFF('2019-03-31', market_date) <= 31
) x
GROUP BY x.customer_id
HAVING COUNT(DISTINCT x.market_date) < 100;

# EXCERSISE 1 EXTRACT month and year from table customer purchases
SELECT
	customer_id,
    EXTRACT(MONTH FROM market_date) AS month,
    EXTRACT(YEAR FROM market_date) AS year
FROM customer_purchases;

select DATEDIFF('2023-10-19', '1994-10-29') from dual;

# EXCERSISE 2 purchases made for two weeks before last date from database

WITH x AS
(
		SELECT MAX(market_date) AS max_date
        FROM customer_purchases
)
	SELECT 
		customer_id,
		DATEDIFF(MIN(max_date), MIN(market_date)) AS two_weeks_ealier,
		MIN(market_date) AS sales_since_date,
        SUM((quantity * cost_to_customer_per_qty)) AS sum_of_purchases 
	FROM customer_purchases cp join x
	WHERE DATEDIFF(max_date, market_date) <= 14
	GROUP BY customer_id;

# EXCERSISE 3 Example check correctness of the entered data

SELECT
	market_date,
    market_day AS manual_market_day,
    DAYNAME(market_date) AS calculate_day_name,
    CASE
		WHEN market_day = DAYNAME(market_date)
        THEN 'TRUE'
        ELSE 'FALSE'
        END AS day_flag
FROM market_date_info;