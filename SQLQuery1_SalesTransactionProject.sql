
-- Looking at what is in our table.

SELECT *
FROM PortfolioProject..SalesTransaction

--Selecting the data we will be using.

SELECT ProductName, Price, Quantity, Country
FROM PortfolioProject..SalesTransaction

--How many ProductName in the table.

SELECT COUNT(ProductName) AS total_products
FROM PortfolioProject..SalesTransaction

--How many products come from the UNITED KINGDOM

SELECT ProductName,COUNT(Country) AS UK_Product
FROM PortfolioProject..SalesTransaction
WHERE Country='United Kingdom'
GROUP BY ProductName

--Average Price of the ProductName in the United Kingdom.

SELECT ProductName, AVG(Price) AS AVG_UKPrice
FROM PortfolioProject..SalesTransaction
WHERE Country='United Kingdom'
GROUP BY ProductName, Country 
ORDER BY AVG_UKPrice DESC

-- Price divided by the quanity

SELECT Country,Price, Quantity, (Price/Quantity)*100 AS Percentage_Unit
FROM PortfolioProject..SalesTransaction
WHERE Country= 'Australia'
ORDER BY Percentage_Unit DESC

---Looking at ProductName with the highest price according to Country.

SELECT ProductName, Country, MAX (Price) AS max_price
FROM PortfolioProject..SalesTransaction
GROUP BY ProductName, Country 
ORDER BY max_price DESC

--Selecting all data and Using Windows function to look for the max price again.

SELECT e.*,
MAX(Price) OVER() AS Max_price
FROM PortfolioProject..SalesTransaction e

--Using partition by (Product Name) to run the above query.

SELECT e.*,
MAX(Price) OVER(Partition by ProductName) AS Max_price
FROM PortfolioProject..SalesTransaction e


--Looking at the total price of the Product vs the country it was sold from.

SELECT ProductName, Country, SUM(Price) AS total_price
FROM PortfolioProject..SalesTransaction
GROUP BY ProductName, Country
ORDER BY Country, total_price DESC
--OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY

---Breaking it down by Country limiting to the top 5 with the highest price.

SELECT Country, ProductName, MAX(Price) AS max_price
FROM PortfolioProject..SalesTransaction
WHERE Country IS NOT NULL
GROUP BY Country, ProductName
ORDER BY Country, max_price DESC
OFFSET 4 ROWS FETCH NEXT 5 ROWS ONLY

--Selecting productName starting with letters AB according to country starting with A-	INCLUDING prices and quantity.

SELECT ProductName,Price, Quantity, Country
FROM PortfolioProject..SalesTransaction
WHERE Country LIKE '%A' 
AND ProductName LIKE 'AB%'
--ORDER BY 1,2 

---Using CASE-- which products to restock based on the Quantity sold.

SELECT ProductName, Quantity,
CASE
WHEN Quantity <5 THEN 'No restocking'
WHEN Quantity <10 THEN 'Restock moderately'
WHEN Quantity >50 THEN 'Restock more often'
ELSE 'Restock'
END AS Quantity_stock
FROM PortfolioProject..SalesTransaction

--Fetch the top 3 Product names.

SELECT e.*,
RANK() OVER (PARTITION BY ProductName ORDER BY Price DESC) AS Rnk
FROM PortFolioProject..SalesTransaction e



