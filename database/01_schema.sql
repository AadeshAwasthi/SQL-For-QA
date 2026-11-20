-- Demo e-commerce database for SQL practice (MySQL)
-- This is sample data created for portfolio purposes. It is not from any real application.

CREATE DATABASE IF NOT EXISTS qa_demo_shop;
USE qa_demo_shop;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id     INT PRIMARY KEY AUTO_INCREMENT,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100),
    city        VARCHAR(50),
    status      VARCHAR(20) DEFAULT 'ACTIVE',   -- ACTIVE, INACTIVE, LOCKED
    created_at  DATE NOT NULL
);

CREATE TABLE products (
    product_id  INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    category    VARCHAR(50),
    price       DECIMAL(10,2) NOT NULL,
    stock_qty   INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY AUTO_INCREMENT,
    user_id      INT,
    order_date   DATE NOT NULL,
    status       VARCHAR(20) NOT NULL,           -- PLACED, SHIPPED, DELIVERED, CANCELLED
    total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_items (
    item_id     INT PRIMARY KEY AUTO_INCREMENT,
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL
);
