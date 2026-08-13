-- 1. Import Customers
COPY customers
FROM 'C:/Users/Public/ecommerce/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 2. Import Products
COPY products
FROM 'C:/Users/Public/ecommerce/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 3. Import Orders
COPY orders
FROM 'C:/Users/Public/ecommerce/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 4. Import Order Items
COPY order_items
FROM 'C:/Users/Public/ecommerce/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- 5. Import Payments
COPY payments
FROM 'C:/Users/Public/ecommerce/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;