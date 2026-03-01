-- ==========================================================
-- FILE: 05_seller_concentration.sql
-- PROJECT: Olist FinOps Analytics
-- OBJECTIVE: Analyze Seller Revenue Concentration
-- ==========================================================

SET search_path TO olist;

-- ==========================================================
-- Step 1: Revenue per Seller
-- ==========================================================

WITH seller_revenue AS (
    SELECT
        seller_id,
        SUM(price + freight_value) AS revenue
    FROM order_items
    GROUP BY seller_id
),

-- ==========================================================
-- Step 2: Top 10 Sellers
-- ==========================================================

top_10 AS (
    SELECT revenue
    FROM seller_revenue
    ORDER BY revenue DESC
    LIMIT 10
)

-- ==========================================================
-- Step 3: Concentration Calculation
-- ==========================================================

SELECT
    ROUND(
        (SELECT SUM(revenue) FROM top_10)
        /
        (SELECT SUM(revenue) FROM seller_revenue)
        * 100,
        2
    ) AS top_10_revenue_percentage;

-- ==========================================================
-- BUSINESS INTERPRETATION:
-- Measures how much total revenue is controlled by
-- the top 10 sellers.
-- Lower percentage indicates marketplace diversification.
-- ==========================================================