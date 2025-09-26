# Changelog of the Project

## September 26, 2025

### Gold
- Added script to create views for Customers, FactSales, FactAR & Facility
- Added script to create table for DimDate
- Modified the script for the Dimdate DDL

## Sepetember 20, 2025

### Silver
- Added new sp, orderheader and orderdetails (hot storage)
- Customer, products and facility added script but this will only run once or rarely (cold storage)
- Modified all ddl for the silver layer to align with the transformation

### Gold
- Added DimDate scripts to generate the dates table

## September 19, 2025

### Silver
- Added a sp_cashtransactions, stored procedure for the cash transaction from bronze to silver
- Added a sql script to load once the customer tables
- Modified the sql ddl for silver

## September 17, 2025

### Bronze
- modified the ddl script 
- added the stored procedure for loading bronze table, reminder to replace the mypath to the absolute path of the csv files

### Silver
- added the ddl script for the silver layer, added a metadata information
- created a place holder sql for the sp of the silver layer

## September 16, 2025

### Bronze
- Added the ddl script to create the tables in the SQL server

### Others
- Modified the init.sql script to add a checker if db exists

## September 6, 2025
- Added the data architecture: file and diagram
- Added the mock data for ERP+CRM

## September 1, 2025
- Setup folder for the Projects

## End of log