USE FONTAINE_DWH;
GO

IF OBJECT_ID('GOLD.vw_FactAR', 'V') IS NOT NULL
    DROP VIEW GOLD.vw_FactAR;
GO

CREATE VIEW GOLD.vw_FactAR 
AS 
WITH FactAccountReceivable AS (
SELECT
	CONVERT(CHAR(32), HASHBYTES('MD5'
		,CONCAT(CAST(o.CustomerKey AS NVARCHAR(50))
		,CAST(o.TransactionDate AS NVARCHAR(50))
		,CAST(o.FacilityKey AS NVARCHAR(50))
		,CAST(p.Category AS NVARCHAR(50))
		,CAST(p.CategoryType AS NVARCHAR(50)))
	), 2)  AS [BalanceKey]
	,CAST(CONVERT(NVARCHAR(8), o.TransactionDate, 112) AS INT) AS [DateKey]
	,o.CustomerKey
	,o.FacilityKey
	,p.Category
	,p.CategoryType
	,SUM(p.ListPrice) * 2 AS [ARAmount]
	,SUM(p.ListPrice) * 2 - SUM(Cash.CashAmount) AS [CurrentBalance]
FROM SILVER.OrderDetails o
INNER JOIN SILVER.Products p ON o.ProductKey = p.ProductKey
INNER JOIN 
	(
		SELECT
			c.OrderDetailKey
			,SUM(c.PaymentAmount) AS [CashAmount]
		FROM SILVER.CashTransactions c
		GROUP BY
			c.OrderDetailKey
	) Cash ON o.OrderDetailKey = Cash.OrderDetailKey
GROUP BY
	o.CustomerKey
	,o.TransactionDate
	,o.FacilityKey
	,p.Category
	,p.CategoryType
)
SELECT 
	*
FROM FactAccountReceivable