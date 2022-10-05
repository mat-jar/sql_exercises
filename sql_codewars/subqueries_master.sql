--Subqueries master
--https://www.codewars.com/kata/594323fde53209e94700012a
--The objective of this Kata is string manipulation and using ubqueries

SELECT

CASE
WHEN SPLIT_PART("name", ' ', 4) = '' THEN
SPLIT_PART("name", ' ', 1)
WHEN SPLIT_PART("name", ' ', 4) != '' AND SPLIT_PART("name", ' ', 5) = ''  THEN
CONCAT(SPLIT_PART("name", ' ', 1), ' ', SPLIT_PART("name", ' ', 2))
ELSE
CONCAT(SPLIT_PART("name", ' ', 1), ' ', SPLIT_PART("name", ' ', 2), ' ',SPLIT_PART("name", ' ', 3) )
END AS "name",

CASE
WHEN SPLIT_PART("name", ' ', 4) = '' THEN
SPLIT_PART("name", ' ', 2)
WHEN SPLIT_PART("name", ' ', 4) != '' AND SPLIT_PART("name", ' ', 5) = ''  THEN
SPLIT_PART("name", ' ', 3)
ELSE
SPLIT_PART("name", ' ', 4)
END AS "first_lastname",

CASE
WHEN SPLIT_PART("name", ' ', 4) = '' THEN
SPLIT_PART("name", ' ', 3)
WHEN SPLIT_PART("name", ' ', 4) != '' AND SPLIT_PART("name", ' ', 5) = ''  THEN
SPLIT_PART("name", ' ', 4)
ELSE
SPLIT_PART("name", ' ', 5)
END AS "second_lastname"

FROM people
