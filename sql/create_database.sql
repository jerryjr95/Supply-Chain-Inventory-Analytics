CREATE DATABASE IF NOT EXISTS supply_chain_analytics;

USE supply_chain_analytics;

DROP TABLE IF EXISTS supply_chain_data;

CREATE TABLE supply_chain_data (
    product_type VARCHAR(50),
    sku VARCHAR(20) PRIMARY KEY,
    price DECIMAL(10,2),
    availability INT,
    products_sold INT,
    revenue DECIMAL(12,2),
    customer_demographics VARCHAR(50),
    stock_levels INT,
    supplier_lead_time INT,
    order_quantity INT,
    shipping_time INT,
    shipping_carrier VARCHAR(50),
    shipping_cost DECIMAL(10,2),
    supplier_name VARCHAR(50),
    supplier_location VARCHAR(100),
    lead_time INT,
    production_volume INT,
    manufacturing_lead_time INT,
    manufacturing_cost DECIMAL(10,2),
    inspection_result VARCHAR(30),
    defect_rate DECIMAL(8,4),
    transportation_mode VARCHAR(50),
    route VARCHAR(50),
    logistics_cost DECIMAL(10,2)
);