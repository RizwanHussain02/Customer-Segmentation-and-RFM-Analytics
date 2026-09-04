-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 02 - CREATE DIMENSION TABLES
-- ============================================================

-- Customer Dimension
CREATE TABLE warehouse.dim_customer(
	customer_key SERIAL PRIMARY KEY,
	customer_id INTEGER NOT NULL, 
	country VARCHAR(100)
);

-- Product Dimension
CREATE TABLE warehouse.dim_product (
    product_key SERIAL PRIMARY KEY,
    stock_code VARCHAR(20) NOT NULL,
    description TEXT
);

-- Date Dimension
CREATE TABLE warehouse.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    day INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    quarter INTEGER,
    year INTEGER,
    day_of_week INTEGER,
    day_name VARCHAR(20)
);


-- Verify created dimension tables
SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'warehouse'
ORDER BY table_name;


-- Verify dimension columns
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'warehouse'
  AND table_name IN (
      'dim_customer',
      'dim_product',
      'dim_date'
  )
ORDER BY table_name, ordinal_position;