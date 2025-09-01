-- medallion architecture + star schema implementation

-- Landing Zone of the Data
CREATE DATABASE DBWAREHOUSE_STG

USE DBWAREHOUSE_STG;
GO
CREATE SCHEMA bronze

-- Create a pipeline from bronze layer to silver
USE DBWAREHOUSE_CURATED;
GO
CREATE SCHEMA silver
CREATE SCHEMA gold

-- Create a pipeline from gold/silver to PRD
CREATE DATABASE DBWAREHOUSE_PRD

USE DBWAREHOUSE_PRD;
GO
CREATE SCHEMA Dim
CREATE SCHEMA Fact