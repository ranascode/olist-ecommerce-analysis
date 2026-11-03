SELECT
    ct.product_category_name_english AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales,
    ROUND(
        SUM(oi.price) * 1.0 /
        COUNT(DISTINCT o.order_id),
        2
    ) AS category_aov
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation AS ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY ct.product_category_name_english
ORDER BY total_sales DESC
LIMIT 10;