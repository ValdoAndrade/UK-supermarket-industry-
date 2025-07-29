
-----------------------------T  E  S  C  O ------------------------
SELECT *
FROM Tesco_Table;

--- dropped irrelevant column for the analysis--
ALTER TABLE Tesco_Table
DROP COLUMN prices_unit;

ALTER TABLE Tesco_Table
DROP COLUMN Proper_Date;

ALTER TABLE Tesco_Table
DROP COLUMN unit;

------finding missing data-------

select *
from Tesco_Table 
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

------- find duplicates------
 select names, prices, date, COUNT(*)
 FROM Tesco_Table
 group by names, prices, date
 having COUNT(*)>1;

 ---- Ad a temporary id------ assigns a unique ID to each row---

 ALTER TABLE Tesco_Table
ADD temp_id INT IDENTITY(1,1); 

----delete the duplicates -----

DELETE FROM Tesco_Table
WHERE temp_id NOT IN (
    SELECT MIN(temp_id)
    FROM Tesco_Table
    GROUP BY names, prices, date
);


---- convert the number into words in the own brands field ---- -----

ALTER TABLE Tesco_Table
ALTER COLUMN own_brand VARCHAR(5);

UPDATE Tesco_Table
SET own_brand = CASE
    WHEN own_brand = '1' THEN 'True'
    WHEN own_brand = '0' THEN 'False'
END;


--- SET THE PRICES WITH 2 DECIMALS ONLY===

UPDATE Tesco_Table
SET prices = ROUND(prices, 2);

---- Tesco Average price---
Select ROUND(AVG(prices), 2) AS Tesco_Average_price
from Tesco_Table;


--Average price by category--
Select category, ROUND(AVG(prices), 2) AS Average_price_by_category
from Tesco_Table
group by category;

-----Top 20 cheapest prodcuts ----
--------------(TESCO)----------

WITH RankedProducts AS (
    SELECT 
        names,
        prices,
        category,
        ROW_NUMBER() OVER (PARTITION BY names ORDER BY prices ASC) AS rn
    FROM Tesco_Table
)
SELECT TOP 20
    names,
    prices,
    category
FROM RankedProducts
WHERE rn = 1
ORDER BY prices ASC;

-----aVERAGE PRICE of PRODUCTS OWNED BY TESCO----

SELECT ROUND(avg(prices), 2) AS 'tesco PRODUCTS AVERAGE PRICE'
FROM Tesco_Table
WHERE own_brand = 'True';

-----aVERAGE PRICE of  PRODUCTS NOT OWNED BY TESCO----

SELECT ROUND(avg(prices), 2) AS 'AVERAGE PRICE OF NOT OWNED PRODUCTS'
FROM Tesco_Table
WHERE own_brand = 'False';

---PERCENTAGE OF PRODUCTS OWNED BY TESCO---
SELECT 
  CAST(COUNT(CASE WHEN own_brand = 'True' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
  AS percentage_owned_by_TESCO
FROM Tesco_Table;



----PERCENTAGE breakdown of TESCO-OWNED PRODUCTS BY CATEGORY----

SELECT category,
  CAST(COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM Tesco_Table WHERE own_brand = 'true') AS DECIMAL(5,2)) 
       AS percentage_within_owned_products
FROM Tesco_Table
WHERE own_brand = 'true'
GROUP BY category;
