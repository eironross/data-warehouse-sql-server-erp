USE FONTAINE_DWH;
GO

IF OBJECT_ID('GOLD.vw_DimFacility', 'V') IS NOT NULL
    DROP VIEW GOLD.vw_DimFacility;
GO

CREATE VIEW GOLD.vw_DimFacility
AS
SELECT 
	f.FacilityKey
	,f.LineOfBusiness
	,f.Region
	,f.City
	,f.FacilityName
	,f.Capacity
FROM SILVER.Facility f
WHERE
	IsActive <> 0