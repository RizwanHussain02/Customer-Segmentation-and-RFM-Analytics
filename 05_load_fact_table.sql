-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 05 - LOAD FACT TABLE
-- ============================================================

INSERT INTO warehouse.fact_sales (
    invoice,
    customer_key,
    product_key,
    date_key,
    quantity,
    unit_price,
    revenue
)
SELECT
    s.invoice,
    c.customer_key,
    p.product_key,
    d.date_key,
    s.quantity,
    s.price,
    s.revenue
FROM staging.retail_transactions s

INNER JOIN warehouse.dim_customer c
    ON s.customer_id::INTEGER = c.customer_id

INNER JOIN warehouse.dim_product p
    ON s.stock_code = p.stock_code

INNER JOIN warehouse.dim_date d
    ON s.invoice_date::DATE = d.full_date;



SELECT COUNT(*) AS fact_rows
FROM warehouse.fact_sales;



SELECT
    (SELECT COUNT(*)
     FROM staging.retail_transactions) AS staging_rows,

    (SELECT COUNT(*)
     FROM warehouse.fact_sales) AS fact_rows,

    (SELECT ROUND(SUM(revenue), 2)
     FROM staging.retail_transactions) AS staging_revenue,

    (SELECT ROUND(SUM(revenue), 2)
     FROM warehouse.fact_sales) AS fact_revenue;