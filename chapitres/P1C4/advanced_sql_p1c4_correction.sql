SELECT
    t.table_name,
    COUNT(c.column_name) AS column_count,
    s.seq_scan AS number_of_scans,
    s.n_tup_ins AS number_of_inserts
FROM
    information_schema.tables t
JOIN
    information_schema.columns c ON t.table_name = c.table_name
JOIN
    pg_stat_user_tables s ON t.table_name = s.relname
WHERE
    t.table_schema = 'public'
GROUP BY
    t.table_name, s.seq_scan, s.n_tup_ins
ORDER BY
    number_of_scans DESC;