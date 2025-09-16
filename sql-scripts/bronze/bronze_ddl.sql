/*
    Data Definition Language (DDL) script for Bronze layer tables in a Data Warehouse for SQL Server ERP
*/

USE FONTAINT_DWH;
GO

-- Dimension Tables
IF OBJECT_ID('BRONZE.Customer', 'U') IS NOT NULL
	DROP TABLE BRONZE.Customer;
CREATE TABLE BRONZE.Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY
    ,FirstName NVARCHAR(50) NOT NULL
    ,LastName NVARCHAR(50) NOT NULL
    ,MiddleName NVARCHAR(50)
    ,Gender NVARCHAR(1)
    ,MaritalStatus NVARCHAR(1)
    ,Email NVARCHAR(255)
    ,City NVARCHAR(100)
    ,IsActive BIT DEFAULT 1
    ,CreatedDate DATE 
    ,InsertedDate DATETIME
);

IF OBJECT_ID('BRONZE.Facility', 'U') IS NOT NULL
	DROP TABLE BRONZE.Facility;
CREATE TABLE BRONZE.Facility (
    FacilityKey INT IDENTITY(1,1) PRIMARY KEY
    ,Facility NVARCHAR(150) NOT NULL
    ,City NVARCHAR(50)
    ,Region NVARCHAR(50)
    ,Capacity INT
    ,IsActive BIT DEFAULT 1
    ,CreatedDate DATE
    ,BeginOps DATE
);

IF OBJECT_ID('BRONZE.Products', 'U') IS NOT NULL
	DROP TABLE BRONZE.Products;
CREATE TABLE BRONZE.Products (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY
    ,ProductName NVARCHAR(255) NOT NULL
    ,Quantity INT
    ,Category NVARCHAR(100)
    ,Price DECIMAL(11,2)
    ,IsActive BIT DEFAULT 1
    ,CreatedDate DATE
    ,UpdatedDate DATETIME 
)

-- Fact Tables
IF OBJECT_ID('BRONZE.OrderHeader', 'U') IS NOT NULL
	DROP TABLE BRONZE.OrderHeader;
CREATE TABLE BRONZE.OrderHeader (
    OrderHeaderKey INT IDENTITY(1,1) PRIMARY KEY
    ,BillDates DATE
    ,PaidInFull BIT
    ,Status NVARCHAR(50)
);

IF OBJECT_ID('BRONZE.OrderDetails', 'U') IS NOT NULL
	DROP TABLE BRONZE.OrderDetails;
CREATE TABLE BRONZE.OrderDetails (
    OrderDetailKey INT IDENTITY(1,1) PRIMARY KEY
    ,OrderHeaderKey INT
    ,CustomerKey INT
    ,ProductKey INT
    ,FacilityKey INT
    ,TransactionDate DATE
    ,BillDate DATE
);

IF OBJECT_ID('BRONZE.CashTransactions', 'U') IS NOT NULL
	DROP TABLE BRONZE.CashTransactions;
CREATE TABLE BRONZE.CashTransactions (
    CashKey INT IDENTITY(1,1) PRIMARY KEY
    ,OrderDetailKey INT
    ,DepositCheck NVARCHAR(100)
    ,TransactionDate DATE
    ,CollectionPeiod DATE
    ,PaymentAmount DECIMAL(11,2)
);