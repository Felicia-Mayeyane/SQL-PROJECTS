
-- Checking out the data I am working with and what needs to be cleaned
SELECT *
FROM PortfolioProject..movies

--Removing duplicates using distinct syntax. we don't have too many rows that's why i am using distinct

SELECT DISTINCT *
FROM PortfolioProject..movies

--Removing special characters from the year ..permanently removed the special characters and extra space

UPDATE PortfolioProject..movies
SET YEAR = SUBSTRING(YEAR, PATINDEX('%[0-9]%', YEAR), LEN(YEAR))
WHERE YEAR LIKE '%[^0-9]%'

-- Repeated the same code to trim the year to the first four digits  ( This will be used as the "cleaned year" for the YEAR row)

UPDATE PortfolioProject..movies
SET YEAR = SUBSTRING(YEAR, PATINDEX('%[0-9]%', YEAR), 4)

--Checking how the data looks after Updates. The YEAR colum has been permanently UPDATED

SELECT * FROM PortfolioProject..movies

---Removing null values in RATING and VOTES by replacing them with 0 instead

UPDATE PortfolioProject..movies
SET RATING= 0 , VOTES=0
	WHERE RATING IS NULL AND VOTES IS NULL

--Checking if the changes worked on the data

SELECT * FROM PortfolioProject..movies

---The Null in votes were not changed, Repeating the code to update individually

UPDATE PortfolioProject..movies
SET VOTES=0
WHERE VOTES IS NULL

--Changing the Null values in Runtime to 0 also

UPDATE PortfolioProject..movies
SET RunTime=0
WHERE RunTime IS NULL

---Dropping Gross and Cleaned_year table because both columns have no valuable data to be used

ALTER TABLE PortfolioProject..movies
DROP COLUMN Gross, Cleaned_year;

--Trimming trailing spaces in the STARS column

UPDATE PortfolioProject..movies
SET STARS = LTRIM(RTRIM(STARS))













