-- Section1
CREATE INDEX idx_orders_created_at ON orders (created_at,total);
SELECT SUM(total)
FROM orders
WHERE created_at BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59';

-- Section2
create index idx_orders_user on orders (user_id,created_at,total);
SELECT SUM(total)
FROM orders
WHERE created_at BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59'
AND user_id = 345;

-- Section3
WITH RECURSIVE cte AS (
    SELECT MIN(DATE(created_at)) AS date
    FROM orders
    UNION ALL
    SELECT DATE_ADD(cte.date, INTERVAL 1 DAY)
    FROM cte
    WHERE DATE_ADD(cte.date, INTERVAL 1 DAY) <= (SELECT MAX(created_at) FROM orders)
)
SELECT DATE(cte.date) AS date,
       SUM(IFNULL(orders.total, 0)) AS total_value
FROM cte
LEFT JOIN (
    SELECT DATE(created_at) AS order_date, total AS total
    FROM orders
) AS orders ON cte.date = orders.order_date
GROUP BY cte.date
ORDER BY cte.date ASC;
