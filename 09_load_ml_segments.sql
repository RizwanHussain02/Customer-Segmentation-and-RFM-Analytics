-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 09 - LOAD ML CUSTOMER SEGMENTS
-- ============================================================

DROP TABLE IF EXISTS warehouse.customer_segments;

CREATE TABLE warehouse.customer_segments (
    customer_id      BIGINT PRIMARY KEY,
    recency          NUMERIC(18,2),
    frequency        NUMERIC(18,2),
    monetary         NUMERIC(18,2),
    cluster          INTEGER NOT NULL,
    segment          VARCHAR(100) NOT NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- check row count

SELECT COUNT(*) AS segment_rows
FROM warehouse.customer_segments;


-- Check segment distribution.

SELECT
    segment,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM warehouse.customer_segments
GROUP BY segment
ORDER BY customer_count DESC;


-- Validate RFM values

SELECT
    segment,
    COUNT(*) AS customers,
    ROUND(AVG(recency), 2) AS avg_recency,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary
FROM warehouse.customer_segments
GROUP BY segment
ORDER BY avg_monetary DESC;
