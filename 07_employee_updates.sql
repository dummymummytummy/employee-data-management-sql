-- Employee & Vendor Data Analytics Project
-- File: 07_employee_updates.sql
-- Description: Employee data updates for international expansion
-- Database: Northwind
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- HR requested updates to employee data to prepare for UK expansion.
-- This includes role changes, new hires, reporting structure updates,
-- and cleanup of duplicate records.
-- ------------------------------------------------------------

-- 1️⃣ Update an existing employee for international assignment
-- Margaret Peacock (EmployeeID=4) moved to London as UK Expansion Manager
UPDATE EmployeesCOPY
SET Title = 'UK Expansion Manager',         
    City = 'London',
    Country = 'UK',
    ReportsTo = 5,   
    Address = NULL,
    PostalCode = NULL
WHERE EmployeeID = 4;

-- Update REGION for all London-based employees
UPDATE EmployeesCOPY
SET Region = 'UK Region'
WHERE City = 'London';

-- ------------------------------------------------------------

-- 2️⃣ Insert a new employee for US Sales Manager role
INSERT INTO EmployeesCOPY
(LastName, FirstName, TitleOfCourtesy, Title, Region, Address, City, Country, PostalCode, ReportsTo)
VALUES ('Fagen', 'Donald','Mr.','US Sales Manager', 'US Region', '155 W. 66th St.','Manhattan','US',10019,2);

-- ------------------------------------------------------------

-- 3️⃣ Extra Credit: Remove duplicate records for Donald Fagen
DELETE FROM EmployeesCOPY
WHERE EmployeeID NOT IN (
    SELECT MIN(EmployeeID)
    FROM EmployeesCOPY
    WHERE FirstName = 'Donald' AND LastName = 'Fagen'
);

-- ------------------------------------------------------------

-- 4️⃣ Update reporting structure for US employees
-- Three US employees who previously reported to Andrew Fuller now report to Donald Fagen
UPDATE EmployeesCOPY
SET ReportsTo = 10
WHERE ReportsTo = 2 AND Country = 'US' AND EmployeeID <> 13;

-- ------------------------------------------------------------

-- 5️⃣ Display updated EmployeesCOPY table
SELECT EmployeeID, LastName, FirstName, Title, TitleOfCourtesy,
       Address, City, Country, Region, PostalCode, ReportsTo
FROM EmployeesCOPY
ORDER BY EmployeeID;

-- ------------------------------------------------------------

-- ✅ End of file
