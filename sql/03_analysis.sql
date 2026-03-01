-- Q1: Revenue by Product Category (Monthly Trend)

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    p.product_category_name AS category,
    ROUND(SUM(oi.price)::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY month, category
ORDER BY month, revenue DESC;

-- Q2: Customer Lifetime Value (LTV) by State

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_state,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_id, c.customer_state
)
SELECT
    customer_state,
    COUNT(customer_id) AS num_customers,
    ROUND(AVG(total_spent)::numeric, 2) AS avg_ltv,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_spent)::numeric, 2) AS median_ltv
FROM customer_revenue
GROUP BY customer_state
ORDER BY avg_ltv DESC;

-- Q3: Repeat Purchase Rate (Cohort Analysis)

WITH customer_months AS (
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS purchase_month
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id, purchase_month
),
cohorts AS (
    SELECT
        customer_unique_id,
        MIN(purchase_month) AS first_purchase_month
    FROM customer_months
    GROUP BY customer_unique_id
)
SELECT
    c.first_purchase_month,
    COUNT(DISTINCT c.customer_unique_id) AS cohort_size,
    COUNT(DISTINCT cm.customer_unique_id) AS customers_with_repeat,
    ROUND(100.0 * COUNT(DISTINCT cm.customer_unique_id) / COUNT(DISTINCT c.customer_unique_id), 2) AS repeat_rate
FROM cohorts c
LEFT JOIN customer_months cm
    ON c.customer_unique_id = cm.customer_unique_id
    AND cm.purchase_month > c.first_purchase_month
GROUP BY c.first_purchase_month
ORDER BY c.first_purchase_month;

-- Q4: Top 10 Products by Sales (with Rank)

SELECT
    p.product_category_name AS category,
    p.product_id,
    SUM(oi.price) AS total_sales,
    RANK() OVER (PARTITION BY p.product_category_name
                 ORDER BY SUM(oi.price) DESC) AS rank_in_category
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category, p.product_id
ORDER BY category, rank_in_category;

-- Q5: Payment Method Preferences

SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS num_orders,
    SUM(payment_value) AS total_amount,
    ROUND(AVG(payment_value)::numeric, 2) AS avg_payment
FROM order_payments
GROUP BY payment_type
ORDER BY total_amount DESC;

-- Q6: Delivery Performance by State

SELECT
    c.customer_state,
    AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))) AS avg_delivery_days,
    AVG(EXTRACT(DAY FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp))) AS avg_estimated_days,
    AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date))) AS avg_diff_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;