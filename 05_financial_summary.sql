-- Employee & Vendor Data Analytics Project
-- File: 05_financial_summary.sql
-- Description: Vendor performance, invoice trends, and payment summary analysis
-- Database: AP (Accounts Payable)
-- Tools: Microsoft SQL Server Management Studio (SSMS)
-- Author: Prashna Dhakal
-- Date: 2025-11-04
-- ------------------------------------------------------------
-- Business Context:
-- The Finance department requested a summary analysis of vendor
-- billing and payment patterns to improve financial planning 
-- and supplier relationship management across global operations.
-- ------------------------------------------------------------

-- 1️⃣ Working Model: Vendor Summary with Key Aggregates
SELECT 
    VendorName,
    COUNT(InvoiceID) AS NumInvoices,
    SUM(PaymentTotal) AS SumPayments,
    AVG(InvoiceTotal) AS AvgInvoiceAmt
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY Vendors.VendorName
ORDER BY Vendors.VendorName;
-- Purpose: Creates a baseline view of vendor invoice frequency, payment totals, and average invoice amounts.

-- ------------------------------------------------------------

-- 2️⃣ Identify Vendor with Most Invoices
SELECT TOP 1
    VendorName,
    COUNT(InvoiceID) AS NumInvoices
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY NumInvoices DESC;
-- Purpose: Determines the vendor with the highest number of invoices.

-- ------------------------------------------------------------

-- 3️⃣ Identify Vendor Paid the Most
SELECT TOP 1
    VendorName,
    SUM(PaymentTotal) AS SumPayments
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY SumPayments DESC;
-- Purpose: Highlights the vendor that received the largest total payments.

-- ------------------------------------------------------------

-- 4️⃣ Identify Vendor with Highest Average Invoice Value
SELECT TOP 1
    VendorName,
    AVG(InvoiceTotal) AS AvgInvoiceAmt
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY AvgInvoiceAmt DESC;
-- Purpose: Finds vendors who submit the highest-value invoices on average.

-- ------------------------------------------------------------

-- 5️⃣ Financial Overview (Scalar Aggregates)
SELECT 
    COUNT(InvoiceID) AS TotalInvoices,
    SUM(PaymentTotal) AS TotalPayments,
    AVG(InvoiceTotal) AS AvgInvoiceValue
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID;
-- Purpose: Provides a global summary of financial transactions.

-- ------------------------------------------------------------

-- 6️⃣ Extended Metric: Vendor Count and Average Invoices per Vendor
SELECT 
    COUNT(InvoiceID) AS NumInvoices,
    SUM(PaymentTotal) AS TotalPayments,
    COUNT(DISTINCT Vendors.VendorID) AS NumVendors,
    COUNT(InvoiceID) / COUNT(DISTINCT Vendors.VendorID) AS AvgNumInvoicesPerVendor,
    AVG(InvoiceTotal) AS AvgInvoiceAmt
FROM Vendors 
JOIN Invoices 
    ON Vendors.VendorID = Invoices.VendorID;
-- Purpose: Measures the diversity of vendor relationships and billing frequency.

-- ------------------------------------------------------------

-- ✅ End of file
