
USE FONTAINE_DWH;
GO

IF OBJECT_ID('GOLD.vw_FactSales', 'V') IS NOT NULL
    DROP VIEW GOLD.vw_FactSales;
GO

CREATE VIEW GOLD.vw_FactSales AS
SELECT
	CONVERT(CHAR(32), HASHBYTES('MD5'
		,CONCAT(CAST(o.CustomerKey AS NVARCHAR(50))
		,CAST(o.TransactionDate AS NVARCHAR(50))
		,CAST(o.FacilityKey AS NVARCHAR(50))
		,CAST(p.Category AS NVARCHAR(50))
		,CAST(p.CategoryType AS NVARCHAR(50)))
	), 2)  AS [SaleKey]
	,CAST(CONVERT(NVARCHAR(8), o.TransactionDate, 112) AS INT) AS [DateKey]
	,o.CustomerKey
	,o.FacilityKey
	,p.Category
	,p.CategoryType
	,p.ListPrice * 2 AS [SalesAmount]
FROM SILVER.OrderDetails o
INNER JOIN SILVER.Products p ON o.ProductKey = p.ProductKey


