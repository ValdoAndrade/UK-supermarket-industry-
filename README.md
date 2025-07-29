### 🛒 Supermarket Pricing Analysis – SQL Project




## 📌 Project Objective

This project explores product pricing trends across five major UK supermarkets  ( Aldi, Tesco, Morrinson, Sainsburys and Asda) using over 100,000 product records from multiple categories.This project consist of an EDA ( Exploratory data analysis) aimed to evaluate  pricing strategies, own-brand penetration, product-level value and provide recomendations based on the findings.





## 🧩 Dataset
The dataset utilised in this project (source)
[https://www.kaggle.com/datasets/declanmcalinden/time-series-uk-supermarket-data](url)
------
- 5 Excel/CSV files (one per supermarket)
(Aldi, Tesco, Morrisons, Sainsbury's and Asda)
- ~100,000 product entries
- Data collected for the months of March and April 




## 🛠️ Tools Used

- SQL Server (SSMS) for storage, cleaning & analysis
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


## Insights  
Aldi is the supermarket with the lowest average product price at 2.34. In contrast, the other supermarkets have a average product price significantly higher.
Own-brand products are cheaper across all the supermarkets, however ALDI is the only supermarket that the average own-brand price is higher than the average non-owned-brand price.
The drinks are the the most expensive category across all supermarkets.
The fresh food category is consistently a core own brand focus across all supermarkets. 

## Recomendations
Aldi can aim to increase its own-brand penetration in the Home category by 10%. This would allow the supermarket to capture additional market share in a category where competitors like Tesco (25.4% own-brand penetration) and Sainsbury’s (13.9%) currently have a strong presence. Therefore, this measure would attract more customers and also compete with the other supermarkets that are currently present in this market. 
The retailers should evaluate why drinks are the category that have the highest prices and implement promotional strategies to improve the competitiveness in this category.
Also they could reevaluate their pack sizes in order to make the prices look more affordable.
Supermarkets like Morrisons and Sainsburys should promote more often their own brands as they offer significant lower prices and can help to drive a better value perception amongst consumers.
According to the findings ASDA and Morrisons should consider expand their own brand presence in HOME  because  TESCO has 25.425 of own-brand in Home and Sainsburys has 13.96%.

## Conclusion
 This exploratory data analysis provided valuable insights into supermarket pricing strategies, own-brand product penetration, and category-level value positioning. Equally important, this analysis help retailers understand where they stand in terms of price, brand positioning, and value delivery across product categories.

 
## How to use 
1. **Start with the README**
   - Read the README to understand the project

2. **View the SQL Queries**
   - Go to the `/queries/` folder or supermarket-specific folders to see the SQL scripts used to answer each business question.
   - Each SQL file corresponds to a supermarket analysis 

3. **Review the Findings**
   - Check the **Insights & Recommendations** section in this README for a summary of key observations.
   
