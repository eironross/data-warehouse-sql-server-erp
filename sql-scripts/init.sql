-- medallion architecture + star schema implementation

-- Landing Zone of the Data
CREATE DATABASE DBWAREHOUSE_STG

USE DBWAREHOUSE_STG;
GO
CREATE SCHEMA bronze

CREATE DATABASE DBWAREHOUSE_CURATED
-- Create a pipeline from bronze layer to silver
USE DBWAREHOUSE_CURATED;
GO
CREATE SCHEMA silver
CREATE SCHEMA gold