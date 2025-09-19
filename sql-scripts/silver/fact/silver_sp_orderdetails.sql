
/*
Purpose: Stored Procedure to load data into Silver Schema
*/

USE FONTAINE_DWH;
GO

CREATE OR ALTER PROCEDURE [SILVER].[sp_load_silver_orderdetails] AS 
BEGIN
	DECLARE  @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT '==========================================='
		PRINT 'Loading Data into SILVER Schema'
		PRINT '==========================================='
		PRINT '-------------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: SILVER.OrderDetails'
		TRUNCATE TABLE SILVER.OrderDetails
		PRINT '>> Loading Data to SILVER.OrderDetails'

		INSERT INTO SILVER.OrderDetails (
			OrderDetailKey
			,OrderHeaderKey
			,CustomerKey
			,ProductKey
			,FacilityKey
			,TransactionDate
			,BillDate
		)
		SELECT 
			o.OrderDetailKey
			,o.OrderHeaderKey
			,o.CustomerKey
			,o.ProductKey
			,o.FacilityKey
			,o.TransactionDate
			,o.BillDate
		FROM BRONZE.OrderDetails o
		WHERE
			(o.OrderDetailKey IS NOT NULL
			AND o.OrderHeaderKey IS NOT NULL
			AND o.CustomerKey IS NOT NULL
			AND o.ProductKey IS NOT NULL
			AND o.FacilityKey IS NOT NULL
			AND o.TransactionDate IS NOT NULL
			AND o.BillDate IS NOT NULL)
			OR
			(o.OrderDetailKey IS NOT NULL
			AND o.OrderHeaderKey IS NOT NULL)

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