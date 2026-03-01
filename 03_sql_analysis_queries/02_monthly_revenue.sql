-- FILE: 02_monthly_revenue.sql
-- PROJECT: Olist FinOps Analytics
-- OBJECTIVE: Analyze Monthly Revenue Trend
-- ==========================================================

SET search_path TO olist;

-- Monthly Revenue Trend

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) 
        AS order_month,

    ROUND(SUM(oi.price + oi.freight_value), 2) 
        AS monthly_revenue,

    COUNT(DISTINCT o.order_id) 
        AS total_orders

FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id

GROUP BY order_month
ORDER BY order_month;

-- ==========================================================
-- BUSINESS INTERPRETATION:
-- Identifies revenue growth patterns
-- Detects seasonality spikes
-- Helps forecast demand trends
-- ==========================================================