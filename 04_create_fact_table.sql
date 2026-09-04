-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 04 - CREATE FACT TABLE
-- ============================================================

CREATE TABLE warehouse.fact_sales (
    sales_key BIGSERIAL PRIMARY KEY,

    invoice VARCHAR(20) NOT NULL,

    customer_key INTEGER NOT NULL,
    product_key INTEGER NOT NULL,
    date_key INTEGER NOT NULL,

    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    revenue NUMERIC(14,2) NOT NULL,

    CONSTRAINT fk_fact_customer
        FOREIGN KEY (customer_key)
        REFERENCES warehouse.dim_customer(customer_key),

    CONSTRAINT fk_fact_product
        FOREIGN KEY (product_key)
        REFERENCES warehouse.dim_product(product_key),

    CONSTRAINT fk_fact_date
        FOREIGN KEY (date_key)
        REFERENCES warehouse.dim_date(date_key)
);


-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_fact_sales_customer
ON warehouse.fact_sales(customer_key);

CREATE INDEX idx_fact_sales_product
ON warehouse.fact_sales(product_key);

CREATE INDEX idx_fact_sales_date
ON warehouse.fact_sales(date_key);

CREATE INDEX idx_fact_sales_invoice
ON warehouse.fact_sales(invoice);

SELECT * 
FROM warehouse.fact_sales
LIMIT 10;


-- VERIFY THE FACT TABLE
SELECT 
	table_name,
	column_name,
	data_type
FROM information_schema.columns
WHERE table_schema = 'warehouse'
	AND table_name = 'fact_sales'
ORDER BY ordinal_position;


-- VERIFY FOREIGN KEYS
SELECT
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'warehouse'
  AND table_name = 'fact_sales';