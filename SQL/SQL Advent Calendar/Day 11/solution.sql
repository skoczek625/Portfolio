SELECT
    name,
    birthday
FROM family_members
WHERE
    STRFTIME('%m', birthday) = '12' AND
    STRFTIME('%Y', birthday) = '2024'
ORDER BY name;