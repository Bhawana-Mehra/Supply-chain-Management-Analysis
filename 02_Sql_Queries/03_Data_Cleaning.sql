-- CLEAN TABLE: clean_DataCo

-- Excluded (junk/PII/not useful):
-- Customer_Email, Customer_Password, Customer_Fname, Customer_Lname,
-- Customer_Street, Product_Description, Product_Image, Order_Zipcode


SELECT
    -- Order info
    [Type] AS Order_Type,
    Order_Id,
    Order_Item_Id,
    Order_Customer_Id,
    order_date_DateOrders AS Order_Date,
    shipping_date_DateOrders AS Shipping_Date,
    Days_for_shipping_real AS Actual_Shipping_Days,
    Days_for_shipment_scheduled AS Scheduled_Shipping_Days,
    (CAST(Days_for_shipping_real AS INT) - CAST(Days_for_shipment_scheduled AS INT)) AS Shipping_Delay_Days,
    TRIM(Delivery_Status) AS Delivery_Status,
    Late_delivery_risk AS Late_Delivery_Risk,
    TRIM(Shipping_Mode) AS Shipping_Mode,
    Is_Date_Anomaly,

    CASE
        WHEN Days_for_shipping_real > Days_for_shipment_scheduled THEN 'Late'
        WHEN Days_for_shipping_real < Days_for_shipment_scheduled THEN 'Early'
        ELSE 'On Time'
    END AS Shipping_Performance,

    -- Customer info
    Customer_Id,
    Customer_City,
    Customer_State,
    Customer_Country,
    Customer_Zipcode,
    TRIM(Customer_Segment) AS Customer_Segment,

    -- Product info
    Product_Card_Id AS Product_ID,
    Product_Name,
    Product_Category_Id,
    Category_Id,
    TRIM(Category_Name) AS Category_Name,
    Product_Price,

    -- Order location
    TRIM(Market) AS Market,
    Order_Region,
    Order_State,
    Order_City,
    Order_Country,
    TRIM(Order_Status) AS Order_Status,

    -- Financials
    Sales,
    Sales_per_customer AS Sales_Per_Customer,
    Order_Item_Quantity,
    Order_Item_Discount,
    Order_Item_Discount_Rate AS Discount_Rate,
    Order_Item_Product_Price,
    Order_Item_Total,
    Order_Item_Profit_Ratio,
    Order_Profit_Per_Order,
    Benefit_per_order AS Benefit_Per_Order

INTO clean_DataCo
FROM stg_DataCo;


-- For Verify
SELECT COUNT(*) FROM clean_DataCo;

