SELECT
    sr.region,
    AVG(s.snowfall_inches) AS average_snowfall
FROM ski_resorts sr
JOIN snowfall s
    ON sr.resort_id = s.resort_id
GROUP BY sr.region
ORDER BY average_snowfall DESC;