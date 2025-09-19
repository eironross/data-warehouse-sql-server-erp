/*
    Data Definition Language (DDL) script for Gold layer tables in a Data Warehouse for SQL Server ERP

    Adding auditing fields and source system information.
*/

USE SILVER_LAYER;
GO

-- Dimension Tables
IF OBJECT_ID('GOLD.DimDate', 'U') IS NOT NULL
	DROP TABLE GOLD.DimDate;
CREATE TABLE GOLD.DimDate (
    DateKey INT NOT NULL PRIMARY KEY -- YYYYMMDD
    ,Date DATE NOT NULL
    ,DayNumber TINYINT NOT NULL 
    ,DayName VARCHAR(10) NOT NULL
    ,WeekNumber TINYINT NOT NULL 
    ,MonthNumber TINYINT NOT NULL 
    ,MonthNameShort VARCHAR(10) NOT NULL 
    ,MonthNameYearShort VARCHAR(15) NOT NULL -- e.g. Jan 2025
    ,MonthNameYearLong VARCHAR(20) NOT NULL -- e.g. January 2025
    ,QuarterNumber TINYINT NOT NULL 
    ,QuarterName VARCHAR(6)  NOT NULL 
    ,YearNumber INT NOT NULL
    ,IsWeekend BIT NOT NULL
    ,FiscalYear INT NOT NULL 
    ,FiscalYearStart DATE NOT NULL
    ,FiscalYearEnd DATE NOT NULL
);
GO

IF OBJECT_ID('GOLD.Customer', 'U') IS NOT NULL
	DROP TABLE GOLD.Customer;
CREATE TABLE GOLD.Customer (
    CustomerKey INT PRIMARY KEY
    ,FirstName NVARCHAR(50) NOT NULL
    ,LastName NVARCHAR(50) NOT NULL
    ,MiddleName NVARCHAR(50)
    ,Gender NVARCHAR(10)
    ,MaritalStatus NVARCHAR(10)
    ,Email NVARCHAR(255)
    ,City NVARCHAR(100)
    ,IsActive BIT DEFAULT 1
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
);

IF OBJECT_ID('GOLD.Facility', 'U') IS NOT NULL
	DROP TABLE GOLD.Facility;
CREATE TABLE GOLD.Facility (
    FacilityKey INT PRIMARY KEY
	,LineOfBusiness NVARCHAR(150)
    ,Region NVARCHAR(50)
    ,City NVARCHAR(50)
    ,FacilityName NVARCHAR(50)
    ,Capacity INT
    ,IsActive BIT DEFAULT 1
    ,BeginOps DATE
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
);

IF OBJECT_ID('GOLD.Products', 'U') IS NOT NULL
	DROP TABLE GOLD.Products;
CREATE TABLE GOLD.Products (
    ProductKey INT PRIMARY KEY
	,ProductCode NVARCHAR(255) 
    ,ProductName NVARCHAR(255) 
    ,Category NVARCHAR(100)
	,CategoryType NVARCHAR(2)
    ,Quantity INT
    ,ListPrice DECIMAL(11,2)
    ,IsActive BIT DEFAULT 1
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
)

-- Fact Tables
IF OBJECT_ID('GOLD.OrderHeader', 'U') IS NOT NULL
	DROP TABLE GOLD.OrderHeader;
CREATE TABLE GOLD.OrderHeader (
    OrderHeaderKey INT PRIMARY KEY
	,OrderHeader NVARCHAR(50)
    ,BillDate DATE
	,TransactionDate DATE
    ,PaidInFull BIT
    ,Status NVARCHAR(50)
	,StatusCode INT
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
);

IF OBJECT_ID('GOLD.OrderDetails', 'U') IS NOT NULL
	DROP TABLE GOLD.OrderDetails;
CREATE TABLE GOLD.OrderDetails (
    OrderDetailKey INT PRIMARY KEY
    ,OrderHeaderKey INT
    ,CustomerKey INT
    ,ProductKey INT
    ,FacilityKey INT
    ,TransactionDate DATE
    ,BillDate DATE
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
);

IF OBJECT_ID('GOLD.CashTransactions', 'U') IS NOT NULL
	DROP TABLE GOLD.CashTransactions;
CREATE TABLE GOLD.CashTransactions (
    CashKey INT PRIMARY KEY
    ,OrderDetailKey INT
    ,DepositCode NVARCHAR(30)
	,DepositHash VARBINARY(16)
    ,TransactionDate DATE
    ,CollectionPeriod DATE
    ,PaymentAmount DECIMAL(11,2)
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'SILVER_LAYER'
);