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

-- =========================================================
-- 2. Order status distribution
-- =========================================================
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM ecommerce_orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =========================================================
-- 3. Overall return rate
-- =========================================================
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_status = 'Returned'
    ) AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_status = 'Returned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS return_rate_percentage
FROM ecommerce_orders;


-- =========================================================
-- 4. Sales and profit by product category
-- =========================================================
SELECT
    product_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(net_sales), 2) AS total_net_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce_orders
GROUP BY product_category
ORDER BY total_net_sales DESC;


-- =========================================================
-- 5. Monthly sales trend
-- =========================================================
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(net_sales), 2) AS total_net_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- =========================================================
-- 6. Top 10 customers by net sales
-- =========================================================
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_units_purchased,
    ROUND(SUM(net_sales), 2) AS total_net_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce_orders
GROUP BY customer_id, customer_name
ORDER BY total_net_sales DESC
LIMIT 10;
