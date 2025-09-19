DECLARE @StartDate DATE = '2000-01-01';
DECLARE @EndDate   DATE = '2030-12-31';

;WITH Dates AS (
    SELECT @StartDate AS TheDate
    UNION ALL
    SELECT DATEADD(DAY, 1, TheDate)
    FROM Dates
    WHERE TheDate < @EndDate
)
INSERT INTO DimDate
SELECT 
    CONVERT(CHAR(8), TheDate, 112) AS DateKey,       -- YYYYMMDD
    TheDate AS FullDate,
    DAY(TheDate) AS DayNumber,
    DATENAME(WEEKDAY, TheDate) AS DayName,
    DATEPART(WEEK, TheDate) AS WeekNumber,
    MONTH(TheDate) AS MonthNumber,
    DATENAME(MONTH, TheDate) AS MonthName,
    DATENAME(MONTH, TheDate) + ' ' + CAST(YEAR(TheDate) AS VARCHAR(4)) AS MonthNameYear,
    DATEPART(QUARTER, TheDate) AS QuarterNumber,
    'Q' + CAST(DATEPART(QUARTER, TheDate) AS VARCHAR(1)) AS QuarterName,
    YEAR(TheDate) AS YearNumber,
    CASE WHEN DATENAME(WEEKDAY, TheDate) IN ('Saturday','Sunday') THEN 1 ELSE 0 END AS IsWeekend,

    -- Fiscal Year: starts July 1
    CASE 
        WHEN MONTH(TheDate) >= 7 THEN YEAR(TheDate) + 1 -- July-Dec → next year
        ELSE YEAR(TheDate)                              -- Jan-Jun → current year
    END AS FiscalYear,

    -- Fiscal Year Start (always July 1 of prior year if Jan-Jun, else July 1 of current year)
    CASE 
        WHEN MONTH(TheDate) >= 7 
            THEN CAST(CAST(YEAR(TheDate) AS CHAR(4)) + '-07-01' AS DATE)
        ELSE CAST(CAST(YEAR(TheDate)-1 AS CHAR(4)) + '-07-01' AS DATE)
    END AS FiscalYearStart,

    -- Fiscal Year End (always June 30 of fiscal year)
    CASE 
        WHEN MONTH(TheDate) >= 7 
            THEN CAST(CAST(YEAR(TheDate)+1 AS CHAR(4)) + '-06-30' AS DATE)
        ELSE CAST(CAST(YEAR(TheDate) AS CHAR(4)) + '-06-30' AS DATE)
    END AS FiscalYearEnd

FROM Dates
OPTION (MAXRECURSION 0);