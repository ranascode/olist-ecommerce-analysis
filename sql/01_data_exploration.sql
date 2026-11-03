
-- =====================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- 01 - DATA EXPLORATION & QUALITY CHECKS
-- Database: SQLite
-- =====================================================

-- ANALYSIS 1: DATABASE TABLES
-- Objective: List all tables in the database.

SELECT
    name AS table_name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;


-- ANALYSIS 2: ORDER DATA OVERVIEW
-- Objective: Check total orders and date coverage.

SELECT
    COUNT(*) AS total_orders,
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;


-- ANALYSIS 3: MISSING VALUES
-- Objective: Identify missing delivery dates.

SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN order_delivered_customer_date IS NULL
              OR TRIM(order_delivered_customer_date) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_delivery_dates
FROM orders;


-- ANALYSIS 4: DUPLICATE ORDER IDS
-- Objective: Check if order IDs are unique.

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ANALYSIS 5: ORDER STATUS DISTRIBUTION
-- Objective: Understand order status frequencies.

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ANALYSIS 6: ORDER ITEMS OVERVIEW
-- Objective: Check item records and unique orders.

SELECT
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_id) AS unique_orders
FROM order_items;
-- ANALYSIS 7: MISSING DELIVERY DATES
-- Objective: Identify delivered orders with missing
-- actual delivery dates.
-- Finding: 8 delivered orders have missing dates.

SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_estimated_delivery_date,
    order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered'
  AND (
      order_delivered_customer_date IS NULL
      OR TRIM(order_delivered_customer_date) = ''
  );
