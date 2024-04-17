----------------------------------------------------------------------------------------------------------------------------------------------------
----INSIGHTS
--Q1
--How many unique chemicals are reported in the dataset, and what is their distribution across different Product?
WITH RankedChemicals AS
(
SELECT ProductName, 
       ChemicalName,
       ROW_NUMBER() OVER (PARTITION BY ProductName, ChemicalName ORDER BY ChemicalName) AS Rownum
FROM Project..chemicals_in_cosmetics
) 
SELECT 
       ProductName,
	   ChemicalName, 
       ROW_NUMBER() OVER (PARTITION BY ChemicalName ORDER BY ChemicalName) AS UniqueChemicalCount
FROM RankedChemicals


--Q2
--What is the distribution of Products across different Primary categories and sub-categories?
SELECT DISTINCT ProductName, SubCategory, PrimaryCategory,
COUNT(ProductName) AS ProductCount
FROM Project..chemicals_in_cosmetics
GROUP BY PrimaryCategory, SubCategory, ProductName
ORDER BY 2,3

--Q3
--Which Brands had chemicals that were removed and discontinued and identify the chemicals?
SELECT BrandName, ChemicalName, COUNT(BrandName) AS TotalCount
FROM Project..chemicals_in_cosmetics
WHERE ChemicalDateRemoved IS NOT NULL
AND DiscontinuedDate IS NOT NULL
GROUP BY BrandName, ChemicalName
ORDER BY BrandName 

--Q4
--Which companies have the most reported chemicals in their cosmetics and personal care products? 
SELECT TOP 20 CompanyName, 
COUNT(CompanyName) AS ReportCount
FROM Project..chemicals_in_cosmetics
WHERE MostRecentDateReported IS NOT NULL
GROUP BY CompanyName
ORDER BY ReportCount DESC

--Q5
--Find out which chemicals were used the most?
SELECT TOP 20 ChemicalName,
COUNT(ChemicalName) AS TotalChemicals
FROM Project..chemicals_in_cosmetics
GROUP BY ChemicalName
ORDER BY TotalChemicals DESC

--Q6
--Which Products have been reported to contain the highest number of chemicals?
SELECT DISTINCT ProductName, PrimaryCategory,
ChemicalCount
FROM Project..chemicals_in_cosmetics
GROUP BY ProductName, PrimaryCategory, ChemicalCount
ORDER BY ChemicalCount DESC

--Q7
--Can you identify the period between the creation of the removed chemicals and when they were actually removed?
SELECT ChemicalName,
       MIN(YEAR(ChemicalCreatedAt)) AS YearCreated,
	   MAX(YEAR(ChemicalDateRemoved)) AS YearRemoved,
	   MAX(DATEDIFF(DAY, ChemicalCreatedAt, ChemicalDateRemoved)) AS DaysBetween
FROM Project..chemicals_in_cosmetics
WHERE ChemicalDateRemoved IS NOT NULL
GROUP BY ChemicalName
ORDER BY ChemicalName

UPDATE Project..chemicals_in_cosmetics
SET ChemicalCreatedAt = ChemicalDateRemoved,
    ChemicalDateRemoved = ChemicalCreatedAt
WHERE  ChemicalDateRemoved < ChemicalCreatedAt


--Q8
--Have there been any Products that were later discontinued, if applicable, the Brand and date the Product was discontinued?
SELECT DISTINCT ProductName, BrandName, InitialDateReported,
DiscontinuedDate
FROM Project..chemicals_in_cosmetics
WHERE DiscontinuedDate IS NOT NULL
AND InitialDateReported IS NOT NULL
ORDER BY ProductName, BrandName

UPDATE Project..chemicals_in_cosmetics
SET InitialDateReported = DiscontinuedDate,
    DiscontinuedDate = InitialDateReported
WHERE  DiscontinuedDate < InitialDateReported


--Q9
--Identify the relationship between CSF and chemicals used in the most manufactured subcategories?
SELECT ChemicalName, CSF, SubCategory, 
COUNT(SubCategory) AS MostManufactured
FROM Project..chemicals_in_cosmetics
WHERE CSF != ''
GROUP BY ChemicalName, CSF, SubCategory
ORDER BY MostManufactured DESC