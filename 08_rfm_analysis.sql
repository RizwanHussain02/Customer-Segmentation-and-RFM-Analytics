-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 08 - RFM ANALYSIS
-- ============================================================

-- Reference date for RFM calculation
SELECT
    MAX(full_date) + INTERVAL '1 day' AS analysis_date
FROM warehouse.dim_date;



-- Calculate Customer-Level RFM
WITH rfm_base AS (
    SELECT
        f.customer_key,

        MAX(d.full_date) AS last_purchase_date,

        COUNT(DISTINCT f.invoice) AS frequency,

        SUM(f.revenue) AS monetary,

        (
            (SELECT MAX(full_date)
             FROM warehouse.dim_date)
            + INTERVAL '1 day'
        )::DATE
        - MAX(d.full_date) AS recency

    FROM warehouse.fact_sales f

    JOIN warehouse.dim_date d
        ON f.date_key = d.date_key

    GROUP BY f.customer_key
)

SELECT
    c.customer_id,
    c.country,
    r.last_purchase_date,
    r.recency,
    r.frequency,
    ROUND(r.monetary, 2) AS monetary
FROM rfm_base r
JOIN warehouse.dim_customer c
    ON r.customer_key = c.customer_key
ORDER BY r.monetary DESC;



-- Create a Reusable RFM View
CREATE OR REPLACE VIEW warehouse.v_customer_rfm AS

WITH rfm_base AS (
    SELECT
        f.customer_key,
        MAX(d.full_date) AS last_purchase_date,
        COUNT(DISTINCT f.invoice) AS frequency,
        SUM(f.revenue) AS monetary,

        (
            (SELECT MAX(full_date)
             FROM warehouse.dim_date)
            + INTERVAL '1 day'
        )::DATE
        - MAX(d.full_date) AS recency

    FROM warehouse.fact_sales f

    JOIN warehouse.dim_date d
        ON f.date_key = d.date_key

    GROUP BY f.customer_key
)

SELECT
    c.customer_key,
    c.customer_id,
    c.country,
    r.last_purchase_date,
    r.recency,
    r.frequency,
    ROUND(r.monetary, 2) AS monetary
FROM rfm_base r
JOIN warehouse.dim_customer c
    ON r.customer_key = c.customer_key;



-- CHECK THE VIEW
SELECT *
FROM warehouse.v_customer_rfm
ORDER BY monetary DESC
LIMIT 20;


-- VALIDATE RFM CUSTOMER COUNT
SELECT
    COUNT(*) AS rfm_customers,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM warehouse.v_customer_rfm;


-- RFM SUMMARY STATISTICS
SELECT
    ROUND(AVG(recency), 2) AS avg_recency,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary,

    MIN(recency) AS min_recency,
    MAX(recency) AS max_recency,

    MIN(frequency) AS min_frequency,
    MAX(frequency) AS max_frequency,

    MIN(monetary) AS min_monetary,
    MAX(monetary) AS max_monetary
FROM warehouse.v_customer_rfm;



-- TOP CUSTOMERS BY RFM COMPONENTS
SELECT
    customer_id,
    country,
    recency,
    frequency,
    monetary
FROM warehouse.v_customer_rfm
ORDER BY recency ASC
LIMIT 10;


-- MOST FREQUENT CUSTOMERS
SELECT
    customer_id,
    country,
    recency,
    frequency,
    monetary
FROM warehouse.v_customer_rfm
ORDER BY frequency DESC
LIMIT 10;


-- HIGHEST MONETARY CUSTOMERS
SELECT
    customer_id,
    country,
    recency,
    frequency,
    monetary
FROM warehouse.v_customer_rfm
ORDER BY monetary DESC
LIMIT 10;