----------------------------------------------------------------------------------------------------------------------------------------------------
----DATA EXPLORATION
SELECT * FROM Project..chemicals_in_cosmetics

SELECT DISTINCT(CompanyName), COUNT(CompanyName)
FROM Project..chemicals_in_cosmetics
GROUP BY CompanyName
ORDER BY 1

SELECT DISTINCT(ProductName)
FROM Project..chemicals_in_cosmetics
ORDER BY 1

SELECT DISTINCT(ChemicalName)
FROM Project..chemicals_in_cosmetics
ORDER BY 1

SELECT DISTINCT(ProductName),
       InitialDateReported,
	   DiscontinuedDate
FROM Project..chemicals_in_cosmetics
WHERE DiscontinuedDate IS NOT NULL

SELECT DISTINCT(CSF)
FROM Project..chemicals_in_cosmetics
WHERE CSF IS NOT NULL

----------------------------------------------------------------------------------------------------------------------------------------------------
--DATA CLEANING
--Converting Date Columns From  DateTime Format to Just Date Format.
--1)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN InitialDateReported DATE

--2)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN MostRecentDateReported DATE

--3)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN DiscontinuedDate DATE

--4)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN ChemicalCreatedAt DATE

--5)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN ChemicalUpdatedAt DATE

--6)
ALTER TABLE Project..chemicals_in_cosmetics
ALTER COLUMN ChemicalDateRemoved DATE



-- Standardizing Columns, Corrected and replaced Variations in Names Due to Different Spellings, Casing or Puntuations and Capitalizing first letters in each column.
--1)
UPDATE Project..chemicals_in_cosmetics
SET ChemicalDateRemoved = REPLACE(ChemicalDateRemoved, '2103', '2013')

--2)
UPDATE Project..chemicals_in_cosmetics
SET ChemicalDateRemoved = REPLACE(ChemicalDateRemoved, '2104', '2014')

--3)
SELECT DISTINCT(CompanyName), 
       REPLACE(REPLACE(REPLACE(CompanyName, '�', ''), ',', ''), '.', '')
FROM Project..chemicals_in_cosmetics

UPDATE Project..chemicals_in_cosmetics
SET CompanyName = REPLACE(REPLACE(REPLACE(CompanyName, '�', ''), ',', ''), '.', '')


SELECT DISTINCT(CompanyName), COUNT(CompanyName),
CONCAT(UPPER(LEFT(CompanyName,1)),
LOWER(RIGHT(CompanyName,LEN(CompanyName)-1)))
AS MODIFIED
FROM Project..chemicals_in_cosmetics
GROUP BY CompanyName
ORDER BY CompanyName

UPDATE Project..chemicals_in_cosmetics
SET CompanyName = CONCAT(UPPER(LEFT(CompanyName,1)),
LOWER(RIGHT(CompanyName,LEN(CompanyName)-1)))


UPDATE Project..chemicals_in_cosmetics
SET CompanyName = 
                    CASE 
                    WHEN CompanyName LIKE '%Alberto culver%' THEN 'Alberto culver inc'
					WHEN CompanyName LIKE '%American consumer products%' THEN 'American consumer products llc'
					WHEN CompanyName LIKE '%Apollo health and beauty%' THEN 'Apollo health and beauty care inc'
					WHEN CompanyName LIKE '%Athena cosmetics%' THEN 'Athena cosmetics inc'
					WHEN CompanyName LIKE '%Cover fx%' THEN 'Cover fx skincare'
					WHEN CompanyName LIKE '%Interparfums%' THEN 'interparfums inc'
					WHEN CompanyName LIKE '%Lvmh fragrance%' THEN 'Lvmh fragrance brands'
					WHEN CompanyName LIKE '%Sexy hair%' THEN 'Sexy hair concepts'
					WHEN CompanyName LIKE '%Shiseido america%' THEN 'Shiseido coperations'
					WHEN CompanyName LIKE '%Stila%' THEN 'Stila styles llc'
					WHEN CompanyName LIKE '%Neostrata%' THEN 'Neostrata company inc'
		            ELSE CompanyName
		            END

--4)
SELECT DISTINCT(ProductName), REPLACE(REPLACE(REPLACE(ProductName, '�', ''), ',', ''), '.', '')
FROM Project..chemicals_in_cosmetics

UPDATE Project..chemicals_in_cosmetics
SET ProductName = REPLACE(REPLACE(REPLACE(ProductName, '�', ''), ',', ''), '.', '')

SELECT DISTINCT(ProductName), COUNT(ProductName),
CONCAT(UPPER(LEFT(ProductName,1)),
LOWER(RIGHT(ProductName,LEN(ProductName)-1)))
AS MODIFIED
FROM Project..chemicals_in_cosmetics
GROUP BY ProductName
ORDER BY ProductName

UPDATE Project..chemicals_in_cosmetics
SET ProductName = CONCAT(UPPER(LEFT(ProductName,1)),
LOWER(RIGHT(ProductName,LEN(ProductName)-1)))


--5)
SELECT DISTINCT(BrandName), REPLACE(REPLACE(REPLACE(BrandName, '�', ''), ',', ''), '.', '')
FROM Project..chemicals_in_cosmetics

UPDATE Project..chemicals_in_cosmetics
SET BrandName = REPLACE(REPLACE(REPLACE(BrandName, '�', ''), ',', ''), '.', '')

UPDATE Project..chemicals_in_cosmetics
SET BrandName = LTRIM(BrandName)

UPDATE Project..chemicals_in_cosmetics
SET BrandName = REPLACE(BrandName, '-', '')

UPDATE Project..chemicals_in_cosmetics
SET BrandName = CONCAT(UPPER(LEFT(BrandName,1)),
LOWER(RIGHT(BrandName,LEN(BrandName)-1)))

UPDATE Project..chemicals_in_cosmetics
SET BrandName = CASE
                WHEN BrandName LIKE '%Anastasia beverly%' THEN 'Anastasia beverly hills'
                WHEN BrandName LIKE '%Alba%' THEN 'Alba botanica'
                WHEN BrandName LIKE '%Abco lip%' THEN 'Abco lip face protection'
                WHEN BrandName LIKE '%Benefit%' THEN 'Benefit cosmetics'
                WHEN BrandName LIKE '%Boots%' THEN 'Boots botanics'
                WHEN BrandName LIKE '%Chinaglaze%' THEN 'China glaze'
                WHEN BrandName LIKE '%Burt%' THEN 'Burt bees'
                WHEN BrandName LIKE '%Charlotte tilbury%' THEN 'Charlotte tilbury beauty'
                WHEN BrandName LIKE '%Clarins%' THEN 'Clarins paris'
                WHEN BrandName LIKE '%Cover fx%' THEN 'Cover fx skincare inc'
                WHEN BrandName LIKE '%Calvin klein%' THEN 'Calvin klein beauty'
                WHEN BrandName LIKE '%Claudia%' THEN 'Claudia stevens'
                WHEN BrandName LIKE '%Donna%' THEN 'Donna michelle salon'
                WHEN BrandName LIKE '%Gap%' THEN 'Gap outlet'
                WHEN BrandName LIKE '%Issey%' THEN 'Issey miyake'
                WHEN BrandName LIKE '%Jason%' THEN 'Jason natural product'
                WHEN BrandName LIKE '%Kings%' THEN 'Kings and queens'
                WHEN BrandName LIKE '%en provence%' THEN 'Loccitane en provence'
                WHEN BrandName LIKE '%Loreal%' THEN 'Loreal'
                WHEN BrandName LIKE '%Cvs restore%' THEN 'Cvs restore and defend'
                WHEN BrandName LIKE '%lsh%' THEN 'Lush manufacturing ltd'
                WHEN BrandName LIKE '%Lvmh fragrance%' THEN 'Lvmh fragrance brands'
                WHEN BrandName LIKE '%Melvita%' THEN 'Melvita production'
                WHEN BrandName LIKE '%norman%' THEN 'Merle norman cosmetics'
                WHEN BrandName LIKE '%choice%' THEN 'Puala choice'
                WHEN BrandName LIKE '%Plaisir nature%' THEN 'Plaisirs nature'
                WHEN BrandName LIKE '%Pony%' THEN 'Pony effect'
                WHEN BrandName LIKE '%Revlon%' THEN 'Revlon professional'
                WHEN BrandName LIKE '%Richie%' THEN 'Richie creme'
                WHEN BrandName LIKE '%Rituals%' THEN 'Rituals botan body'
                WHEN BrandName LIKE '%Rms%' THEN 'Rms beauty'
                WHEN BrandName LIKE '%Sassy%' THEN 'Sassy & chic'
                WHEN BrandName LIKE '%Seche%' THEN 'Seche vite'
                WHEN BrandName LIKE '%Se style%' THEN 'Sestyle'
                WHEN BrandName LIKE '%Skincare |de|%' THEN 'Skincare |de| cosmetics'
                WHEN BrandName LIKE '%Traditional%' THEN 'Traditional acrylic system powder'
                WHEN BrandName LIKE '%Cosbrands llc%' THEN 'Cos brands llc'
                WHEN BrandName LIKE '%Glominerals%' THEN 'Glo minerals'
                WHEN BrandName LIKE '%Zo skin health%' THEN 'Z skin health'
                WHEN BrandName LIKE '%Up&up%' THEN 'Up & up'
                WHEN BrandName LIKE '%Tarte%' THEN 'Tarte inc'
                WHEN BrandName LIKE '%Tarate%' THEN 'Tarte inc'
                WHEN BrandName LIKE '%Tammy taylor%' THEN 'Tammy taylor nails'
				ELSE BrandName
				END


--6)
SELECT DISTINCT(ChemicalName), REPLACE(REPLACE(REPLACE(ChemicalName, '�', ''), ',', ''), '.', '')
FROM Project..chemicals_in_cosmetics

UPDATE Project..chemicals_in_cosmetics
SET ChemicalName = REPLACE(REPLACE(REPLACE(ChemicalName, '�', ''), ',', ''), '.', '')

UPDATE Project..chemicals_in_cosmetics
SET ChemicalName = 
                   CASE
	               WHEN ChemicalName LIKE '%Coal Tar%' THEN 'Coal tars'
	               WHEN ChemicalName LIKE '%Coffee extract%' THEN 'Coffee bean extract'
	               WHEN ChemicalName LIKE '%Extract of coffee bean%' THEN 'Coffee bean extract'
	               WHEN ChemicalName LIKE '%Formaldehyde%' THEN 'Formaldehyde (gas)'
	               WHEN ChemicalName LIKE '%Lauramide%' THEN 'Lauramide DEA (diethanolamine)'
	               WHEN ChemicalName LIKE '%Cocamide DEA%' THEN 'Cocamide diethanolamine'
	               WHEN ChemicalName LIKE '%Cocamide diethanolamine (DEA)%' THEN 'Cocamide diethanolamine'
               ELSE ChemicalName
              END

--7)
SELECT DISTINCT(CSF), REPLACE(REPLACE(REPLACE(CSF, '�', ''), ',', ''), '.', '')
FROM Project..chemicals_in_cosmetics

UPDATE Project..chemicals_in_cosmetics
SET CSF = REPLACE(REPLACE(REPLACE(CSF, '�', ''), ',', ''), '.', '')

SELECT DISTINCT(CSF), COUNT(CSF),
CONCAT(UPPER(LEFT(CSF,1)),
LOWER(RIGHT(CSF,LEN(CSF)-1)))
AS ModifiedCSF
FROM Project..chemicals_in_cosmetics
GROUP BY CSF
ORDER BY CSF

UPDATE Project..chemicals_in_cosmetics
SET CSF = CONCAT(UPPER(LEFT(CSF,1)),
LOWER(RIGHT(CSF,LEN(CSF)-1)))

UPDATE Project..chemicals_in_cosmetics
SET CSF = REPLACE(CSF, '-', '')


--Viewing Duplicate rows, but i don't want to drop them.
WITH RowNumCTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY
				 ProductName,
				 CompanyName,
				 ChemicalName,
				 CompanyName
                 ORDER BY CDPHId) row_num
				 FROM Project..chemicals_in_cosmetics
)
SELECT * FROM RowNumCTE
WHERE row_num > 1
ORDER BY CompanyName


--Dropping Unnecccessary Columns
ALTER TABLE chemicals_in_cosmetics
DROP COLUMN CompanyId, SubCategoryId, CasId, CasNumber