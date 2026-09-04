SELECT current_database();

CREATE SCHEMA staging;

CREATE SCHEMA warehouse;

SELECT schema_name
FROM information_schema.schemata
ORDER BY schema_name;

CREATE TABLE staging.retail_transactions (
    invoice VARCHAR(20),
    stock_code VARCHAR(20),
    description TEXT,
    quantity INTEGER,
    invoice_date TIMESTAMP,
    price NUMERIC(12,2),
    customer_id INTEGER,
    country VARCHAR(100),
    revenue NUMERIC(14,2)
);

SELECT *
FROM staging.retail_transactions
LIMIT 5;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'staging'
  AND table_name = 'retail_transactions'
ORDER BY ordinal_position;

ALTER TABLE staging.retail_transactions
ALTER COLUMN customer_id TYPE NUMERIC(12,1);


COPY staging.retail_transactions (
    invoice,
    stock_code,
    description,
    quantity,
    invoice_date,
    price,
    country,
    customer_id,
    revenue
)
FROM 'E:/Github Repos/Customer Segmentation Project/cleaned_online_retail_II.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    ESCAPE '"'
);

SELECT *
FROM staging.retail_transactions
LIMIT 5;

SELECT
    COUNT(*) AS rows,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT stock_code) AS products,
    COUNT(DISTINCT invoice) AS invoices,
    COUNT(DISTINCT country) AS countries,
	ROUND(SUM(revenue), 2) AS total_revenue
FROM staging.retail_transactions;