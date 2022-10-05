--Analyzing the sales by product and date
--https://www.codewars.com/kata/5dac87a0abe9f1001f39e36d
--Calculate the total revenue for each day, month, year, and product

SELECT name AS product_name,
EXTRACT(year from s.date)::int AS "year",
EXTRACT(month from s.date)::int AS "month",
EXTRACT(day from s.date)::int AS "day",
SUM(sd.count*pr.price) AS total
FROM sales_details sd
JOIN sales s ON (sd.sale_id = s.id)
JOIN products pr ON (sd.product_id = pr.id)
GROUP BY product_name, "year", "month","day"

UNION
SELECT name AS product_name,
EXTRACT(year from s.date)::int AS "year",
EXTRACT(month from s.date)::int AS "month",
NULL,
SUM(sd.count*pr.price) AS total
FROM sales_details sd
JOIN sales s ON (sd.sale_id = s.id)
JOIN products pr ON (sd.product_id = pr.id)
GROUP BY product_name, "year", "month"

UNION
SELECT name AS product_name,
EXTRACT(year from s.date)::int AS "year",
NULL,
NULL,
SUM(sd.count*pr.price) AS total
FROM sales_details sd
JOIN sales s ON (sd.sale_id = s.id)
JOIN products pr ON (sd.product_id = pr.id)
GROUP BY product_name, "year"

UNION
SELECT name AS product_name,
NULL,
NULL,
NULL,
SUM(sd.count*pr.price) AS total
FROM sales_details sd
JOIN sales s ON (sd.sale_id = s.id)
JOIN products pr ON (sd.product_id = pr.id)
GROUP BY product_name

ORDER BY product_name, "year", "month", "day"
