-- ==========================================================
-- FILE: 03_customer_retention.sql
-- PROJECT: Olist FinOps Analytics
-- OBJECTIVE: Analyze Revenue by New vs Repeat Customers
-- ==========================================================

SET search_path TO olist;

-- ==========================================================
-- Step 1: Identify first purchase per unique customer
-- ==========================================================

WITH first_purchase AS (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),

-- ==========================================================
-- Step 2: Classify each order
-- ==========================================================

customer_orders AS (
    SELECT
        o.order_id,
        c.customer_unique_id,
        o.order_purchase_timestamp,
        CASE 
            WHEN o.order_purchase_timestamp = fp.first_order_date 
                THEN 'New'
            ELSE 'Repeat'
        END AS customer_type
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    JOIN first_purchase fp
        ON c.customer_unique_id = fp.customer_unique_id
)

-- ==========================================================
-- Step 3: Calculate revenue by type
-- ==========================================================

SELECT
    customer_type,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue,
    COUNT(DISTINCT co.order_id) AS total_orders
FROM customer_orders co
JOIN order_items oi
    ON co.order_id = oi.order_id
GROUP BY customer_type
ORDER BY customer_type;

-- ==========================================================
-- BUSINESS INTERPRETATION:
-- Measures revenue split between new and returning customers.
-- ==========================================================