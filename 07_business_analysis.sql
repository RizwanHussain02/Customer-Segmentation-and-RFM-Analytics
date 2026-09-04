-- ============================================================
-- CUSTOMER SEGMENTATION PROJECT
-- 07 - BUSINESS ANALYSIS
-- ============================================================

-- 1. Overall Business KPIs

SELECT
    COUNT(DISTINCT invoice) AS total_orders,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(DISTINCT product_key) AS total_products,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(revenue) / COUNT(DISTINCT invoice), 2) AS average_order_value
FROM warehouse.fact_sales;


-- 2. Revenue by Country

SELECT
    c.country,
    COUNT(DISTINCT f.invoice) AS total_orders,
    COUNT(DISTINCT f.customer_key) AS customers,
    SUM(f.quantity) AS units_sold,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;


-- 3. Top 10 Customers by Revenue

SELECT
    c.customer_id,
    c.country,
    COUNT(DISTINCT f.invoice) AS total_orders,
    SUM(f.quantity) AS units_purchased,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.country
ORDER BY total_revenue DESC
LIMIT 10;


-- 4. Top 10 Products by Revenue

SELECT
    p.stock_code,
    p.description,
    SUM(f.quantity) AS units_sold,
    COUNT(DISTINCT f.invoice) AS orders,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY total_revenue DESC
LIMIT 10;


-- 5. Top 10 Products by Quantity Sold

SELECT
    p.stock_code,
    p.description,
    SUM(f.quantity) AS units_sold,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description
ORDER BY units_sold DESC
LIMIT 10;


-- 6. Monthly Revenue Trend

SELECT
    d.year,
    d.month,
    d.month_name,
    ROUND(SUM(f.revenue), 2) AS total_revenue,
    SUM(f.quantity) AS units_sold,
    COUNT(DISTINCT f.invoice) AS total_orders
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;


-- 7. Quarterly Revenue

SELECT
    d.year,
    d.quarter,
    ROUND(SUM(f.revenue), 2) AS total_revenue,
    COUNT(DISTINCT f.invoice) AS total_orders
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.quarter
ORDER BY
    d.year,
    d.quarter;



-- 8. Customer Order Frequency

SELECT
    c.customer_id,
    c.country,
    COUNT(DISTINCT f.invoice) AS order_frequency,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.country
ORDER BY order_frequency DESC;



-- 9. Average Revenue per Customer

SELECT
    ROUND(
        SUM(revenue) / COUNT(DISTINCT customer_key),
        2
    ) AS average_customer_revenue
FROM warehouse.fact_sales;



-- 10. Customer Revenue Distribution

WITH customer_revenue AS (
    SELECT
        customer_key,
        SUM(revenue) AS revenue
    FROM warehouse.fact_sales
    GROUP BY customer_key
)
SELECT
    COUNT(*) AS customers,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM customer_revenue;



-- 11. Revenue Contribution by Country

WITH country_revenue AS (
    SELECT
        c.country,
        SUM(f.revenue) AS revenue
    FROM warehouse.fact_sales f
    JOIN warehouse.dim_customer c
        ON f.customer_key = c.customer_key
    GROUP BY c.country
)
SELECT
    country,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM country_revenue
ORDER BY revenue DESC;



-- 12. Product Revenue Contribution

WITH product_revenue AS (
    SELECT
        p.stock_code,
        p.description,
        SUM(f.revenue) AS revenue
    FROM warehouse.fact_sales f
    JOIN warehouse.dim_product p
        ON f.product_key = p.product_key
    GROUP BY
        p.stock_code,
        p.description
)
SELECT
    stock_code,
    description,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM product_revenue
ORDER BY revenue DESC
LIMIT 20;



-- 13. Validate Negative Transactions & revenue

SELECT
    COUNT(*) AS negative_quantity_rows
FROM warehouse.fact_sales
WHERE quantity < 0;


SELECT
    COUNT(*) AS negative_revenue_rows
FROM warehouse.fact_sales
WHERE revenue < 0;



-- 14. Product Performance by Country

SELECT
    c.country,
    p.stock_code,
    p.description,
    SUM(f.quantity) AS units_sold,
    ROUND(SUM(f.revenue), 2) AS total_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_customer c
    ON f.customer_key = c.customer_key
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    c.country,
    p.stock_code,
    p.description
ORDER BY total_revenue DESC;



-- 15. Monthly Customer Activity

SELECT
    d.year,
    d.month,
    d.month_name,
    COUNT(DISTINCT f.customer_key) AS active_customers,
    COUNT(DISTINCT f.invoice) AS orders,
    ROUND(SUM(f.revenue), 2) AS revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;



-- 16. Customer Revenue Ranking

SELECT
    c.customer_id,
    c.country,
    ROUND(SUM(f.revenue), 2) AS revenue,
    RANK() OVER (
        ORDER BY SUM(f.revenue) DESC
    ) AS revenue_rank
FROM warehouse.fact_sales f
JOIN warehouse.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.country
ORDER BY revenue_rank;