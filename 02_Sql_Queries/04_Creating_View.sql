
-- DIM & FACT VIEWS for Power BI


-- Dim_Customer
CREATE VIEW Dim_Customer AS
SELECT DISTINCT
    Customer_Id,
    Customer_City,
    Customer_State,
    Customer_Country,
    Customer_Zipcode,
    Customer_Segment
FROM clean_DataCo;


-- Dim_Product
CREATE VIEW Dim_Product AS
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Product_Category_Id,
    Category_Id,
    Category_Name,
    Product_Price
FROM clean_DataCo;


-- Dim_Location (order-side geography)
CREATE VIEW Dim_Location AS
SELECT DISTINCT
    Order_Region,
    Order_State,
    Order_City,
    Order_Country,
    Market
FROM clean_DataCo;


-- Fact_Orders
CREATE VIEW Fact_Orders AS
SELECT
    Order_Id,
    Order_Item_Id,
    Order_Customer_Id,
    Customer_Id,
    Product_ID,
    Order_Type,
    Order_Date,
    Shipping_Date,
    Actual_Shipping_Days,
    Scheduled_Shipping_Days,
    Shipping_Delay_Days,
    Shipping_Performance,
    Delivery_Status,
    Late_Delivery_Risk,
    Shipping_Mode,
    Is_Date_Anomaly,
    Order_Region,
    Order_State,
    Order_City,
    Order_Country,
    Market,
    Order_Status,
    Sales,
    Sales_Per_Customer,
    Order_Item_Quantity,
    Order_Item_Discount,
    Discount_Rate,
    Order_Item_Product_Price,
    Order_Item_Total,
    Order_Item_Profit_Ratio,
    Order_Profit_Per_Order,
    Benefit_Per_Order
FROM clean_DataCo;


