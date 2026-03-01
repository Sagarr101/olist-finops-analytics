-- ==========================================================
-- FILE: 04_category_analysis.sql
-- PROJECT: Olist FinOps Analytics
-- OBJECTIVE: Analyze Performance by Product Category
-- ==========================================================

SET search_path TO olist;

-- ==========================================================
-- Category Performance Metrics
-- ==========================================================

SELECT
    p.product_category_name_english AS category,

    ROUND(SUM(oi.price + oi.freight_value), 2) 
        AS total_revenue,

    COUNT(DISTINCT o.order_id) 
        AS total_orders,

    ROUND(
        SUM(oi.price + oi.freight_value) 
        / COUNT(DISTINCT o.order_id),
        2
    ) 
        AS average_order_value

FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id

GROUP BY p.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 15;

-- ==========================================================
-- BUSINESS INTERPRETATION:
-- Identifies top-performing categories by revenue.
-- Helps understand which segments drive marketplace growth.
-- ==========================================================