--SQL Basics: Group By Day
--https://www.codewars.com/kata/5811597e9d278beb04000038
--Group events by the day the activity happened and their description

SELECT DATE(e.created_at) AS day, e.description, COUNT(*) FROM events e
WHERE name = 'trained'
GROUP BY day, e.description
ORDER BY day
