# 🚀Project Overview
- This project builds a Data Warehousing and Analytics solution that consolidates and transforms data from CSV files. Using the Medallion Architecture (Bronze → Silver → Gold), the system ensures clean, reliable data that supports business intelligence, reporting, and advanced analytics. 

## General Principle
- **Naming Conventions**: Use PascalCase as the naming convention and no spaces on each word. ie. tablename -> SalesOrder
    - Use naming of **key** instead of the **_GUID**. ie Date Keys -> DateKey

## Data Architecture Diagram
![image](./assets/data-architecture-diagram.png)

## Source Data
- **Files/Volumes**: Data will be sourced the csv. This will generated mock data and manipulated in excel for batch processing. 

## StarSchema Diagram
![image](./assets/star%20schema.jpg)

### Dimension

| Table        | Description                                                   |
| ------------ | ------------------------------------------------------------- |
| **Customer** | Stores customer details; determines who placed orders.        |
| **Facility** | Stores facility/location details where items are ordered.     |
| **Date**     | Date dimension table ie DateKey, 20240926, Date '09/26/2024'  |


### Fact
| Table                      | Description                                                              |
| -------------------------- | ------------------------------------------------------------------------ |
| **FactSales**              | Aggregates sales (e.g., sales per quarter).                              |
| **FactAR** | Tracks unpaid items past due date.                                       |

### Data Catalog

#### vw_DimCustomers

| Column Name       | Description                                                                            | Example Value                                   |
| ----------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------- |
| **CustomerKey**   | Surrogate key uniquely identifying each customer record. Primary key of the dimension. | 1001                                            |
| **FullName**      | Full name of the customer (first name + last name).                                    | John Doe                                        |
| **Gender**        | Gender of the customer. Typically stored as 'M' / 'F' or full text.                    | M                                               |
| **MaritalStatus** | Marital status of the customer. Typical values: 'Single', 'Married', 'Divorced'.       | Married                                         |
| **Email**         | Customer’s email address, used for communication and identification.                   | john.doe@email.com |
| **City**          | City of residence of the customer.                                                     | New York                                        |

#### vw_DimFacility

| Column Name        | Description                                                                               | Example Value          |
| ------------------ | ----------------------------------------------------------------------------------------- | ---------------------- |
| **FacilityKey**    | Surrogate key uniquely identifying each facility record. Primary key of the dimension.    | 1                   |
| **LineOfBusiness** | Type of business or service line the facility operates under.                             | Fontaine Inc.             |
| **Region**         | Geographic region where the facility is located (e.g., North, South, East, West).         | North America          |
| **City**           | City where the facility is located.                                                       | Chicago                |
| **FacilityName**   | Official name of the facility.                                                            | Chicago Medical Center |
| **Capacity**       | The maximum operational capacity of the facility (e.g., number of beds, seats, or units). | 250                    |

#### DimDate

| Column Name            | Description                                                                                     | Example Value  |
| ---------------------- | ----------------------------------------------------------------------------------------------- | -------------- |
| **DateKey**            | Surrogate key representing the date in `YYYYMMDD` integer format. Primary key of the dimension. | 20250921       |
| **Date**               | Full calendar date.                                                                             | 2025-09-21     |
| **DayNumber**          | Numeric day of the month (1–31).                                                                | 21             |
| **DayName**            | Name of the day of the week.                                                                    | Sunday         |
| **WeekNumber**         | Calendar week number of the year (1–52/53).                                                     | 38             |
| **MonthNumber**        | Numeric month of the year (1–12).                                                               | 9              |
| **MonthNameShort**     | Abbreviated month name.                                                                         | Sep            |
| **MonthNameYearShort** | Month and year in short format.                                                                 | Sep-25         |
| **MonthNameYearLong**  | Month and year in long format.                                                                  | September 2025 |
| **QuarterNumber**      | Numeric quarter of the year (1–4).                                                              | 3              |
| **QuarterName**        | Quarter label.                                                                                  | Q3             |
| **YearNumber**         | Four-digit calendar year.                                                                       | 2025           |
| **IsWeekend**          | Indicator if the date falls on a weekend (Yes/No or 1/0).                                       | Yes            |
| **FiscalYear**         | Fiscal year the date belongs to.                                                                | FY2025         |
| **FiscalYearStart**    | Starting date of the fiscal year.                                                               | 2025-07-01     |
| **FiscalYearEnd**      | Ending date of the fiscal year.                                                                 | 2026-06-30     |

#### vw_FactSales

| Column Name        | Description                                                                            | Example Value       |
| ------------------ | -------------------------------------------------------------------------------------- | ------------------- |
| **BalanceKey**     | Surrogate key uniquely identifying each balance record. Primary key of the fact table. | 61D84AF8FEE00348555371036A329FDD               |
| **DateKey**        | Foreign key referencing `DimDate.DateKey`, representing the date of the transaction.       | 20250921            |
| **CustomerKey**    | Foreign key referencing `vw_DimCustomer.CustomerKey`, identifying the customer.           | 1001                |
| **FacilityKey**    | Foreign key referencing `vw_DimFacility.FacilityKey`, identifying the facility.           | 5001                |
| **Category**       | Business category associated with the balance (e.g., Service Type, Product Group).     | Inpatient           |
| **CategoryType**   | Higher-level classification or grouping of the category.                               | Healthcare Services |
| **ARAmount**       | Accounts Receivable amount tied to the balance entry.                                  | 15000.00            |
| **CurrentBalance** | Current outstanding balance at the given date.                                         | 5000.00             |

#### vw_FactSales

| Column Name      | Description                                                                                          | Example Value       |
| ---------------- | ---------------------------------------------------------------------------------------------------- | ------------------- |
| **SaleKey**      | Surrogate key uniquely identifying each sales transaction record. Primary key of the fact table.     | D0F1F4C63A548AC9E64414BC32BE6175               |
| **DateKey**      | Foreign key referencing `vw_DimDate.DateKey`, representing the date of the sale.                        | 20250921            |
| **CustomerKey**  | Foreign key referencing `vw_DimCustomer.CustomerKey`, identifying the customer who made the purchase.   | 1001                |
| **FacilityKey**  | Foreign key referencing `vw_DimFacility.FacilityKey`, identifying the facility where the sale occurred. | 5001                |
| **Category**     | Business category associated with the sale (e.g., Product Line, Service Type).                       | Outpatient          |
| **CategoryType** | Higher-level classification or grouping of the category.                                             | Healthcare Services |
| **SalesAmount**  | Monetary value of the sale transaction.                                                              | 2500.00             |


## Optional:
- generation of the powerbi report
- devops to encapsulate the db in docker files

