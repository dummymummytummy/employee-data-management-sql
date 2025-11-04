-- Employee & Vendor Data Analytics Project
-- File: 01_vendor_analysis.sql
-- Description: Vendor performance analysis for the Accounts Payable (AP) system
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- The Accounts Payable (AP) department requested a set of SQL
-- reports to evaluate vendor performance across multiple
-- dimensions, including payment totals, invoice counts, and
-- average invoice amounts. These insights help management
-- identify key suppliers and optimize payment scheduling.
-- ------------------------------------------------------------

-- 1️⃣ Retrieve total invoice amounts and invoice count per vendor
SELECT 
    v.VendorName,
    COUNT(i.InvoiceID) AS TotalInvoices,
    SUM(i.InvoiceTotal) AS TotalPaid,
    AVG(i.InvoiceTotal) AS AvgInvoice
FROM Vendors AS v
JOIN Invoices AS i
    ON v.VendorID = i.VendorID
GROUP BY v.VendorName
ORDER BY TotalPaid DESC;
-- Purpose: Identifies top vendors by payment volume and transaction activity.

-- ------------------------------------------------------------

-- 2️⃣ Find vendors who have been paid more than the overall average invoice amount
SELECT 
    v.VendorName,
    SUM(i.InvoiceTotal) AS TotalPaid
FROM Vendors AS v
JOIN Invoices AS i
    ON v.VendorID = i.VendorID
GROUP BY v.VendorName
HAVING SUM(i.InvoiceTotal) > (
    SELECT AVG(InvoiceTotal)
    FROM Invoices
);
-- Purpose: Highlights vendors with above-average total payment volumes.

-- ------------------------------------------------------------

-- 3️⃣ Identify vendors with outstanding (unpaid) invoices
SELECT 
    v.VendorName,
    i.InvoiceNumber,
    i.InvoiceTotal,
    i.PaymentTotal,
    (i.InvoiceTotal - i.PaymentTotal) AS BalanceDue
FROM Vendors AS v
JOIN Invoices AS i
    ON v.VendorID = i.VendorID
WHERE (i.InvoiceTotal - i.PaymentTotal) > 0
ORDER BY BalanceDue DESC;
-- Purpose: Assists AP team in monitoring pending payments and managing cash flow.

-- ------------------------------------------------------------

-- 4️⃣ List vendors and their latest invoice dates
SELECT 
    v.VendorName,
    MAX(i.InvoiceDate) AS LatestInvoiceDate
FROM Vendors AS v
JOIN Invoices AS i
    ON v.VendorID = i.VendorID
GROUP BY v.VendorName
ORDER BY LatestInvoiceDate DESC;
-- Purpose: Tracks recency of vendor transactions to identify active vs. inactive suppliers.

-- ------------------------------------------------------------

-- ✅ End of file
