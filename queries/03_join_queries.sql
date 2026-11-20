-- JOIN QUERIES: INNER JOIN, LEFT JOIN, subquery
USE qa_demo_shop;

-- 1. Orders with customer name (verify "My Orders" / order list screen)
SELECT o.order_id, u.full_name, o.order_date, o.status, o.total_amount
FROM orders o
INNER JOIN users u ON u.user_id = o.user_id;

-- 2. Full details of one order (verify order detail page)
SELECT o.order_id, p.name AS product, oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS line_total
FROM orders o
INNER JOIN order_items oi ON oi.order_id = o.order_id
INNER JOIN products p     ON p.product_id = oi.product_id
WHERE o.order_id = 105;

-- 3. All users with number of orders, including users with no order
SELECT u.full_name, COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON o.user_id = u.user_id
GROUP BY u.user_id, u.full_name;

-- 4. Users who never placed an order
SELECT u.full_name
FROM users u
LEFT JOIN orders o ON o.user_id = u.user_id
WHERE o.order_id IS NULL;

-- 5. Products that were never ordered
SELECT p.name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.item_id IS NULL;

-- 6. Total amount spent by each customer (delivered orders only)
SELECT u.full_name, SUM(o.total_amount) AS total_spent
FROM users u
INNER JOIN orders o ON o.user_id = u.user_id
WHERE o.status = 'DELIVERED'
GROUP BY u.user_id, u.full_name
ORDER BY total_spent DESC;

-- 7. Best selling product
SELECT p.name, SUM(oi.quantity) AS qty_sold
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY qty_sold DESC
LIMIT 1;

-- 8. Products costlier than the average price (subquery)
SELECT name, price FROM products
WHERE price > (SELECT AVG(price) FROM products);
