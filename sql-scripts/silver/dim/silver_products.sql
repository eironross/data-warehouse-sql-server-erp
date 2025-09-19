
/* 
    File: silver_products.sql
    Purpose: Load once data from Bronze.Customer to Silver.Customer
    Note: This script is intended to be run once after the initial load of Bronze.Customer
*/    

USE FONTAINE_DWH;
GO

TRUNCATE TABLE SILVER.Customer;
GO

INSERT INTO SILVER.Products (
	ProductKey
	,ProductCode
    ,ProductName
    ,Category
	,CategoryType
    ,Quantity
    ,ListPrice
    ,IsActive
)
SELECT 
	p.ProductKey
	-- not advisable to do but just to practice transformation
	,CONCAT('FNL-', SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 6)) AS [ProductCode] 
	,TRIM(p.ProductName) AS [ProductName]
	,TRIM(p.Category) AS [Category]
	,CASE
		TRIM(p.Category)
		WHEN 'Clothing' THEN 'CL'
		WHEN 'Food' THEN 'FD'
		WHEN 'Health' THEN 'HL'
		WHEN 'Electronics' THEN 'ET'
		WHEN 'Furniture' THEN 'FT'
		WHEN 'Sports' THEN 'SP'
		WHEN 'Books' THEN 'BK'
		ELSE NULL
	END AS [CategoryType]
	,p.Quantity
	,p.Price AS [ListPrice]
	,p.IsActive
FROM BRONZE.Products p