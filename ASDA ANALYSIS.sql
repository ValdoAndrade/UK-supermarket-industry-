
----------------------------A   S  D    A-------------------------
SELECT *
FROM All_Data_Asda;

--- dropped irrelevant column for the analysis--
ALTER TABLE All_Data_Asda
DROP COLUMN prices_unit;

ALTER TABLE All_Data_Asda
DROP COLUMN Proper_Date;

ALTER TABLE All_Data_Asda
DROP COLUMN unit;

------finding missing data-------

select *
from All_Data_Asda 
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

----remove rows with missing values-----------

DELETE FROM All_Data_Asda
where supermarket is Null
OR prices is Null
OR date is Null
OR category is Null 
OR own_brand is Null
OR names is NULL;

------- find duplicates------
 select names, prices, date, COUNT(*)
 FROM All_Data_Asda
 group by names, prices, date
 having COUNT(*)>1;

  ---- Ad a temporary id------ assigns a unique ID to each row---

 ALTER TABLE All_Data_Asda
ADD temp_id INT IDENTITY(1,1); 

----delete the duplicates -----

DELETE FROM All_Data_Asda
WHERE temp_id NOT IN (
    SELECT MIN(temp_id)
    FROM All_Data_Asda
    GROUP BY names, prices, date
);

---- convert the number into words in the own brands field ---- -----

ALTER TABLE All_Data_Asda
ALTER COLUMN own_brand VARCHAR(5);

UPDATE All_Data_Asda
SET own_brand = CASE
    WHEN own_brand = '1' THEN 'True'
    WHEN own_brand = '0' THEN 'False'
END;


--- SET THE PRICES WITH 2 DECIMALS ONLY===

UPDATE All_Data_Asda
SET prices = ROUND(prices, 2);


---- ASDA Average price---
Select ROUND(AVG(prices), 2) AS Asda_Average_price
from All_Data_Asda;


--Average price by category--
Select category, ROUND(AVG(prices), 2) AS Average_price_by_category
from All_Data_Asda
group by category;

-----Top 20 cheapest prodcuts ----
---------------------------------
WITH RankedProducts AS (
    SELECT 
        names,
        prices,
        category,
        ROW_NUMBER() OVER (PARTITION BY names ORDER BY prices ASC) AS rn
    FROM All_Data_ASDA
)
SELECT TOP 20
    names,
    prices,
    category
FROM RankedProducts
WHERE rn = 1
ORDER BY prices ASC;

-----aVERAGE PRICE of PRODUCTS OWNED BY ASDA----

SELECT ROUND(avg(prices), 2) AS 'ASDA PRODUCTS AVERAGE PRICE'
FROM All_Data_Asda
WHERE own_brand = 'True';

-----aVERAGE PRICE of  PRODUCTS NOT OWNED BY ASDA----

SELECT ROUND(avg(prices), 2) AS 'AVERAGE PRICE OF NOT OWNED PRODUCTS'
FROM All_Data_Asda
WHERE own_brand = 'False';

---PERCENTAGE OF PRODUCTS OWNED BY asda---
SELECT 
  CAST(COUNT(CASE WHEN own_brand = 'True' THEN 1 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) 
  AS percentage_owned_by_ASDA
FROM All_Data_Asda;



----PERCENTAGE breakdown of ASDA-OWNED PRODUCTS BY CATEGORY----

SELECT category,
  CAST(COUNT(*) * 100.0 / 
       (SELECT COUNT(*) FROM All_Data_Asda WHERE own_brand = 'true') AS DECIMAL(5,2)) 
       AS percentage_within_owned_products
FROM All_Data_Asda
WHERE own_brand = 'true'
GROUP BY category;
