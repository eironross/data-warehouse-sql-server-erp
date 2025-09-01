# Project Overview

- data-warehouse-sql-server-erp

- Data Engineer Project that will applies the basic concepts of Data Engineering concept from Data Modelling, SQL Script (DML and DDL) and Medallion Architecture. And using the GitHub Projects to try and simulate EPIC, UserStories and Monitor the project status
Projects: https://github.com/eironross/data-warehouse-sql-server-erp

## General
- PascalCase - for the naming convention.
- use naming of **key** instead of the **GUID**

## EPIC

1. Data Modelling and Data Architecture
    - Create a diagram of the Medallion Architecture using draw.io
    - Create a diagram of the Data Model of the ERP, data model relationships of the table
        - Customer, customer table to dimension table to determine who order the products
        -  Products, product table, fact table to determine similar to ancillary charge tableQty then the Unit Price
        - OrderHeader- Table to track the order of the Items, with statuses
            - aggregated line-item of the OrdersPending, Cancelled, Shipped, Confirmed
        - OrderDetails - Table to track the line items that's being ordered by the customers
        - CashTransaction - cash received from the customers
        - Facility - where the items are being ordered and area

2. Data Table Creation and Setup in SQL Server - Bronze Layer
    - Create the DML and DDL SQL Script to generate the tableCREATE db, schema and tables
        - _metadata of the tables
            - wh_inserts
            - wh_update
            - wh_sourceid
            - wh_deletedflag
            - SQL Express setup

3. Table Creations of the Silver Layer

    - Creation of the Silver layer to clean the data of the NULLS, BLANK and minimal transformation
    - CREATE ddl and dml, stored procedure to trigger the pipeline using the EXEC

4. Transformation of the Tables - Gold Layer

    - Create the gold layer, by practice they use the materialized view, but for now use the VIEW cmd to create the vw to create the bi ready tables
        - Create aggregates using what is the sales per quarters? - FactSales 
        - top items that are being shipped? - FactRankedItems
        - How much are items not paid after the due date? - FactAccountsReceivable
        - Cash Velocities? - FactCashVelocity
        - FactDSO
        - DimCustomers
        - DimFacilities
        - DimDate
        - DimStatus


## Optional:
- generation of the powerbi report
- devops to encapsulate the db in docker files

