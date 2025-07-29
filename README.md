### 🛒 Supermarket Pricing Analysis – SQL Project




## 📌 Project Objective

This project explores product pricing trends across five major UK supermarkets  ( Aldi, Tesco, Morrinson, Sainsburys and Asda) using over 100,000 product records from multiple categories.This project consist of an EDA ( Exploratory data analysis) aimed to evaluate  pricing strategies, own-brand penetration, product-level value and provide recomendations based on the findings.





## 🧩 Dataset

- 5 Excel/CSV files (one per supermarket)
(Aldi, Tesco, Morrisons, Sainsbury's and Asda)
- ~100,000 product entries
- Data collected for the months of March and April 




## 🛠️ Tools Used

- SQL Server (SSMS) for storage, cleaning & analysis
- 
- Excel for initial data prep






## 🧼 Data Cleaning

- Standardised the product names using Excel
- Flagged and removed products priced < £0.10
-Removed duplicates and records with missing values 
- Dropped irrelevant columns for the analysis 
- Removed or adjusted invalid entries, outliers (e.g., incorrect prices)





The project is structured with a dedicated folder for each retailer, each containing SQL files for specific business questions and the data cleaning process.

## 🧠 Business Questions Answered
Each supermarket is analyzed using the following questions:


1. **What is the average price of the supermarket?**

2. **What is the average price by product category ?**

3. **What are the top 20 cheapest products?**

4. **What is the average price of the products owned by the supermarket?**

5. **What is the average price of the products not owned by the supermarket?**

6. **What is the percentage of the products owned by the supermaket**

7. **"What is the percentage breakdown of Tesco-owned products across different product categories?"**


##  SAMPLE SQL Query: The average price of product category at Tesco


```sql
SELECT 
  category,
  ROUND(AVG(prices), 2) AS Average_price_by_category
FROM Tesco_Table
GROUP BY category;
```

## Insights & Recomendations 






## Conclusion
 This exploratory data analysis provided valuable insights into supermarket pricing strategies, own-brand product penetration, and category-level value positioning. Equally important, this analysis help retailers understand where they stand in terms of price, brand positioning, and value delivery across product categories.

 
## How to use 

