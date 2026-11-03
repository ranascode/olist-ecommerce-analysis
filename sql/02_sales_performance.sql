
-- =====================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- 02 - SALES PERFORMANCE ANALYSIS
-- Database: SQLite
-- Dataset: Brazilian E-Commerce Public Dataset by Olist
-- =====================================================

-- ANALYSIS 1: ORDER STATUS DISTRIBUTION
-- Objective: Understand the distribution of order statuses.

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ANALYSIS 2: CANCELLATION RATE
-- Objective: Calculate the percentage of canceled orders.

SELECT
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS canceled_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_status = 'canceled' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS cancellation_rate
FROM orders;


-- ANALYSIS 3: TOTAL DELIVERED PRODUCT SALES
-- Objective: Calculate the total product sales value
-- for delivered orders, excluding freight charges.

SELECT
    ROUND(SUM(oi.price), 2) AS total_sales
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- ANALYSIS 4: AVERAGE ORDER VALUE (AOV)
-- Objective: Calculate the average product sales
-- value per delivered order.

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales,
    ROUND(
        SUM(oi.price) * 1.0 /
        NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- ANALYSIS 5: MONTHLY SALES AND MOM GROWTH
-- Objective: Analyze monthly product sales and
-- calculate month-over-month growth.
-- Period: January 2017 to August 2018.
-- Note: Growth is calculated between available
-- monthly rows; missing months require validation.

WITH monthly_sales AS (
    SELECT
        strftime(
            '%Y-%m',
            o.order_purchase_timestamp
        ) AS month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.price), 2) AS total_sales
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY
        strftime('%Y-%m', o.order_purchase_timestamp)
),
sales_growth AS (
    SELECT
        month,
        total_orders,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month,
    total_orders,
    total_sales,
    previous_month_sales,
    ROUND(
        100.0 * (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0),
        2
    ) AS mom_growth_rate
FROM sales_growth
ORDER BY month;
