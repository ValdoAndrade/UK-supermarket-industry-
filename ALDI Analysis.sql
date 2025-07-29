
-------------------------A  L  D  I  -----------------------
SELECT *
FROM Aldi_Table;

--- dropped irrelevant column for the analysis--
ALTER TABLE Aldi_Table
DROP COLUMN prices_unit;

ALTER TABLE Aldi_Table
DROP COLUMN Proper_Date;

ALTER TABLE Aldi_Table
DROP COLUMN unit;


------finding missing data-------

select *
from Aldi_Table 
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

------- find duplicates------
 select names, prices, date, COUNT(*)
 FROM Aldi_Table
 group by names, prices, date
 having COUNT(*)>1;


---- convert the number into words -----

ALTER TABLE Aldi_Table
ALTER COLUMN own_brand VARCHAR(5);


UPDATE Aldi_Table
SET own_brand = CASE
    WHEN own_brand = '1' THEN 'True'
    WHEN own_brand = '0' THEN 'False'
END;

--- SET THE PRICES WITH 2 DECIMALS ONLY===
UPDATE Aldi_Table
SET prices = ROUND(prices, 2);



---- Average price by category-----

SELECT category,
ROUND(AVG(prices), 2) AS 'Average price by category'
From Aldi_Table
GROUP by category
ORDER by category;

-----------Top 20 cheapest prodcuts ( ALDI)----------
----------------------------------------------------
WITH RankedProducts AS (
    SELECT 
        names,
        prices,
        category,
        ROW_NUMBER() OVER (PARTITION BY names ORDER BY prices ASC) AS rn
    FROM Aldi_Table
)
SELECT TOP 20
    names,
    prices,
    category
FROM RankedProducts
WHERE rn = 1
ORDER BY prices ASC;

----Average price--------------
SELECT ROUND(avg(prices), 2) AS 'ALDI AVERAGE PRICE'
FROM Aldi_Table;

-----aVERAGE PRICE of PRODUCTS OWNED BY ALDI----

SELECT ROUND(avg(prices), 2) AS 'ALDI PRODUCTS AVERAGE PRICE'
FROM Aldi_Table
WHERE own_brand = 'True';

-----aVERAGE PRICE of  PRODUCTS NOT OWNED BY ALDI----

SELECT ROUND(avg(prices), 2) AS 'AVERAGE PRICE OF NOT OWNED PRODUCTS'
FROM Aldi_Table
WHERE own_brand = 'False';

---PERCENTAGE OF PRODUCTS OWNED BY ALDI---
SELECT 
  CAST(COUNT(CASE WHEN own_brand = 'True' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
  AS percentage_owned_by_aldi
FROM Aldi_Table;



----PERCENTAGE breakdown of ALDI-OWNED PRODUCTS BY CATEGORY----

SELECT category,
  CAST(COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM Aldi_Table WHERE own_brand = 'true') AS DECIMAL(5,2)) 
       AS percentage_within_owned_products
FROM Aldi_Table
WHERE own_brand = 'true'
GROUP BY category;

