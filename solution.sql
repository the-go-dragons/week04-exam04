-- Section1
CREATE INDEX idx_orders_created_at ON orders (created_at,total);
SELECT SUM(total)
FROM orders
WHERE created_at BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59';

-- alter table orders drop index idx_orders_created_at;

-- Section2
create index idx_orders_user on orders (user_id,created_at,total);
SELECT SUM(total)
FROM orders
WHERE created_at BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59'
AND user_id = 345

-- Section3
