USE FONTAINE_DWH;
GO

IF OBJECT_ID('GOLD.vw_DimCustomer', 'V') IS NOT NULL
    DROP VIEW GOLD.vw_DimCustomer;
GO

CREATE VIEW GOLD.vw_DimCustomer AS 
SELECT 
	c.CustomerKey
	,CONCAT(c.FirstName, ' ',c.LastName) AS [FullName]
	,c.Gender
	,c.MaritalStatus
	,c.Email
	,c.City
FROM SILVER.Customer c
WHERE
	IsActive <> 0
    AND c.Email IS NOT NULL

