-- BASIC QUERIES: SELECT, WHERE, ORDER BY, LIKE, IN, BETWEEN, LIMIT
USE qa_demo_shop;

-- 1. See all users
SELECT * FROM users;

-- 2. See only selected columns
SELECT full_name, email, city FROM users;

-- 3. Verify a user created from the UI is saved in the database
SELECT * FROM users WHERE email = 'rahul.sharma@example.com';

-- 4. All active users from Indore
SELECT full_name, city, status FROM users
WHERE status = 'ACTIVE' AND city = 'Indore';

-- 5. Users who are inactive or locked
SELECT full_name, status FROM users
WHERE status IN ('INACTIVE', 'LOCKED');

-- 6. Search users by name (same as a search box test)
SELECT full_name FROM users WHERE full_name LIKE '%sh%';

-- 7. Products sorted by price, high to low (verify sort feature of UI)
SELECT name, price FROM products ORDER BY price DESC;

-- 8. Products with price between 10 and 30
SELECT name, price FROM products WHERE price BETWEEN 10 AND 30;

-- 9. Out of stock products
SELECT name, stock_qty FROM products WHERE stock_qty = 0;

-- 10. Latest 3 orders
SELECT * FROM orders ORDER BY order_date DESC LIMIT 3;

-- 11. Orders placed in May 2026
SELECT order_id, order_date, status FROM orders
WHERE order_date BETWEEN '2026-05-01' AND '2026-05-31';

-- 12. Different cities of users (no repeat)
SELECT DISTINCT city FROM users;

-- 13. Users without email
SELECT full_name FROM users WHERE email IS NULL;
