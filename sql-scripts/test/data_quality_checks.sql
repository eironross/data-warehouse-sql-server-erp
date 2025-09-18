
-- Checking only teh available fields
SELECT TOP 10 * FROM BRONZE.CashTransactions

-- Counting all the data
SELECT COUNT(*) FROM BRONZE.CashTransactions

-- Checking for duplicated keys in the CashKey
SELECT COUNT(*), Cashkey
FROM BRONZE.CashTransactions
GROUP BY CashKey
HAVING COUNT(*) > 1


-- Check for the foriegn keys if all present in the table
SELECT * FROM BRONZE.CashTransactions
WHERE
	OrderDetailKey NOT IN (SELECT OrderDetailKey FROM BRONZE.OrderDetails)


-- Check for NULL, all CashKeys are presents but for the others
SELECT * FROM BRONZE.CashTransactions
WHERE
	CashKey IS NULL 

-- 1702 rows are mostly NULL for this fields
SELECT * FROM BRONZE.CashTransactions
WHERE
	OrderDetailKey IS NULL
	OR DepositCheck IS NULL
	OR TransactionDate IS NULL
	OR CollectionPeriod IS NULL
	OR PaymentAmount IS NULL




