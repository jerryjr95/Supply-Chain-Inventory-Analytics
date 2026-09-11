USE supply_chain_analytics;

-- =====================================================
-- 1. OVERALL SUPPLY CHAIN KPIs
-- =====================================================

SELECT
    COUNT(*) AS total_products,
    SUM(products_sold) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_revenue_per_product,
    ROUND(AVG(stock_levels), 2) AS avg_stock_level,
    ROUND(AVG(supplier_lead_time), 2) AS avg_supplier_lead_time,
    ROUND(AVG(shipping_time), 2) AS avg_shipping_time,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM supply_chain_data;


-- =====================================================
-- 2. PRODUCT TYPE PERFORMANCE
-- =====================================================

SELECT
    product_type,
    COUNT(*) AS product_count,
    SUM(products_sold) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(stock_levels), 2) AS avg_stock,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM supply_chain_data
GROUP BY product_type
ORDER BY total_revenue DESC;


-- =====================================================
-- 3. TOP PRODUCTS BY REVENUE
-- =====================================================

SELECT
    sku,
    product_type,
    ROUND(price, 2) AS price,
    products_sold,
    ROUND(revenue, 2) AS revenue,
    stock_levels,
    supplier_name
FROM supply_chain_data
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 4. LOW-STOCK PRODUCTS
-- =====================================================

SELECT
    sku,
    product_type,
    stock_levels,
    products_sold,
    ROUND(revenue, 2) AS revenue,
    supplier_name
FROM supply_chain_data
ORDER BY stock_levels ASC
LIMIT 10;


-- =====================================================
-- 5. INVENTORY VS SALES
-- =====================================================

SELECT
    sku,
    product_type,
    stock_levels,
    products_sold,
    ROUND(
        stock_levels / NULLIF(products_sold, 0),
        4
    ) AS stock_to_sales_ratio
FROM supply_chain_data
ORDER BY stock_to_sales_ratio ASC;


-- =====================================================
-- 6. SUPPLIER PERFORMANCE
-- =====================================================

SELECT
    supplier_name,
    COUNT(*) AS products_supplied,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(stock_levels), 2) AS avg_stock,
    ROUND(AVG(supplier_lead_time), 2) AS avg_supplier_lead_time,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY total_revenue DESC;


-- =====================================================
-- 7. SUPPLIER QUALITY PERFORMANCE
-- =====================================================

SELECT
    supplier_name,
    COUNT(*) AS products_supplied,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate,
    SUM(
        CASE
            WHEN inspection_result = 'Fail' THEN 1
            ELSE 0
        END
    ) AS failed_inspections
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY avg_defect_rate ASC;


-- =====================================================
-- 8. SHIPPING CARRIER PERFORMANCE
-- =====================================================

SELECT
    shipping_carrier,
    COUNT(*) AS shipments,
    ROUND(AVG(shipping_time), 2) AS avg_shipping_time,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost,
    ROUND(SUM(shipping_cost), 2) AS total_shipping_cost
FROM supply_chain_data
GROUP BY shipping_carrier
ORDER BY total_shipping_cost DESC;


-- =====================================================
-- 9. TRANSPORTATION MODE ANALYSIS
-- =====================================================

SELECT
    transportation_mode,
    COUNT(*) AS shipments,
    ROUND(AVG(shipping_time), 2) AS avg_shipping_time,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM supply_chain_data
GROUP BY transportation_mode
ORDER BY avg_shipping_cost ASC;


-- =====================================================
-- 10. LOCATION PERFORMANCE
-- =====================================================

SELECT
    supplier_location,
    COUNT(*) AS products,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(stock_levels), 2) AS avg_stock,
    ROUND(AVG(lead_time), 2) AS avg_lead_time,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate
FROM supply_chain_data
GROUP BY supplier_location
ORDER BY total_revenue DESC;


-- =====================================================
-- 11. INSPECTION RESULTS
-- =====================================================

SELECT
    inspection_result,
    COUNT(*) AS product_count,
    ROUND(AVG(defect_rate), 4) AS avg_defect_rate,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM supply_chain_data
GROUP BY inspection_result
ORDER BY product_count DESC;


-- =====================================================
-- 12. HIGH-DEFECT PRODUCTS
-- =====================================================

SELECT
    sku,
    product_type,
    supplier_name,
    ROUND(defect_rate, 4) AS defect_rate,
    inspection_result,
    ROUND(revenue, 2) AS revenue
FROM supply_chain_data
ORDER BY defect_rate DESC
LIMIT 10;