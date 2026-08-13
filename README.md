# E-Commerce Analytics: Customer Retention & Revenue Optimization

# Overview

How do you know whether an e-commerce business is actually growing?

Revenue alone doesn't tell the full story. Customers, products, payments, and delivery performance all contribute to the overall picture.

This project uses the **Brazilian E-Commerce Public Dataset by Olist** to explore these questions using PostgreSQL. I built a relational database from the raw CSV files and used SQL to analyze revenue trends, customer value, product performance, payment behavior, and delivery efficiency.

The goal was not just to write SQL queries, but to use SQL to answer **business questions that an analyst could realistically be asked.**

**Dataset:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

##  Business Problem

The analysis focuses on four areas:

* **Revenue:** How is revenue changing over time, and which payment methods contribute the most?
* **Customers:** Which customers contribute the most revenue, and how does customer value vary?
* **Products:** Which products and categories are driving sales?
* **Logistics:** Where are delivery delays occurring, and which regions are most affected?

By combining these perspectives, the project aims to identify patterns that could help an e-commerce business improve **revenue growth, customer value, and operational performance.**

---

##  Tools & Technologies

* **PostgreSQL** — database and analysis
* **SQLTools / VS Code** — development environment
* **Git & GitHub** — version control and project documentation

### SQL techniques used

* Multi-table `JOIN`s
* Common Table Expressions (CTEs)
* Window functions
* `LAG()` and `ROW_NUMBER()`
* `SUM() OVER()`
* `CASE WHEN`
* Conditional aggregation
* Date and time functions
* Subqueries
* Aggregations and grouping
* Customer segmentation
* Cohort analysis

---

##  Database Structure

The analysis was built using multiple related tables from the Olist dataset.

| Table         | Purpose                                               |
| ------------- | ----------------------------------------------------- |
| `customers`   | Customer IDs and geographic information               |
| `orders`      | Order status and purchase/delivery timestamps         |
| `order_items` | Products purchased, prices, and freight charges       |
| `products`    | Product categories and product attributes             |
| `payments`    | Payment methods, installments, and transaction values |

The tables were connected using primary/foreign-key relationships to create a relational structure suitable for analysis.

---

#  Business Questions

## 1. Revenue & Payment Analysis

**Questions:**

* What is the total GMV generated through the platform?
* What is the Average Order Value (AOV)?
* How does revenue vary by payment method?
* How dependent is revenue on credit-card payments and installments?

SQL was used to combine order, item, and payment data while avoiding double-counting caused by the one-to-many relationships between orders and their associated records.

---

## 2. Delivery & Logistics Performance

**Questions:**

* How long does it take for an order to reach the customer?
* How frequently are orders delivered later than the estimated delivery date?
* Which Brazilian states have the longest average delivery times?
* Which regions show the largest gap between estimated and actual delivery?

A delivery-performance classification was created using `CASE WHEN` to separate orders into **On-Time** and **Late** categories.

This helped move the analysis beyond simply calculating average delivery time and identify potential logistical bottlenecks.

---

## 3. Customer Segmentation & Value

Not every customer contributes equally to revenue.

To investigate this, customers were segmented into **High, Medium, and Low Value** groups based on their contribution to total revenue.

CTEs and aggregation were used to calculate customer-level revenue before assigning customers to different value segments.

**Questions:**

* Which customers contribute the most revenue?
* What proportion of revenue comes from high-value customers?
* How concentrated is platform revenue among the customer base?

---

## 4. Revenue Growth & Trends

Monthly revenue was analyzed to understand how the platform's performance changed over time.

Using the `LAG()` window function, month-over-month revenue growth was calculated to identify periods of acceleration, stagnation, and decline.

**Questions:**

* How has monthly revenue changed over time?
* Which months experienced the strongest growth?
* Were there periods of significant revenue decline?

---

## 5. Product & Category Performance

Product-level performance was analyzed to identify the products driving revenue within each category.

Using:

```sql
ROW_NUMBER() OVER (
    PARTITION BY product_category
    ORDER BY revenue DESC
)
```

the top-performing products within each category were ranked.

**Questions:**

* Which categories generate the most revenue?
* What are the top 3 products within each category?
* Are some categories heavily dependent on a small number of products?

This analysis can help inform merchandising and inventory decisions.

---

#  Key Insights

> **This section will be updated with the actual findings from the analysis.**

The final analysis will highlight findings such as:

* Revenue concentration across customer segments
* Monthly revenue growth and periods of decline
* Payment-method contribution to total revenue
* States with the highest delivery delays
* Highest-performing product categories
* Top revenue-generating products within each category

**All insights will be based on calculations from the dataset rather than assumptions.**

---

#  Project Structure

```text
ecommerce-sql-analysis/
│
├── data/
│   └── raw/
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_import.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_revenue_analysis.sql
│   ├── 05_customer_analysis.sql
│   ├── 06_logistics_analysis.sql
│   └── 07_product_analysis.sql
│
├── README.md
└── ERD.png
```

---

#  How to Run

### 1. Clone the repository

```bash
git clone <repository-url>
cd ecommerce-sql-analysis
```

### 2. Download the dataset

Download the **Olist Brazilian E-Commerce dataset** from Kaggle and place the CSV files in the `data/raw/` directory.

### 3. Create the database

Run:

```text
01_database_setup.sql
```

This creates the required tables and database structure.

### 4. Import the data

Run:

```text
02_data_import.sql
```

Update the PostgreSQL `COPY` file paths if necessary.

### 5. Run the analysis

Execute the SQL scripts in the `sql/` directory to reproduce the analysis.

---

#  What This Project Demonstrates

This project demonstrates the ability to:

* Build and work with a relational PostgreSQL database
* Combine data from multiple tables using SQL joins
* Clean and transform raw transactional data
* Use CTEs and subqueries to structure complex analysis
* Apply window functions to perform ranking and time-series analysis
* Segment customers based on revenue contribution
* Analyze operational performance
* Translate SQL outputs into business insights

The focus throughout the project is on **using SQL as an analytical tool**, rather than simply demonstrating SQL syntax.

---

* Adding statistical analysis of delivery performance
* Investigating relationships between freight costs, delivery time, and customer geography
