# End-to-End-Retail-Analytics-Python-PostgreSQL

## Project Overview

This project performs an end-to-end analysis of Walmart sales data using Python and PostgreSQL to uncover insights into customer behavior, sales performance, and business trends across multiple branches. The data is extracted using the Kaggle API, processed and cleaned using Pandas and NumPy, and stored in PostgreSQL for advanced SQL-based analysis. The objective is to simulate real-world business analysis and generate actionable insights to support data-driven decision-making..

---

## Tools and Technologies

- Python 3.8+
- PostgreSQL

### Python Libraries:
- pandas
- numpy
- sqlalchemy
- psycopg2

- Kaggle API Key (for data download)

---

## Project Workflow

### 1. Environment Setup
- Tools: VS Code, Python, PostgreSQL
- Created project structure for organized development

### 2. Data Extraction
- Used Kaggle API to download Walmart sales dataset
- Configured API using Kaggle credentials

### 3. Data Loading (Python)
- Loaded dataset into Pandas DataFrame
- Performed initial inspection of data

### 4. Data Exploration
- Analyzed structure using `.info()`, `.describe()`, `.head()`
- Identified missing values and inconsistencies

### 5. Data Cleaning
- Removed duplicates
- Handled missing values
- Converted data types (date, time, numeric fields)

### 6. Feature Engineering
- Created new columns (e.g., total = unit_price × quantity)
- Prepared dataset for SQL analysis

### 7. Database Integration
- Connected Python to PostgreSQL using SQLAlchemy and psycopg2
- Created tables and loaded cleaned data

### 8. Data Analysis (SQL)
- Wrote SQL queries to analyze business problems
- Used aggregation, grouping, CTEs, and window functions
  
---

## Dataset Description

   -invoice_id – Unique transaction ID
   -branch – Store branch
   -city – Store location
   -category – Product category
   -unit_price – Price per item
   -quantity – Number of items sold
   -date – Transaction date
   -time – Transaction time
   -payment_method – Payment type
   -rating – Customer rating
   -profit_margin – Profit percentage

---

## Key Business Questions (Walmart Business Problems.pdf)
   1. Payment Methods and Sales Analysis
   2. Highest-Rated Category by Branch
   3. Busiest Day by Branch
   4. Sales Volume by Payment Method
   5. Category Ratings by City
   6. Profit Analysis by Category
   7. Most Common Payment Method per Branch
   8. Sales Distribution by Time of Day
   9. Revenue Decline Analysis (Year-over-Year)
   ```bash
    WITH revenue_2023 AS
	(
	    SELECT 
	        branch,
	        SUM(total) as revenue_2023
	    FROM walmart
	    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	    GROUP BY branch
	),
	
	revenue_2022 AS
	(
	    SELECT 
	        branch,
	        SUM(total) as revenue_2022
	    FROM walmart
	    WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
	    GROUP BY branch
	)

	SELECT
		previous_year.branch,
		previous_year.revenue_2022,
		current_year.revenue_2023,
		-- Formula: rdr == previous_year.revenue_2022-current_year.revenue_2023/previous_year.revenue_2022*100
		ROUND((previous_year.revenue_2022-current_year.revenue_2023)::numeric/previous_year.revenue_2022::numeric * 100, 2) 
		AS rev_dec_ratio
	FROM revenue_2022 AS previous_year
	JOIN revenue_2023 AS current_year
	ON previous_year.branch = current_year.branch
	WHERE previous_year.revenue_2022 > current_year.revenue_2023
	ORDER BY 4 DESC
	LIMIT 5
;
   ```
---

## Results and Insights

- E-wallet is the most preferred payment method, indicating a shift toward digital payments 
- Evening hours show higher transaction volumes across branches 
- Certain product categories consistently receive higher customer ratings 
- Sales patterns vary significantly across branches

---
  
## Getting Started

1. Clone the repository:
   ```bash
   git clone <repo-url>
   ```
2. Install Python libraries:
   ```bash
   pip install -r requirements.txt
   ```
3. Set up your Kaggle API, download the data, and follow the steps to load and analyze.

---

## License
This project is licensed under the MIT License. 
---

