
----------------MORRISONS---------
select *
from Morrisons;

--- dropped irrelevant column for the analysis--
ALTER TABLE Morrisons
DROP COLUMN prices_unit;

ALTER TABLE Morrisons
DROP COLUMN Proper_Date;

ALTER TABLE Morrisons
DROP COLUMN unit;

------finding missing data-------

select *
from Morrisons 
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

------- find duplicates------
 select names, prices, date, COUNT(*)
 FROM Morrisons
 group by names, prices, date
 having COUNT(*)>1;

 ----------------- Ad a temporary id------ assigns a unique ID to each row---
 ALTER TABLE Morrisons
ADD temp_id INT IDENTITY(1,1); 

----delete the duplicates -----

DELETE FROM Morrisons
WHERE temp_id NOT IN (
    SELECT MIN(temp_id)
    FROM Morrisons
    GROUP BY names, prices, date
);

--- SET THE PRICES WITH 2 DECIMALS ONLY===

UPDATE Morrisons
SET prices = ROUND(prices, 2);

---- MORRISONS Average price---
Select ROUND(AVG(prices), 2) AS Morrisons_Average_price
from Morrisons;


--Average price by category--
Select category, ROUND(AVG(prices), 2) AS Average_price_by_category
from Morrisons
group by category;

------------------------Top 20 cheapest prodcuts (MORRISONS) ----
------------------------TOP 20 CHEAPEST PRODUCTS--------------------
WITH RankedProducts AS (
    SELECT 
        names,
        prices,
        category,
        ROW_NUMBER() OVER (PARTITION BY names ORDER BY prices ASC) AS rn
    FROM Morrisons
)
SELECT TOP 20
    names,
    prices,
    category
FROM RankedProducts
WHERE rn = 1
ORDER BY prices ASC;


-----aVERAGE PRICE of PRODUCTS OWNED BY Morrisons----

SELECT ROUND(avg(prices), 2) AS 'Morrisons PRODUCTS AVERAGE PRICE'
FROM Morrisons
WHERE own_brand = 'True';

-----aVERAGE PRICE of  PRODUCTS NOT OWNED BY Morrisons----

SELECT ROUND(avg(prices), 2) AS 'AVERAGE PRICE OF NOT OWNED PRODUCTS'
FROM Morrisons
WHERE own_brand = 'False';

---PERCENTAGE OF PRODUCTS OWNED BY Morrisons---
SELECT 
  CAST(COUNT(CASE WHEN own_brand = 'True' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
  AS percentage_owned_by_Morrisons
FROM Morrisons;



----PERCENTAGE breakdown of Morrisons-OWNED PRODUCTS BY CATEGORY----

SELECT category,
  CAST(COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM Morrisons WHERE own_brand = 'true') AS DECIMAL(5,2)) 
       AS percentage_within_owned_products
FROM Morrisons
WHERE own_brand = 'true'
GROUP BY category;
