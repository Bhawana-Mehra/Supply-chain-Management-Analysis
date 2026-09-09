-- In data Audit.sql file there are 32,927 rows which shows shipping date before the order placed date.

SELECT TOP 20
    Order_Id,
     order_date_DateOrders AS Raw_Order_Date,
    shipping_date_DateOrders AS Raw_Shipping_Date
    
FROM stg_DataCo
WHERE shipping_date_DateOrders < order_date_DateOrders;


-- ============================================
-- FINDING: Invalid shipping dates
-- ============================================
-- 32,927 rows (~18%) have shipping date before order date.
-- Checked raw data: time matches exactly, only date/year is off.
-- This is a data issue in the source file, not a parsing bug.
--
-- Decision: Not deleting these rows (it is too much to loss).
-- Adding a flag instead, so shipping-time analysis can exclude 
-- them, while Sales/Profit/Customer analysis still uses all rows.
-- ============================================

ALTER TABLE stg_DataCo
ADD Is_Date_Anomaly BIT;

UPDATE stg_DataCo
SET Is_Date_Anomaly = CASE 
    WHEN shipping_date_DateOrders < order_date_DateOrders THEN 1 
    ELSE 0 
END;

-- Verify
SELECT Is_Date_Anomaly, COUNT(*) AS Record_Count
FROM stg_DataCo
GROUP BY Is_Date_Anomaly;