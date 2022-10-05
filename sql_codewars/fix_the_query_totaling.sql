--SQL Bug Fixing: Fix the QUERY - Totaling
--https://www.codewars.com/kata/582cba7d3be8ce3a8300007c
--Totaling the number of sales on a given day grouped by each department name and then each day

SELECT
  DATE(s.transaction_date) AS day,
  d.name AS department,
  COUNT(s.id) AS sale_count
  FROM department d
    JOIN sale s on d.id = s.department_id
    GROUP BY day, d.name
    ORDER BY day 
