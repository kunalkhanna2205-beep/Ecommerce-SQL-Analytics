WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT 
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY order_month)) / 
        LAG(revenue) OVER (ORDER BY order_month)) * 100
    , 2) AS mom_growth_pct
FROM monthly_sales
ORDER BY order_month;

WITH category_sales AS (
    SELECT 
        pr.product_category_name,
        oi.product_id,
        SUM(oi.price) AS total_revenue
    FROM order_items oi
    JOIN products pr ON oi.product_id = pr.product_id
    GROUP BY 1, 2
),
ranked_products AS (
    SELECT 
        product_category_name,
        product_id,
        total_revenue,
        ROW_NUMBER() OVER (PARTITION BY product_category_name ORDER BY total_revenue DESC) AS category_rank
    FROM category_sales
)
SELECT 
    product_category_name,
    product_id,
    total_revenue,
    category_rank
FROM ranked_products
WHERE category_rank <= 3
ORDER BY product_category_name, category_rank;