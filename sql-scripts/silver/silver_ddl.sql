/*
    Data Definition Language (DDL) script for Silver layer tables in a Data Warehouse for SQL Server ERP

    Adding auditing fields and source system information.
*/

USE FONTAINT_DWH;
GO

-- Dimension Tables
IF OBJECT_ID('SILVER.Customer', 'U') IS NOT NULL
	DROP TABLE SILVER.Customer;
CREATE TABLE SILVER.Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY
    ,FirstName NVARCHAR(50) NOT NULL
    ,LastName NVARCHAR(50) NOT NULL
    ,MiddleName NVARCHAR(50)
    ,Gender NVARCHAR(1)
    ,MaritalStatus NVARCHAR(1)
    ,Email NVARCHAR(255)
    ,City NVARCHAR(100)
    ,IsActive BIT DEFAULT 1
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
);

IF OBJECT_ID('SILVER.Facility', 'U') IS NOT NULL
	DROP TABLE SILVER.Facility;
CREATE TABLE SILVER.Facility (
    FacilityKey INT IDENTITY(1,1) PRIMARY KEY
    ,Facility NVARCHAR(150) NOT NULL
    ,City NVARCHAR(50)
    ,Region NVARCHAR(50)
    ,Capacity INT
    ,IsActive BIT DEFAULT 1
    ,BeginOps DATE
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
);

IF OBJECT_ID('SILVER.Products', 'U') IS NOT NULL
	DROP TABLE SILVER.Products;
CREATE TABLE SILVER.Products (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY
    ,ProductName NVARCHAR(255) NOT NULL
    ,Quantity INT
    ,Category NVARCHAR(100)
    ,Price DECIMAL(11,2)
    ,IsActive BIT DEFAULT 1
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
)

-- Fact Tables
IF OBJECT_ID('SILVER.OrderHeader', 'U') IS NOT NULL
	DROP TABLE SILVER.OrderHeader;
CREATE TABLE SILVER.OrderHeader (
    OrderHeaderKey INT IDENTITY(1,1) PRIMARY KEY
    ,BillDates DATE
    ,PaidInFull BIT
    ,Status NVARCHAR(50)
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
);

IF OBJECT_ID('SILVER.OrderDetails', 'U') IS NOT NULL
	DROP TABLE SILVER.OrderDetails;
CREATE TABLE SILVER.OrderDetails (
    OrderDetailKey INT IDENTITY(1,1) PRIMARY KEY
    ,OrderHeaderKey INT
    ,CustomerKey INT
    ,ProductKey INT
    ,FacilityKey INT
    ,TransactionDate DATE
    ,BillDate DATE
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
);

IF OBJECT_ID('SILVER.CashTransactions', 'U') IS NOT NULL
	DROP TABLE SILVER.CashTransactions;
CREATE TABLE SILVER.CashTransactions (
    CashKey INT IDENTITY(1,1) PRIMARY KEY
    ,OrderDetailKey INT
    ,DepositCheck NVARCHAR(100)
    ,TransactionDate DATE
    ,CollectionPeiod DATE
    ,PaymentAmount DECIMAL(11,2)
    ,CreatedDate DATETIME DEFAULT GETDATE()
    ,InsertedDate DATETIME DEFAULT GETDATE()
    ,UpdatedDate DATETIME DEFAULT GETDATE()
    ,SourceSystem NVARCHAR(50) DEFAULT 'FONTAINT_DWH'
);