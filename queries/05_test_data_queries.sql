-- TEST DATA SETUP AND CLEANUP: INSERT, UPDATE, DELETE
-- Always use a WHERE clause with UPDATE and DELETE, and run these only on a test database.
USE qa_demo_shop;

-- 1. Create a test user
INSERT INTO users (full_name, email, city, status, created_at)
VALUES ('QA Test User', 'qa.test.user@example.com', 'Indore', 'ACTIVE', CURRENT_DATE);

-- 2. Lock the test user (to test the "locked user" login message)
UPDATE users SET status = 'LOCKED' WHERE email = 'qa.test.user@example.com';

-- 3. Make a product out of stock (to test the "Out of stock" label)
UPDATE products SET stock_qty = 0 WHERE product_id = 2;

-- 4. Verify the change before testing on the UI
SELECT name, stock_qty FROM products WHERE product_id = 2;

-- 5. Restore the data after the test
UPDATE products SET stock_qty = 120 WHERE product_id = 2;

-- 6. Remove the test user after the test
DELETE FROM users WHERE email = 'qa.test.user@example.com';
