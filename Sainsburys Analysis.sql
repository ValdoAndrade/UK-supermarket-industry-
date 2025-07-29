
------------------Sainsburys---------------
select * 
from Sainsburys;

--- dropped irrelevant column for the analysis--
ALTER TABLE Sainsburys
DROP COLUMN prices_unit;

ALTER TABLE Sainsburys
DROP COLUMN Proper_Date;

ALTER TABLE Sainsburys
DROP COLUMN unit;

------finding missing data-------

select *
from Sainsburys 
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

------- find duplicates------
 select names, prices, date, COUNT(*)
 FROM Sainsburys
 group by names, prices, date
 having COUNT(*)>1;

   ---- Ad a temporary id------ assigns a unique ID to each row---

 ALTER TABLE Sainsburys
ADD temp_id INT IDENTITY(1,1); 

----delete the duplicates -----

DELETE FROM Sainsburys
WHERE temp_id NOT IN (
    SELECT MIN(temp_id)
    FROM Sainsburys
    GROUP BY names, prices, date
);


--- SET THE PRICES WITH 2 DECIMALS ONLY===

UPDATE Sainsburys
SET prices = ROUND(prices, 2);



---- Sainsburys  Average price---
Select CAST(ROUND(AVG(prices), 2) AS DECIMAL(10,2)) AS Sainsburys_Average_price
from Sainsburys;


--Average price by category--
Select category,
CAST(ROUND(AVG(prices), 2) AS DECIMAL(10,2)) AS Average_price_by_category
from Sainsburys
group by category;

-----Top 20 cheapest prodcuts ( sainsburys )----
--------------------------------------------
WITH RankedProducts AS (
    SELECT 
        names,
        prices,
        category,
        ROW_NUMBER() OVER (PARTITION BY names ORDER BY prices ASC) AS rn
    FROM Sainsburys
)
SELECT TOP 20
    names,
    prices,
    category
FROM RankedProducts
WHERE rn = 1
ORDER BY prices ASC;

-----aVERAGE PRICE of PRODUCTS OWNED BY Sainsburys----

SELECT CAST(ROUND(avg(prices), 2) AS DECIMAL(10,2)) AS 'Sainsburys PRODUCTS AVERAGE PRICE'
FROM Sainsburys
WHERE own_brand = 'True';

-----aVERAGE PRICE of  PRODUCTS NOT OWNED BY sainsburys----

SELECT CAST(ROUND(avg(prices), 2) AS DECIMAL(10,2)) AS 'AVERAGE PRICE OF NOT OWNED PRODUCTS'
FROM Sainsburys
WHERE own_brand = 'False';

---PERCENTAGE OF PRODUCTS OWNED BY sainsburys---
SELECT 
  CAST(COUNT(CASE WHEN own_brand = 'True' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
  AS percentage_owned_by_SAINSBURYS
FROM Sainsburys;



----PERCENTAGE breakdown of SAINSBURYS-OWNED PRODUCTS BY CATEGORY----

SELECT category,
  CAST(COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM Sainsburys WHERE own_brand = 'true') AS DECIMAL(5,2)) 
       AS percentage_within_owned_products
FROM Sainsburys
WHERE own_brand = 'true'
GROUP BY category;
