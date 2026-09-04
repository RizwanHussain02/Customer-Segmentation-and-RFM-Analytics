-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 06 - WAREHOUSE VALIDATION
-- ============================================================

-- Dimension row counts
SELECT
    (SELECT COUNT(*) FROM warehouse.dim_customer) AS customers,
    (SELECT COUNT(*) FROM warehouse.dim_product) AS products,
    (SELECT COUNT(*) FROM warehouse.dim_date) AS dates,
    (SELECT COUNT(*) FROM warehouse.fact_sales) AS fact_rows;


-- SOURCE VS WAREHOUSE ROW COUNT
SELECT
    (SELECT COUNT(*)
     FROM staging.retail_transactions) AS staging_rows,

    (SELECT COUNT(*)
     FROM warehouse.fact_sales) AS fact_rows;


-- REVENUE RECONCILIATION
SELECT
    (SELECT ROUND(SUM(revenue), 2)
     FROM staging.retail_transactions) AS staging_revenue,

    (SELECT ROUND(SUM(revenue), 2)
     FROM warehouse.fact_sales) AS fact_revenue;


-- QUANTITY RECONCILIATION
SELECT
    (SELECT SUM(quantity)
     FROM staging.retail_transactions) AS staging_quantity,

    (SELECT SUM(quantity)
     FROM warehouse.fact_sales) AS fact_quantity;


-- VALIDATE FACT GRAIN
SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT sales_key) AS unique_sales_keys
FROM warehouse.fact_sales;


-- CHECK FOR UNEXPECTED NULLS
SELECT
    COUNT(*) FILTER (WHERE customer_key IS NULL) AS null_customer_keys,
    COUNT(*) FILTER (WHERE product_key IS NULL) AS null_product_keys,
    COUNT(*) FILTER (WHERE date_key IS NULL) AS null_date_keys,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantities,
    COUNT(*) FILTER (WHERE unit_price IS NULL) AS null_prices,
    COUNT(*) FILTER (WHERE revenue IS NULL) AS null_revenue
FROM warehouse.fact_sales;


-- VALIDATE DATA RANGE
SELECT
    MIN(full_date) AS first_date,
    MAX(full_date) AS last_date
FROM warehouse.dim_date;


-- FINAL WAREHOUSE SUMMARY
SELECT
    'Customers' AS metric,
    COUNT(*)::BIGINT AS value
FROM warehouse.dim_customer

UNION ALL

SELECT
    'Products',
    COUNT(*)::BIGINT
FROM warehouse.dim_product

UNION ALL

SELECT
    'Dates',
    COUNT(*)::BIGINT
FROM warehouse.dim_date

UNION ALL

SELECT
    'Sales Transactions',
    COUNT(*)::BIGINT
FROM warehouse.fact_sales

UNION ALL

SELECT
    'Total Quantity',
    SUM(quantity)::BIGINT
FROM warehouse.fact_sales

UNION ALL

SELECT
    'Total Revenue',
    ROUND(SUM(revenue), 2)::NUMERIC
FROM warehouse.fact_sales;