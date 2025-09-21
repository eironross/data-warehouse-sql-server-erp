-- gold sale
SELECT
	CAST(CONVERT(NVARCHAR(8), o.TransactionDate, 112) AS INT) AS [DateKey]
	,o.CustomerKey
	,o.FacilityKey
	,p.Category
	,p.CategoryType
	,p.ListPrice * 2 AS [SalesAmount]
FROM SILVER.OrderDetails o
INNER JOIN SILVER.Products p ON o.ProductKey = p.ProductKey


