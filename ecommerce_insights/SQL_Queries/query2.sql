SELECT 
    CASE 
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Late'
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On Time'
        ELSE 'Canceled/Unknown'
    END AS delivery_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY 1
ORDER BY total_orders DESC;

WITH customer_spend AS (
    SELECT 
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT 
    CASE 
        WHEN total_spent >= 500 THEN 'High Value'
        WHEN total_spent >= 150 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(customer_id) AS customer_count,
    SUM(total_spent) AS segment_revenue
FROM customer_spend
GROUP BY 1
ORDER BY segment_revenue DESC;

