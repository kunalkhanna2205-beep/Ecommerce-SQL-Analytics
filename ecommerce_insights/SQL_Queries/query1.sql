SELECT 
    COUNT(O.order_id) AS total_orders,  
    SUM(p.payment_value) AS total_revenue,
    ROUND(AVG(p.payment_value), 2) AS average_order_value
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';

SELECT 
    payment_type,
    COUNT(order_id) AS transaction_count,
    SUM(payment_value) AS total_revenue,
    ROUND(
        (SUM(payment_value) / SUM(SUM(payment_value)) OVER()) * 100, 2
    ) AS percentage_of_total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

SELECT 
    pr.product_category_name,
    COUNT(oi.product_id) AS items_sold,
    SUM(oi.price) AS category_revenue
FROM order_items oi
JOIN products pr ON oi.product_id = pr.product_id
GROUP BY pr.product_category_name
ORDER BY category_revenue DESC
LIMIT 10;

SELECT 
    c.customer_state,
    ROUND(AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))), 1) AS avg_actual_delivery_days,
    ROUND(AVG(EXTRACT(DAY FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp))), 1) AS avg_estimated_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_actual_delivery_days DESC;

