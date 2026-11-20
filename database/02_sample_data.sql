-- Sample data. Some rows are wrong ON PURPOSE (duplicate email, missing email,
-- negative stock, order without user, wrong order total) so that the
-- data validation queries have something to find.

USE qa_demo_shop;

INSERT INTO users (user_id, full_name, email, city, status, created_at) VALUES
(1, 'Rahul Sharma',  'rahul.sharma@example.com',  'Indore',  'ACTIVE',   '2026-01-10'),
(2, 'Priya Verma',   'priya.verma@example.com',   'Bhopal',  'ACTIVE',   '2026-01-15'),
(3, 'Amit Patel',    'amit.patel@example.com',    'Indore',  'INACTIVE', '2026-02-01'),
(4, 'Sneha Joshi',   'sneha.joshi@example.com',   'Pune',    'ACTIVE',   '2026-02-20'),
(5, 'Vikram Singh',  'vikram.singh@example.com',  'Mumbai',  'LOCKED',   '2026-03-05'),
(6, 'Neha Gupta',    'priya.verma@example.com',   'Indore',  'ACTIVE',   '2026-03-18'),  -- duplicate email
(7, 'Rohit Jain',    NULL,                        'Ujjain',  'ACTIVE',   '2026-04-02'),  -- missing email
(8, 'Kavita Mishra', 'kavita.mishra@example.com', 'Delhi',   'ACTIVE',   '2026-04-25');

INSERT INTO products (product_id, name, category, price, stock_qty) VALUES
(1, 'Backpack',        'Bags',        29.99, 50),
(2, 'Bike Light',      'Accessories',  9.99, 120),
(3, 'Bolt T-Shirt',    'Clothing',    15.99, 0),
(4, 'Fleece Jacket',   'Clothing',    49.99, 15),
(5, 'Onesie',          'Clothing',     7.99, 200),
(6, 'Red T-Shirt',     'Clothing',    15.99, -5),   -- negative stock
(7, 'Water Bottle',    'Accessories', 12.50, 80);   -- never ordered

INSERT INTO orders (order_id, user_id, order_date, status, total_amount) VALUES
(101, 1, '2026-05-01', 'DELIVERED',  39.98),
(102, 2, '2026-05-03', 'DELIVERED',  49.99),
(103, 1, '2026-05-10', 'SHIPPED',    23.98),
(104, 4, '2026-05-12', 'CANCELLED',  15.99),
(105, 2, '2026-05-20', 'PLACED',     67.97),
(106, 8, '2026-06-01', 'DELIVERED',  99.99),   -- wrong total, items add up to 99.98
(107, 99, '2026-06-05', 'PLACED',     9.99),   -- user 99 does not exist
(108, 4, '2026-06-10', 'DELIVERED',  29.99);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 101, 1, 1, 29.99),
(2, 101, 2, 1,  9.99),
(3, 102, 4, 1, 49.99),
(4, 103, 5, 1,  7.99),
(5, 103, 3, 1, 15.99),
(6, 104, 6, 1, 15.99),
(7, 105, 1, 2, 29.99),
(8, 105, 5, 1,  7.99),
(9, 106, 4, 2, 49.99),
(10, 107, 2, 1, 9.99),
(11, 108, 1, 1, 29.99);
