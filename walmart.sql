SELECT * FROM walmart;

--1. Analyze Payment Methods and Sales
--● Question: What are the different payment methods, and how many transactions and items were sold with each method?

SELECT 
	payment_method,
	COUNT(invoice_id) AS total_transactions,
	SUM(quantity) AS total_items_sold
FROM walmart
GROUP BY payment_method;

--2. Identify the Highest-Rated Category in Each Branch
--● Question: Which category received the highest average rating in each branch?

SELECT * 
FROM 
(SELECT 
	branch, 
	category, 
	AVG(rating) AS avg_rating,
	ROW_NUMBER() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) as rank
from walmart
GROUP BY branch, category
) t
WHERE rank = 1

--3. Determine the Busiest Day for Each Branch
--● Question: What is the busiest day of the week for each branch based on transaction volume?

SELECT 
	branch,
	TRIM(TO_CHAR(TO_DATE(date, 'DD/MM/YY'),'Day')) AS weekday,
	COUNT(invoice_id) AS total_transactions
FROM walmart
GROUP BY branch, 
		TRIM(TO_CHAR(TO_DATE(date, 'DD/MM/YY'),'Day'));


--4. Calculate Total Quantity Sold by Payment Method
--● Question: How many items were sold through each payment method?

SELECT 
	payment_method,
	SUM(quantity) as total_quantity
FROM walmart
GROUP BY payment_method;

SELECT * FROM walmart;
-- 5. Analyze Category Ratings by City
-- ● Question: What are the average, minimum, and maximum ratings for each category in each city?
SELECT 
	city,
	category,
	MIN(rating) AS minimum_rating,
	AVG(rating) AS average_rating,
	MAX(rating) AS maximum_rating
FROM walmart
GROUP BY city, category
ORDER BY city, category;

--6. Calculate Total Profit by Category
--● Question: What is the total profit for each category, ranked from highest to lowest?
SELECT 
category,
SUM(total * profit_margin) AS total_profit
FROM walmart
GROUP BY category 
ORDER BY total_profit DESC;

--7. Determine the Most Common Payment Method per Branch
--Question: What is the most frequently used payment method in each branch?
SELECT * FROM walmart;

SELECT 
	* 
	FROM 
	(SELECT 
	branch, 
	payment_method, 
	COUNT(payment_method) AS Total_method,
	ROW_NUMBER() OVER(
	PARTITION BY branch ORDER BY COUNT(payment_method) DESC) as rank 
FROM walmart
GROUP BY branch, payment_method
ORDER BY branch, COUNT(payment_method) DESC) t
WHERE rank=1;


--8. Analyze Sales Shifts Throughout the Day
--● Question: How many transactions occur in each shift (Morning, Afternoon, Evening) across branches?
SELECT
	branch,
	part_of_day,
	COUNT(*) AS total_transactions
	FROM
		(SELECT
				branch,  
    					CASE 
					        WHEN EXTRACT(HOUR FROM time::time) < 12 THEN 'Morning'
					        WHEN EXTRACT(HOUR FROM time::time) BETWEEN 12 AND 17 THEN 'Afternoon'
					        ELSE 'Evening'
					    END AS part_of_day
		FROM walmart) t
	GROUP BY branch, part_of_day
	ORDER BY branch, part_of_day;



--9. Identify Branches with Highest Revenue Decline Year-Over-Year
--● Question: Which branches experienced the largest decrease in revenue compared to the previous year?

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
		--current_year.branch,
		current_year.revenue_2023,
		-- rdr == previous_year.revenue_2022-current_year.revenue_2023/previous_year.revenue_2022*100
		ROUND((previous_year.revenue_2022-current_year.revenue_2023)::numeric/previous_year.revenue_2022::numeric * 100, 2) 
		AS rev_dec_ratio
	FROM revenue_2022 AS previous_year
	JOIN revenue_2023 AS current_year
	ON previous_year.branch = current_year.branch
	WHERE previous_year.revenue_2022 > current_year.revenue_2023
	ORDER BY 4 DESC
	LIMIT 5
;
