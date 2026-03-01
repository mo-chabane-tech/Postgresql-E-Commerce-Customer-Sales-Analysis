CREATE MATERIALIZED VIEW IF NOT EXISTS daily_sales AS
SELECT
    DATE(o.order_purchase_timestamp) AS date,
    COUNT(DISTINCT o.order_id) AS num_orders,
    SUM(oi.price) AS revenue,
    SUM(oi.freight_value) AS freight
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY date
ORDER BY date;

REFRESH MATERIALIZED VIEW daily_sales;