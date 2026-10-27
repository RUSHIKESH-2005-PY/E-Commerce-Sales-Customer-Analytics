/*
Project: E-Commerce Sales & Customer Analytics
Database: PostgreSQL
Purpose: Analyze sales, profitability, customers,
         products, orders, and business performance.

Dataset: 120,000 orders
*/

-- 1. Verify total orders and unique customers
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(net_sales), 2) AS total_net_sales
FROM ecommerce_orders;
