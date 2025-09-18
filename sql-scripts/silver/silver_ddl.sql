/*
    Data Definition Language (DDL) script for Silver layer tables in a Data Warehouse for SQL Server ERP

    Adding auditing fields and source system information.
*/

USE FONTAINE_DWH;
GO

-- Dimension Tables
IF OBJECT_ID('SILVER.Customer', 'U') IS NOT NULL
	DROP TABLE SILVER.Customer;
CREATE TABLE SILVER.Customer (
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
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
);

IF OBJECT_ID('SILVER.Facility', 'U') IS NOT NULL
	DROP TABLE SILVER.Facility;
CREATE TABLE SILVER.Facility (
    FacilityKey INT PRIMARY KEY
    ,Facility NVARCHAR(150) NOT NULL
    ,City NVARCHAR(50)
    ,Region NVARCHAR(50)
    ,Capacity INT
    ,IsActive BIT DEFAULT 1
    ,BeginOps DATE
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
);

IF OBJECT_ID('SILVER.Products', 'U') IS NOT NULL
	DROP TABLE SILVER.Products;
CREATE TABLE SILVER.Products (
    ProductKey INT PRIMARY KEY
    ,ProductName NVARCHAR(255) NOT NULL
    ,Quantity INT
    ,Category NVARCHAR(100)
    ,Price DECIMAL(11,2)
    ,IsActive BIT DEFAULT 1
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
)

-- Fact Tables
IF OBJECT_ID('SILVER.OrderHeader', 'U') IS NOT NULL
	DROP TABLE SILVER.OrderHeader;
CREATE TABLE SILVER.OrderHeader (
    OrderHeaderKey INT PRIMARY KEY
    ,BillDates DATE
    ,PaidInFull BIT
    ,Status NVARCHAR(50)
    ,Wh_CreatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_InsertedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_UpdatedDate DATETIME2 DEFAULT GETDATE()
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
);

IF OBJECT_ID('SILVER.OrderDetails', 'U') IS NOT NULL
	DROP TABLE SILVER.OrderDetails;
CREATE TABLE SILVER.OrderDetails (
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
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
);

IF OBJECT_ID('SILVER.CashTransactions', 'U') IS NOT NULL
	DROP TABLE SILVER.CashTransactions;
CREATE TABLE SILVER.CashTransactions (
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
    ,Wh_SourceSystem NVARCHAR(50) DEFAULT 'FONTAINE_DWH'
);