/*
Script Purpose:
    Initialization script for creating the FONTAINE_DWH database and setting up schemas
    for a Data Warehouse using Medallion Architecture (Bronze, Silver, Gold).

WARNING: 
    This script will drop the existing FONTAINE_DWH database if it exists.
    Ensure you have backups of any important data before running this script.
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'FONTAINE_DWH')
BEGIN
	ALTER DATABASE FONTAINE_DWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE FONTAINE_DWH;
END;
GO

-- Create the database
CREATE DATABASE FONTAINE_DWH;
GO

USE FONTAINE_DWH;
GO

-- Creating the Schemas for Medallion Architecture
CREATE SCHEMA BRONZE;
GO

CREATE SCHEMA SILVER;
GO

CREATE SCHEMA GOLD;
