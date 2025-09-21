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