-- Create the ecommerce database
CREATE DATABASE ecommerce;

-- Connect to the ecommerce database
\c ecommerce

-- Create the inventory table
CREATE TABLE inventory (
    product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    stock_level INT NOT NULL CHECK (stock_level BETWEEN 0 AND 1000),
    price DECIMAL(10, 2) NOT NULL CHECK (price BETWEEN 1.00 AND 500.00),
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Bulk import from CSV (run generate_inventory.py first)
COPY inventory (product_name, category, stock_level, price, last_updated) 
FROM '/docker-entrypoint-initdb.d/inventory.csv' DELIMITER ',' CSV HEADER;

-- Sample fallback data if CSV missing
INSERT INTO inventory (product_name, category, stock_level, price, last_updated) 
SELECT 
    'Sample Product ' || generate_series(1, 1000)::text,  -- Temp for testing
    CASE (random() * 4)::int % 4 
        WHEN 0 THEN 'Electronics' 
        WHEN 1 THEN 'Clothing' 
        WHEN 2 THEN 'Books' 
        ELSE 'Home' 
    END,
    (random() * 1000)::int,
    round(random() * 499.99 + 1, 2),
    CURRENT_TIMESTAMP
ON CONFLICT DO NOTHING;  -- Avoid duplicates if CSV imported

-- Enable logical replication
ALTER TABLE inventory REPLICA IDENTITY FULL;
CREATE PUBLICATION dbz_publication FOR ALL TABLES;