create  database amazon;
use amazon;
CREATE TABLE amazon_sales (
    Region VARCHAR(255),
    Country VARCHAR(255),
    Item_Type VARCHAR(255),
    Sales_Channel VARCHAR(50),
    Order_Priority VARCHAR(50),
    Order_Date DATE,
    Order_ID BIGINT,
    Ship_Date DATE,
    Units_Sold INT,
    Unit_Price FLOAT,
    Unit_Cost FLOAT,
    Total_Revenue FLOAT,
    Total_Cost FLOAT,
    Total_Profit FLOAT,
    Shipping_Delay INT
);
select * from amazon_sales;

-- Query 1-: Find Total Sales Revenue per Region
SELECT `Region`, SUM(`Total_Revenue`) AS Total_Sales
FROM amazon.`amazon_sales`
GROUP BY `Region`
ORDER BY Total_Sales DESC;

-- Query 2-: Using CTEs (Common Table Expressions)
-- CTE to calculate Profit Margin per Order
WITH Profit_Margin_CTE AS (
    SELECT 
        `Order_ID`,
        (`Total_Profit` / `Total_Revenue`) AS Profit_Margin
    FROM amazon.`amazon_sales`
)
SELECT *
FROM Profit_Margin_CTE
ORDER BY Profit_Margin DESC;

-- Query 3-: Window Function: Running Total Revenue by Region
SELECT 
    `Region`,
    `Order_ID`,
    `Total_Revenue`,
    SUM(`Total_Revenue`) OVER (PARTITION BY `Region` ORDER BY `Order_Date`) AS Running_Total_Revenue
FROM amazon.`amazon_sales`;

-- Query 4-: -- Optimized Query for Top Selling Products
WITH Top_Items AS (
    SELECT `Item_Type`, SUM(`Units_Sold`) AS Total_Units
    FROM amazon.`amazon_sales`
    GROUP BY `Item_Type`
)
SELECT `Item_Type`, Total_Units
FROM Top_Items
ORDER BY Total_Units DESC
LIMIT 10;
