-- Invoice API Database Setup Script

-- Create Database
CREATE DATABASE IF NOT EXISTS invoice_db;
USE invoice_db;

-- Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Customers Table
CREATE TABLE IF NOT EXISTS customers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Invoices Table
CREATE TABLE IF NOT EXISTS invoices (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    amount DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    customer_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Insert Sample Data (Optional)
-- INSERT INTO users (username, password, role) VALUES 
-- ('miguel', '$2a$10$...', 'ADMIN');

-- INSERT INTO customers (name, email) VALUES
-- ('Acme Corporation', 'contact@acme.com'),
-- ('Tech Solutions LLC', 'info@techsol.com');

-- INSERT INTO invoices (amount, status, customer_id) VALUES
-- (1500.00, 'PENDING', 1),
-- (2500.00, 'PAID', 1),
-- (800.00, 'OVERDUE', 2);

-- Display Tables
SHOW TABLES;
