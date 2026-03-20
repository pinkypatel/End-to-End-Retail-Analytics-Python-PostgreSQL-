# End-to-End-Retail-Analytics-Python-PostgreSQL

## Project Overview

This project performs an end-to-end analysis of Walmart sales data using Python and PostgreSQL to uncover insights into customer behavior, sales performance, and business trends across multiple branches. The data is extracted using the Kaggle API, processed and cleaned using Pandas and NumPy, and stored in PostgreSQL for advanced SQL-based analysis. The objective is to simulate real-world business analysis and generate actionable insights to support data-driven decision-making..

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

### 9. Business Insights
- Derived meaningful insights and recommendations from analysis

---

## Requirements

- Python 3.8+
- PostgreSQL

### Python Libraries:
- pandas
- numpy
- sqlalchemy
- psycopg2

- Kaggle API Key (for data download)

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

## Project Structure

```plaintext
|-- data/                     # Raw data and transformed data
|-- sql_queries/              # SQL scripts for analysis and queries
|-- notebooks/                # Jupyter notebooks for Python analysis
|-- README.md                 # Project documentation
|-- requirements.txt          # List of required Python libraries
|-- main.py                   # Main script for loading, cleaning, and processing data
```
---

## Results and Insights

- E-wallet is the most preferred payment method, indicating a shift toward digital payments 
- Evening hours show higher transaction volumes across branches 
- Certain product categories consistently receive higher customer ratings 
- Sales patterns vary significantly across branches

## License
This project is licensed under the MIT License. 
---

