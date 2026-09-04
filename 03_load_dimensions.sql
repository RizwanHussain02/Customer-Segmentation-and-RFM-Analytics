-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 03 - LOAD DIMENSION TABLES
-- ============================================================

-- Load Customer Dimension
INSERT INTO warehouse.dim_customer (
    customer_id,
    country
)
SELECT
    customer_id::INTEGER,
    country
FROM (
    SELECT
        customer_id,
        country,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY invoice_date DESC
        ) AS rn
    FROM staging.retail_transactions
    WHERE customer_id IS NOT NULL
) AS customer_data
WHERE rn = 1;


-- Load Product Dimension
INSERT INTO warehouse.dim_product (
    stock_code,
    description
)
SELECT
    stock_code,
    MAX(description) AS description
FROM staging.retail_transactions
WHERE stock_code IS NOT NULL
GROUP BY stock_code;


-- Load Date Dimension
INSERT INTO warehouse.dim_date (
    date_key,
    full_date,
    day,
    month,
    month_name,
    quarter,
    year,
    day_of_week,
    day_name
)
SELECT DISTINCT
    TO_CHAR(invoice_date::DATE, 'YYYYMMDD')::INTEGER AS date_key,
    invoice_date::DATE AS full_date,
    EXTRACT(DAY FROM invoice_date)::INTEGER AS day,
    EXTRACT(MONTH FROM invoice_date)::INTEGER AS month,
    TO_CHAR(invoice_date, 'Month') AS month_name,
    EXTRACT(QUARTER FROM invoice_date)::INTEGER AS quarter,
    EXTRACT(YEAR FROM invoice_date)::INTEGER AS year,
    EXTRACT(ISODOW FROM invoice_date)::INTEGER AS day_of_week,
    TO_CHAR(invoice_date, 'Day') AS day_name
FROM staging.retail_transactions
WHERE invoice_date IS NOT NULL;


SELECT * 
FROM warehouse.dim_date
LIMIT 5;


-- validate cusomter dimension
SELECT
	COUNT(*) AS total_customers,
	COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM warehouse.dim_customer;


-- validate product dimension
SELECT
	COUNT(*) AS total_products,
	COUNT(DISTINCT stock_code) AS unique_stock_code
FROM warehouse.dim_product;


-- validate date dimension
SELECT
    COUNT(*) AS total_dates,
    MIN(full_date) AS first_date,
    MAX(full_date) AS last_date
FROM warehouse.dim_date;


-- INSPECT DIMENSIONS
SELECT *
FROM warehouse.dim_customer
ORDER BY customer_key
LIMIT 5;

SELECT *
FROM warehouse.dim_product
ORDER BY product_key
LIMIT 5;

SELECT *
FROM warehouse.dim_date
ORDER BY full_date
LIMIT 5;