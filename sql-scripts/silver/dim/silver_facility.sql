/* 
    File: silver_facility.sql
    Purpose: Load once data from Bronze.Customer to Silver.Customer
    Note: This script is intended to be run once after the initial load of Bronze.Customer
*/    


USE FONTAINE_DWH;
GO

TRUNCATE TABLE SILVER.Customer;
GO

INSERT INTO SILVER.Facility (
	FacilityKey
	,LineOfBusiness
    ,Region
    ,City
    ,FacilityName
    ,Capacity
    ,IsActive
    ,BeginOps
)
SELECT 
	f.FacilityKey
	,CASE
		WHEN f.FacilityKey IN (1, 2, 5, 6, 8) THEN 'Fontaine, Inc.'
		WHEN f.FacilityKey IN (3, 4, 9) THEN 'Nathlan Sales Inc.'
		ELSE 'Sumeru Technologies'
	END AS [LineOfBusiness]
	,TRIM(f.Region) AS [Region]
	,TRIM(f.City) AS [City]
	,TRIM(f.Facility) AS [FacilityName]
	,f.Capacity
	,f.IsActive
	,f.BeginOps
FROM BRONZE.Facility f