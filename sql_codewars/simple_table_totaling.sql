--SQL Basics: Simple table totaling.
--https://www.codewars.com/kata/5809575e166583acfa000083
--Display each unique clan with their total points and ranked by their total points

SELECT
RANK() OVER( ORDER BY SUM(p.points) DESC) AS rank,
CASE WHEN p.clan = '' THEN '[no clan specified]'
ELSE p.clan
END,
SUM(p.points) AS total_points,
COUNT(p.name) AS total_people
FROM people p
GROUP BY p.clan
ORDER BY total_points DESC
