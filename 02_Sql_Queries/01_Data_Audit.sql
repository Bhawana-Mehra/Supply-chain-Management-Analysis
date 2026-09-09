-- PERFORM DATA AUDIT

-- 1.check all Data
SELECT * FROM stg_DataCo;



-- Phase 1: Structural Checks
-- 2. Check total rows
SELECT COUNT(*) AS Total_Rows
FROM stg_DataCo;

-- 3. Check unique IDs
SELECT
    COUNT(DISTINCT(Order_Id)) AS Unique_Orders,
    COUNT(DISTINCT(Order_Item_Id)) AS Unique_Order_Items,
    COUNT(DISTINCT(Customer_Id)) AS Unique_Customers,
    COUNT(DISTINCT(Product_Card_Id)) AS Unique_Products
FROM stg_DataCo;

-- 4. Check date range
SELECT
    MIN(order_date_DateOrders) AS First_Order_Date,
    MAX(order_date_DateOrders) AS Last_Order_Date,

    MIN(shipping_date_DateOrders) AS First_Shipping_Date,
    MAX(shipping_date_DateOrders) AS Last_Shipping_Date
FROM stg_DataCo;

-- 5. Check duplicate records
SELECT
    Order_Item_Id,
    COUNT(*) AS Record_Count
FROM stg_DataCo
GROUP BY Order_Item_Id
HAVING COUNT(*) > 1;




--Phase 2: Completeness Checks
-- 6. Check missing values
SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN [Order_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN [Order_Item_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Item_ID,
    SUM(CASE WHEN [Customer_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN [Product_Card_Id] IS NULL THEN 1 ELSE 0 END) AS Missing_Product_ID,

    SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN [Order_Item_Quantity] IS NULL THEN 1 ELSE 0 END) AS Missing_Quantity,
    SUM(CASE WHEN [Product_Price] IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Price,

    SUM(CASE WHEN [Order_Profit_Per_Order] IS NULL THEN 1 ELSE 0 END) AS Missing_Profit,

    SUM(CASE WHEN [order_date_DateOrders] IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Date,
    SUM(CASE WHEN [shipping_date_DateOrders] IS NULL THEN 1 ELSE 0 END) AS Missing_Shipping_Date,

    SUM(CASE WHEN [Delivery_Status] IS NULL THEN 1 ELSE 0 END) AS Missing_Delivery_Status,
    SUM(CASE WHEN [Shipping_Mode] IS NULL THEN 1 ELSE 0 END) AS Missing_Shipping_Mode

FROM stg_DataCo;






-- Phase 3: Validity Checks Queries

-- 7.Check important categorical values
SELECT
    Shipping_Mode,
    COUNT(*) AS Records
FROM stg_DataCo
GROUP BY Shipping_Mode
ORDER BY Records DESC;


SELECT
    Delivery_Status,
    COUNT(*) AS Records
FROM stg_DataCo
GROUP BY Delivery_Status
ORDER BY Records DESC;


SELECT
    Order_Status,
    COUNT(*) AS Records
FROM stg_DataCo
GROUP BY Order_Status
ORDER BY Records DESC;


SELECT
    Customer_Segment,
    COUNT(*) AS Records
FROM stg_DataCo
GROUP BY Customer_Segment
ORDER BY Records DESC;


SELECT
    Market,
    COUNT(*) AS Records
FROM stg_DataCo
GROUP BY Market
ORDER BY Records DESC;


-- 8. Negative/invalid values check
SELECT COUNT(*) AS Negative_Sales
FROM stg_DataCo
WHERE Sales < 0;

SELECT COUNT(*) AS Negative_Quantity
FROM stg_DataCo
WHERE Order_Item_Quantity <= 0;

SELECT COUNT(*) AS Invalid_Discount_Rate
FROM stg_DataCo
WHERE Order_Item_Discount_Rate < 0 OR Order_Item_Discount_Rate > 1;


--9.  Date logic check
SELECT COUNT(*) AS Invalid_Date_Order
FROM stg_DataCo
WHERE shipping_date_DateOrders < order_date_DateOrders;


-- 10. Outliers check
SELECT MIN(Sales), MAX(Sales), AVG(Sales),
       MIN(Order_Profit_Per_Order), MAX(Order_Profit_Per_Order)
FROM stg_DataCo;


--11. Referential consistency
SELECT Order_Id, COUNT(DISTINCT Customer_Id) AS distinct_customers
FROM stg_DataCo
GROUP BY Order_Id
HAVING COUNT(DISTINCT Customer_Id) > 1;