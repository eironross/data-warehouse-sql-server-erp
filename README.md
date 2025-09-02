# 🚀Project Overview
- This project builds a Data Warehousing and Analytics solution that consolidates and transforms data from CSV files. Using the Medallion Architecture (Bronze → Silver → Gold), the system ensures clean, reliable data that supports business intelligence, reporting, and advanced analytics. 

## General Principle
- **Naming Conventions**: Use PascalCase as the naming convention and no spaces on each word. ie. tablename -> SalesOrder
    - Use naming of **key** instead of the **_GUID**. ie Date Keys -> DateKey

## Source Data
- **Files**: Data will be sourced the csv. This will generated mock data and manipulated in excel for batch processing. 

## Tables

### Dimension

| Table        | Description                                                   |
| ------------ | ------------------------------------------------------------- |
| **Customer** | Stores customer details; determines who placed orders.        |
| **Product**  | Stores product details; used for Qty and Unit Price in sales. |
| **Facility** | Stores facility/location details where items are ordered.     |

### Fact
| Table               | Description                                                           |
| ------------------- | --------------------------------------------------------------------- |
| **OrderHeader**     | Tracks orders with statuses (Pending, Cancelled, Shipped, Confirmed). |
| **OrderDetails**    | Tracks detailed line items per order.                                 |
| **CashTransaction** | Records cash received from customers.                                 |

### Aggregate Fact Tables
| Table                      | Description                                                              |
| -------------------------- | ------------------------------------------------------------------------ |
| **FactSales**              | Aggregates sales (e.g., sales per quarter).                              |
| **FactRankedItems**        | Identifies top shipped items.                                            |
| **FactAccountsReceivable** | Tracks unpaid items past due date.                                       |
| **FactCashVelocity**       | Measures how quickly cash is collected from sales.                       |
| **FactReceivableDays**                | Calculates average days to collect receivables (Days Sales Outstanding). |


## Project Epics

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

