-- Employee & Vendor Data Analytics Project
-- File: 02_employee_productivity.sql
-- Description: Employee productivity and performance analysis
-- Database: Northwind
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- The Human Resources (HR) and Operations teams requested 
-- a performance summary for employees who handle order 
-- processing and customer management. This analysis 
-- identifies top performers, workload distribution, and 
-- cross-department efficiency trends.
-- ------------------------------------------------------------

-- 1️⃣ Retrieve the total number of orders processed per employee
SELECT 
    e.EmployeeID,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    COUNT(o.OrderID) AS TotalOrders
FROM Employees AS e
JOIN Orders AS o
    ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalOrders DESC;
-- Purpose: Highlights employees who processed the most orders.

-- ------------------------------------------------------------

-- 2️⃣ Calculate average order value handled by each employee
SELECT 
    e.EmployeeID,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    AVG(o.Freight) AS AvgFreightValue
FROM Employees AS e
JOIN Orders AS o
    ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY AvgFreightValue DESC;
-- Purpose: Measures average shipment cost per employee to evaluate efficiency.

-- ------------------------------------------------------------

-- 3️⃣ Identify employees who manage international orders (orders shipped to different countries)
SELECT 
    e.EmployeeID,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    COUNT(o.OrderID) AS InternationalOrders
FROM Employees AS e
JOIN Orders AS o
    ON e.EmployeeID = o.EmployeeID
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCountry <> c.Country
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY InternationalOrders DESC;
-- Purpose: Determines which employees have the most global order experience.

-- ------------------------------------------------------------

-- 4️⃣ Find top 3 employees based on total revenue from their orders
SELECT TOP 3
    e.EmployeeID,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM Employees AS e
JOIN Orders AS o
    ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] AS od
    ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalRevenue DESC;
-- Purpose: Identifies high-revenue employees to assist in performance reviews.

-- ------------------------------------------------------------

-- ✅ End of file
