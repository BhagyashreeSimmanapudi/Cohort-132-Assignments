-- Q1. . The customers table contains columns: customer_id, customer_name, age, and region. Write a query to categorize customers into age groups: 
-- • "Teen" if age < 18 
-- • "Young Adult" if age between 18 and 35 
-- • "Adult" if age between 36 and 60 
-- • "Senior" if age > 60.
SELECT customer_id,
       customer_name,
       age,
       region,
       CASE
         WHEN age < 18 THEN 'Teen'
         WHEN age BETWEEN 18 AND 35 THEN 'Young Adult'
         WHEN age BETWEEN 36 AND 60 THEN 'Adult'
         ELSE 'Senior'
       END AS age_group
FROM customers;

-- Q2.  In the employees table, classify employees into salary bands using a CASE statement: 
-- • "Low" for salaries < 30000 
-- • "Medium" for salaries between 30000 and 70000 
-- • "High" for salaries > 70000. 
SELECT employee_id,
       employee_name,
       salary,
       CASE
         WHEN salary < 30000 THEN 'Low'
         WHEN salary BETWEEN 30000 AND 70000 THEN 'Medium'
         ELSE 'High'
       END AS salary_band
FROM employees;

-- Q3.  In the students table, write a query to assign a RANK to each student within their class based on their total_score, with the highest score ranked first. 
SELECT student_id,
       class_id,
       total_score,
       RANK() OVER (PARTITION BY class_id ORDER BY total_score DESC) AS rank_in_class
FROM students;

-- Q4.  Using the departments table, calculate the average salary for each department and find the difference between each employee’s salary and the department average. 
SELECT e.employee_id,
       e.department_id,
       e.salary,
       AVG(e.salary) OVER (PARTITION BY e.department_id) AS dept_avg,
       e.salary - AVG(e.salary) OVER (PARTITION BY e.department_id) AS diff_from_avg
FROM employees e;

-- Q5. Write a query to count the number of orders where the order_amount exceeds the average order_amount across all orders. 
SELECT COUNT(*) AS orders_above_avg
FROM orders
WHERE order_amount > (SELECT AVG(order_amount) FROM orders);

-- Q6.  In the sales table, calculate the percentage contribution of each sale_amount to the total sales for its product_id. 
SELECT product_id,
       sale_id,
       sale_amount,
       (sale_amount / SUM(sale_amount) OVER (PARTITION BY product_id)) * 100 AS percent_contribution
FROM sales;

-- Q7. Using the students table, write a query to find students whose scores are above the class average. 
SELECT student_id,
       class_id,
       total_score
FROM students s
WHERE total_score > (
    SELECT AVG(total_score)
    FROM students
    WHERE class_id = s.class_id
);

-- Q8.  In the employees table, identify employees who earn more than the average salary in their department. 
SELECT employee_id,
       department_id,
       salary
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- Q9.  Using the products table, write a query to replace all NULL values in the price column with the average price of all products.
UPDATE products
SET price = (SELECT AVG(price) FROM products)
WHERE price IS NULL;

-- Q10. Using the sales table, calculate the cumulative sales for each product_id and classify the sales performance into categories: 
-- • "Underperforming" if cumulative sales < 5000 
-- • "Meeting Expectations" if cumulative sales between 5000 and 10000 
-- • "Exceeding Expectations" if cumulative sales > 10000.
SELECT product_id,
       sale_id,
       sale_amount,
       SUM(sale_amount) OVER (PARTITION BY product_id ORDER BY sale_id) AS cumulative_sales,
       CASE
         WHEN SUM(sale_amount) OVER (PARTITION BY product_id ORDER BY sale_id) < 5000 THEN 'Underperforming'
         WHEN SUM(sale_amount) OVER (PARTITION BY product_id ORDER BY sale_id) BETWEEN 5000 AND 10000 THEN 'Meeting Expectations'
         ELSE 'Exceeding Expectations'
       END AS performance
FROM sales;