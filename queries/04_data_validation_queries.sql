-- DATA VALIDATION QUERIES
-- These are the checks a QA engineer runs to find bad data in the database.
-- Each query should return ZERO rows on clean data.
-- The sample data in this repository has a few wrong rows added on purpose:
-- queries marked with "Finds:" return that faulty row, the other queries return zero rows.
USE qa_demo_shop;

-- 1. Duplicate emails (email must be unique)
--    Finds: priya.verma@example.com used by 2 users
SELECT email, COUNT(*) AS times_used FROM users
WHERE email IS NOT NULL
GROUP BY email HAVING COUNT(*) > 1;

-- 2. Mandatory field is empty
--    Finds: Rohit Jain has no email
SELECT user_id, full_name FROM users
WHERE email IS NULL OR TRIM(email) = '';

-- 3. Invalid email format
SELECT user_id, email FROM users
WHERE email IS NOT NULL AND email NOT LIKE '%_@_%._%';

-- 4. Negative stock or price
--    Finds: Red T-Shirt has stock -5
SELECT product_id, name, price, stock_qty FROM products
WHERE stock_qty < 0 OR price <= 0;

-- 5. Orphan records: order belongs to a user that does not exist
--    Finds: order 107 with user_id 99
SELECT o.order_id, o.user_id FROM orders o
LEFT JOIN users u ON u.user_id = o.user_id
WHERE u.user_id IS NULL;

-- 6. Order total does not match the sum of its items
--    Finds: order 106 (total 99.99, items 99.98)
SELECT o.order_id, o.total_amount, SUM(oi.quantity * oi.unit_price) AS items_total
FROM orders o
INNER JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.unit_price);

-- 7. Orders without any item
SELECT o.order_id FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
WHERE oi.item_id IS NULL;

-- 8. Item price in the order is different from the product price
SELECT oi.item_id, p.name, oi.unit_price, p.price
FROM order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
WHERE oi.unit_price <> p.price;

-- 9. Invalid status value
SELECT order_id, status FROM orders
WHERE status NOT IN ('PLACED', 'SHIPPED', 'DELIVERED', 'CANCELLED');

-- 10. Orders with a future date
SELECT order_id, order_date FROM orders WHERE order_date > CURRENT_DATE;
