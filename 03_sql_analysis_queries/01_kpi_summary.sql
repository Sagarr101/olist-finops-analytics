-- ==========================================================
-- FILE: 01_kpi_summary.sql
-- PROJECT: Olist FinOps Analytics
-- OBJECTIVE: Core Marketplace KPIs
-- ==========================================================

-- Use correct schema
SET search_path TO olist;

-- ==========================================================
-- KPI SUMMARY
-- ==========================================================

SELECT 
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
    ON o.order_id = oi.order_id;

-- ==========================================================
-- BUSINESS INTERPRETATION:
-- total_revenue        → Overall marketplace revenue
-- total_orders         → Total completed transactions
-- average_order_value  → Average spend per order
-- ==========================================================