-- AGGREGATE QUERIES: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
USE qa_demo_shop;

-- 1. Total number of users (compare with count shown on admin dashboard)
SELECT COUNT(*) AS total_users FROM users;

-- 2. Number of users in each status
SELECT status, COUNT(*) AS user_count FROM users GROUP BY status;

-- 3. Number of users in each city, highest first
SELECT city, COUNT(*) AS user_count FROM users
GROUP BY city ORDER BY user_count DESC;

-- 4. Cheapest and costliest product price
SELECT MIN(price) AS lowest_price, MAX(price) AS highest_price FROM products;

-- 5. Average product price in each category
SELECT category, ROUND(AVG(price), 2) AS avg_price FROM products GROUP BY category;

-- 6. Total sales amount of delivered orders (verify sales report)
SELECT SUM(total_amount) AS total_sales FROM orders WHERE status = 'DELIVERED';

-- 7. Number of orders in each status
SELECT status, COUNT(*) AS order_count FROM orders GROUP BY status;

-- 8. Users who placed more than one order
SELECT user_id, COUNT(*) AS order_count FROM orders
GROUP BY user_id HAVING COUNT(*) > 1;

-- 9. Total quantity sold for each product
SELECT product_id, SUM(quantity) AS qty_sold FROM order_items GROUP BY product_id;
