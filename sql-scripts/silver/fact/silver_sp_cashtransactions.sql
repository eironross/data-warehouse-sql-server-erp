
/*
Purpose: Stored Procedure to load data into Silver Schema
*/

USE FONTAINE_DWH;
GO

CREATE OR ALTER PROCEDURE [SILVER].[sp_load_silver_cashtransactions] AS 
BEGIN
	DECLARE  @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
		PRINT '==========================================='
		PRINT 'Loading Data into SILVER Schema'
		PRINT '==========================================='
		PRINT '-------------------------------------------'

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: SILVER.CashTransactions'
		TRUNCATE TABLE SILVER.CashTransactions
		PRINT '>> Loading Data to SILVER.CashTransactions'

		INSERT INTO SILVER.CashTransactions (
			CashKey
			,OrderDetailKey
			,DepositCode
			,DepositHash
			,TransactionDate
			,CollectionPeriod
			,PaymentAmount
		)
		SELECT 
			c.CashKey
			,c.OrderDetailKey
			,REPLACE(c.DepositCheck, 'DNSCHECK', 'DNS-SP10000-') AS [DepositCode]
			,HASHBYTES('MD5', c.DepositCheck) AS [DepositHash]
			,c.TransactionDate
			,c.CollectionPeriod
			,c.PaymentAmount
		FROM BRONZE.CashTransactions c
		WHERE
			c.PaymentAmount <> 0
			AND (
				c.OrderDetailKey IS NOT NULL
				AND c.DepositCheck IS NOT NULL
				AND c.TransactionDate IS NOT NULL
				AND c.PaymentAmount IS NOT NULL
				AND c.CollectionPeriod IS NOT NULL
			)

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