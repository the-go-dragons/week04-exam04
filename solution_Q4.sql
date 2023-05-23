-- Section1
CREATE INDEX date_int ON orders(created_at, total);

-- Section2
CREATE INDEX user_id_created_at_total_indx ON orders(user_id, created_at, total);

-- Section3
WITH RECURSIVE dates (created_at) AS (
    SELECT
        DATE(MIN(created_at))
    FROM
        orders
    UNION
    ALL
    SELECT
        created_at + INTERVAL 1 DAY
    FROM
        dates
    WHERE
        created_at + INTERVAL 1 DAY <= (
            SELECT
                MAX(created_at)
            FROM
                orders
        )
)
SELECT
    dates.created_at,
    COALESCE(SUM(total), 0) AS total
FROM
    dates
    LEFT JOIN (
        SELECT
            total,
            DATE(created_at) AS created_at
        FROM
            orders
    ) o ON dates.created_at = o.created_at
GROUP BY
    dates.created_at
ORDER BY
    dates.created_at;
