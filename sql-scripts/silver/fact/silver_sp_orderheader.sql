/*
Purpose: Stored Procedure to load data into Silver Schema
*/

USE FONTAINE_DWH;
GO

CREATE OR ALTER PROCEDURE [SILVER].[sp_load_silver_orderheader] AS 
BEGIN
	DECLARE  @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT '==========================================='
		PRINT 'Loading Data into SILVER Schema'
		PRINT '==========================================='
		PRINT '-------------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: SILVER.OrderHeader'
		TRUNCATE TABLE SILVER.OrderHeader
		PRINT '>> Loading Data to SILVER.OrderHeader'

		INSERT INTO SILVER.OrderHeader (
			OrderHeaderKey
			,OrderHeader
			,BillDate
			,TransactionDate
			,PaidInFull
			,Status
			,StatusCode
		)
		SELECT 
			oh.OrderHeaderKey
			,CONCAT('SOA-', SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 6)) AS [OrderHeader]
			,oh.BillDates
			,DATEADD(day, 20, oh.BillDates) AS [TransactionDate]
			,oh.PaidInFull
			,TRIM(oh.Status) AS [Status]
			,CASE
				TRIM(oh.Status)
				WHEN 'Paid' THEN 1
				WHEN 'Pending' THEN 2
				WHEN 'Confirmed' THEN 3
				WHEN 'Cancelled' THEN 4
				ELSE NULL
			END AS [StatusCode]
		FROM BRONZE.OrderHeader oh

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