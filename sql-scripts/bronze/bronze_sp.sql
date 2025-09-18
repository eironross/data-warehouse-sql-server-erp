/*
Purpose: Stored Procedure to load data into Bronze Schema

Reminder: for mypath, use the absolute path to your local directory where the CSV files are stored. Refer to .env file.
Ensure the path ends with a backslash (\) and is enclosed in single quotes.

WARNING: mypath + filename should be replaced with the actual path and filename. This does not work as is
*/

USE FONTAINE_DWH;
GO

CREATE OR ALTER PROCEDURE [BRONZE].[sp_load_bronze] AS 
BEGIN
	DECLARE  @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT '==========================================='
		PRINT 'Loading Data into BRONZE Schema'
		PRINT '==========================================='
		PRINT '-------------------------------------------'
		
		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.Customer'
		TRUNCATE TABLE BRONZE.Customer
		PRINT '>> Loading Data to BRONZE.Customer'
		BULK INSERT BRONZE.Customer
		FROM mypath + cust.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.Facility'
		TRUNCATE TABLE BRONZE.Facility
		PRINT '>> Loading Data to BRONZE.Facility'
		BULK INSERT BRONZE.Facility
		FROM mypath + facility.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.Products'
		TRUNCATE TABLE BRONZE.Products
		PRINT '>> Loading Data to BRONZE.Products'
		BULK INSERT BRONZE.Products
		FROM mypath + products.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.OrderHeader'
		TRUNCATE TABLE BRONZE.OrderHeader
		PRINT '>> Loading Data to BRONZE.OrderHeader'
		BULK INSERT BRONZE.OrderHeader
		FROM mypath + orderheader.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.OrderDetails'
		TRUNCATE TABLE BRONZE.OrderDetails
		PRINT '>> Loading Data to BRONZE.OrderDetails'
		BULK INSERT BRONZE.OrderDetails
		FROM mypath + orderdetails.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: BRONZE.CashTransactions'
		TRUNCATE TABLE BRONZE.CashTransactions
		PRINT '>> Loading Data to BRONZE.CashTransactions'
		BULK INSERT BRONZE.CashTransactions
		FROM mypath + cashtransactions.csv
		WITH
			(
			FIELDTERMINATOR=','
			,FIRSTROW=2
			,TABLOCK
			);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

	END TRY
	BEGIN CATCH
		PRINT '==========================================='
		PRINT 'Error message:' + ERROR_MESSAGE();
		PRINT 'Error message:' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error message:' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================='
	END CATCH;
END;