/* 
    File: silver_cust.sql
    Purpose: Load once data from Bronze.Customer to Silver.Customer
    Note: This script is intended to be run once after the initial load of Bronze.Customer
*/    

USE FONTAINE_DWH;
GO

TRUNCATE TABLE SILVER.Customer;
GO

INSERT INTO SILVER.Customer (
	CustomerKey
    ,FirstName
    ,LastName
    ,MiddleName
    ,Gender
    ,MaritalStatus
    ,Email 
    ,City
    ,IsActive
)
SELECT 
	[CustomerKey]
    ,TRIM([FirstName]) AS [FirstName]
    ,TRIM([LastName]) AS [LastName]
    ,CASE 
		WHEN TRIM([MiddleName]) != 'NULL' THEN TRIM([MiddleName])
		ELSE NULL
	END AS [MiddleName]
    ,CASE 
		TRIM([Gender])
		WHEN 'M' THEN 'Male'
		WHEN 'F' THEN 'Female'
		ELSE NULL
	END AS [Gender]
    ,CASE 
		TRIM(MaritalStatus)
		WHEN 'S' THEN 'Single'
		WHEN 'D' THEN 'Divorced'
		WHEN 'W' THEN 'Widowed'
		WHEN 'M' THEN 'Married'
		ELSE NULL
	END AS [MaritalStatus]
    ,LEFT([Email], CHARINDEX('@', [Email])) + 'fontaine.com' AS [Email]
    ,[City]
	,[IsActive]
FROM [BRONZE].[Customer]
WHERE 
    [FirstName] IS NOT NULL
    AND [LastName] IS NOT NULL
    AND [Email] IS NOT NULL