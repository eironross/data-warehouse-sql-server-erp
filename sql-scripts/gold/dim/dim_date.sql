DECLARE @StartDate DATE = '2000-01-01';
DECLARE @EndDate   DATE = '2030-12-31';

;WITH Dates AS
(
    SELECT @StartDate AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM Dates
    WHERE DateValue < @EndDate
)
INSERT INTO GOLD.DimDate
SELECT
    CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')) AS DateKey,
    DateValue AS [Date],
    DATEPART(DAY, DateValue) AS DayNumber,
    DATENAME(WEEKDAY, DateValue) AS DayName,
    DATEPART(WEEK, DateValue) AS WeekNumber,
    DATEPART(MONTH, DateValue) AS MonthNumber,
    LEFT(DATENAME(MONTH, DateValue), 3) AS MonthNameShort,
    LEFT(DATENAME(MONTH, DateValue), 3) + ' ' + CAST(YEAR(DateValue) AS VARCHAR(4)) AS MonthNameYearShort,
    DATENAME(MONTH, DateValue) + ' ' + CAST(YEAR(DateValue) AS VARCHAR(4)) AS MonthNameYearLong,
    DATEPART(QUARTER, DateValue) AS QuarterNumber,
    'Q' + CAST(DATEPART(QUARTER, DateValue) AS VARCHAR(1)) AS QuarterName,
    YEAR(DateValue) AS YearNumber,
    CASE WHEN DATEPART(WEEKDAY, DateValue) IN (1,7) THEN 1 ELSE 0 END AS IsWeekend,
    CASE WHEN DATEPART(MONTH, DateValue) >= 7 THEN YEAR(DateValue) + 1 ELSE YEAR(DateValue) END AS FiscalYear,
    CAST(CASE WHEN DATEPART(MONTH, DateValue) >= 7 
              THEN CAST(YEAR(DateValue) AS VARCHAR(4)) + '-07-01'
              ELSE CAST(YEAR(DateValue)-1 AS VARCHAR(4)) + '-07-01'
         END AS DATE) AS FiscalYearStart,
    CAST(CASE WHEN DATEPART(MONTH, DateValue) >= 7 
              THEN CAST(YEAR(DateValue)+1 AS VARCHAR(4)) + '-06-30'
              ELSE CAST(YEAR(DateValue) AS VARCHAR(4)) + '-06-30'
         END AS DATE) AS FiscalYearEnd
FROM Dates
OPTION (MAXRECURSION 0);