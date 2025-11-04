-- Employee & Vendor Data Analytics Project
-- File: 04_inventory_analysis.sql
-- Description: Inventory and product-level insights for supply optimization
-- Database: Northwind
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- The Operations team requested an inventory efficiency analysis 
-- to identify overstocked items, fast-moving products, and 
-- low-supply risks across global warehouses.
-- ------------------------------------------------------------

-- 1️⃣ Total number of products available by category
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS TotalProducts
FROM Categories AS c
JOIN Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalProducts DESC;
-- Purpose: Shows which product categories have the largest portfolios.

-- ------------------------------------------------------------

-- 2️⃣ Identify top 10 best-selling products by total quantity sold
SELECT TOP 10
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM Products AS p
JOIN [Order Details] AS od
    ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;
-- Purpose: Highlights high-demand products for inventory priority.

-- ------------------------------------------------------------

-- 3️⃣ Find products with low stock (below safety threshold)
SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel
ORDER BY UnitsInStock ASC;
-- Purpose: Helps managers identify products that need replenishment.

-- ------------------------------------------------------------

-- 4️⃣ Calculate average product unit price per category
SELECT 
    c.CategoryName,
    ROUND(AVG(p.UnitPrice), 2) AS AvgUnitPrice
FROM Categories AS c
JOIN Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY AvgUnitPrice DESC;
-- Purpose: Assists procurement and pricing teams in evaluating category-level value.

-- ------------------------------------------------------------

-- 5️⃣ Identify overstocked items (inventory > 100 units and no recent orders)
SELECT 
    p.ProductName,
    p.UnitsInStock,
    MAX(o.OrderDate) AS LastOrderDate
FROM Products AS p
LEFT JOIN [Order Details] AS od
    ON p.ProductID = od.ProductID
LEFT JOIN Orders AS o
    ON od.OrderID = o.OrderID
GROUP BY p.ProductName, p.UnitsInStock
HAVING MAX(o.OrderDate) < DATEADD(MONTH, -6, GETDATE()) 
    AND p.UnitsInStock > 100;
-- Purpose: Detects slow-moving items that may require clearance or redistribution.

-- ------------------------------------------------------------

-- ✅ End of file
