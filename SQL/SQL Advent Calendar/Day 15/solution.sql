SELECT
    fm.name,
    COUNT(pcr.child_id) AS total_number_of_children
FROM family_members fm
    JOIN parent_child_relationships pcr
    ON fm.member_id = pcr.parent_id
GROUP BY fm.member_id
ORDER BY total_number_of_children DESC
LIMIT 3;