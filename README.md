# SQL for QA Engineers

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?logo=mysql&logoColor=white) ![Level](https://img.shields.io/badge/Level-Basic-green) ![Status](https://img.shields.io/badge/Project-Demo-orange)

SQL queries that a QA engineer uses in day-to-day testing: checking that data from the UI is saved correctly, finding bad data, and preparing test data. Written by **Aadesh Awasthi**.

> **Note:** This is a **demo project**. The database is a small sample e-commerce schema created for practice. It does not contain data from any real application or company.

## Why SQL is Useful for a Tester

- Verify that data entered on the UI is saved correctly in the database (backend testing)
- Compare counts and totals shown in reports with the actual data
- Find invalid data: duplicates, missing values, orphan records
- Create and clean up test data

## Database Design

```
users (user_id, full_name, email, city, status, created_at)
   │
   └──< orders (order_id, user_id, order_date, status, total_amount)
            │
            └──< order_items (item_id, order_id, product_id, quantity, unit_price) >── products (product_id, name, category, price, stock_qty)
```

## Files

| File | Content | Queries |
|---|---|---|
| [database/01_schema.sql](database/01_schema.sql) | Create tables | - |
| [database/02_sample_data.sql](database/02_sample_data.sql) | Sample data, with a few wrong rows added on purpose | - |
| [queries/01_basic_queries.sql](queries/01_basic_queries.sql) | SELECT, WHERE, ORDER BY, LIKE, IN, BETWEEN | 13 |
| [queries/02_aggregate_queries.sql](queries/02_aggregate_queries.sql) | COUNT, SUM, AVG, GROUP BY, HAVING | 9 |
| [queries/03_join_queries.sql](queries/03_join_queries.sql) | INNER JOIN, LEFT JOIN, subquery | 8 |
| [queries/04_data_validation_queries.sql](queries/04_data_validation_queries.sql) | Duplicate, NULL, orphan and mismatch checks | 10 |
| [queries/05_test_data_queries.sql](queries/05_test_data_queries.sql) | INSERT, UPDATE, DELETE for test data | 6 |

## How to Use

1. Install MySQL (or use any online MySQL editor).
2. Run `database/01_schema.sql` to create the tables.
3. Run `database/02_sample_data.sql` to insert the data.
4. Run the queries from the `queries` folder one by one and check the result.

All 46 queries are tested on MariaDB 10.11 (MySQL compatible) and run without errors.

## Example: Finding a Data Bug with SQL

**Check:** the order total must be equal to the sum of its items.

```sql
SELECT o.order_id, o.total_amount, SUM(oi.quantity * oi.unit_price) AS items_total
FROM orders o
INNER JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.unit_price);
```

**Result:**

| order_id | total_amount | items_total |
|---|---|---|
| 106 | 99.99 | 99.98 |

Order 106 has a wrong total, so it is reported as a bug.
