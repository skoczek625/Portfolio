SELECT
    friend_name,
    COUNT(resolution) AS number_of_resolution_by_made,
    SUM(is_completed) AS number_of_resolution_by_completed,
    (1.0*SUM(is_completed)/COUNT(resolution))*100 AS success_percentage,
    CASE
        WHEN (1.0*SUM(is_completed)/COUNT(resolution))*100 < 50 THEN 'Red'
        WHEN (1.0*SUM(is_completed)/COUNT(resolution))*100 >= 50 
            AND (1.0*SUM(is_completed)/COUNT(resolution))*100 <= 75 THEN 'Yellow'
        WHEN (1.0*SUM(is_completed)/COUNT(resolution))*100 >75 THEN 'Green'
    END AS success_category
FROM resolutions
GROUP BY friend_name;