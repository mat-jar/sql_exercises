--Calculating Running Total
--https://www.codewars.com/kata/589cf45835f99b2909000115
--write a query that returns date, a number of posts for a given date
--and a running total number of posts up until a given date

SELECT DATE(created_at) AS "date",
COUNT(*) AS "count",
SUM (COUNT(*)::int) OVER (ORDER BY DATE(created_at)) AS total
FROM posts
GROUP BY "date"
