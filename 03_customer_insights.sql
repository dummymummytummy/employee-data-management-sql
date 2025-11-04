-- Employee & Vendor Data Analytics Project
-- File: 03_customer_insights.sql
-- Description: Customer segmentation and sales insights
-- Database: Northwind
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- The Sales and Marketing team requested a data-driven
-- customer insights report to support strategy planning
-- for international markets. This analysis identifies
-- customer activity levels, regional distribution, and
-- high-value accounts.
-- ------------------------------------------------------------

-- 1️⃣ Retrieve the number of active customers who have placed orders
SELECT 
    COUNT(DISTINCT c.CustomerID) AS ActiveCustomers
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
-- Purpose: Determines how many customers have completed at least one order.

-- ------------------------------------------------------------

-- 2️⃣ List top 10 customers by total purchase amount
SELECT TOP 10
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
JOIN [Order Details] AS od
    ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalSpent DESC;
-- Purpose: Identifies top customers contributing the most to revenue.

-- ------------------------------------------------------------

-- 3️⃣ Identify customers with no orders on record
SELECT 
    c.CustomerID,
    c.CompanyName,
    c.Country,
    c.City
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
-- Purpose: Helps sales teams re-engage inactive or potential customers.

-- ------------------------------------------------------------

-- 4️⃣ Analyze customers by country to find where most orders come from
SELECT 
    c.Country,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.Country
ORDER BY TotalOrders DESC;
-- Purpose: Provides geographic insights for marketing and expansion strategy.

-- ------------------------------------------------------------

-- 5️⃣ Retrieve high-value orders (above company average)
SELECT 
    o.OrderID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS OrderValue
FROM Orders AS o
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
JOIN [Order Details] AS od
    ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.CompanyName
HAVING SUM(od.UnitPrice * od.Quantity) > (
    SELECT AVG(UnitPrice * Quantity) FROM [Order Details]
)
ORDER BY OrderValue DESC;
-- Purpose: Pinpoints exceptional order transactions for executive review.

-- ------------------------------------------------------------

-- ✅ End of file
