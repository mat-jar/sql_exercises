--SQL
--https://www.sql-practice.com/
--1) Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name, gender FROM patients
WHERE gender = "M";

--2) Show first name and last name of patients who does not have allergies (null)
SELECT first_name, last_name FROM patients
WHERE allergies is NULL;

--3) Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients
WHERE first_name LIKE 'C%';

--4) Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name FROM patients
WHERE weight BETWEEN 100 AND 120;

--5) Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients SET allergies='NKA' WHERE allergies IS NULL;

--6) Show first name and last name concatinated into one column to show their full name
SELECT CONCAT(first_name, " ", last_name) AS full_name FROM patients;

--7) Show first name, last name, and the full province name of each patient
SELECT patients.first_name, patients.last_name, provinces.province_name
  FROM patients JOIN provinces
       ON (patients.province_id = provinces.province_id);

--8) Show how many patients have a birth_date with 2010 as the birth year
SELECT COUNT(patient_id) FROM patients
WHERE YEAR(birth_date) = 2010;

--9) Show the first_name, last_name, and height of the patient with the greatest height
SELECT first_name, last_name, MAX(height) FROM patients;

--10) Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT * FROM patients
WHERE patient_id IN (1,45,534,879,1000);

--11) Show the total number of admissions
SELECT COUNT(*) FROM admissions;

--12) Show unique birth years from patients and order them by ascending
SELECT DISTINCT YEAR(birth_date) FROM patients
ORDER BY YEAR(birth_date) ASC;

--13) Show unique first names from the patients table which only occurs once in the list
SELECT first_name FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

--14) Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long
SELECT patient_id, first_name FROM patients
WHERE first_name LIKE 'S%s' AND LEN(first_name) >= 6;

--15) Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.
--    Primary diagnosis is stored in the admissions table
SELECT patients.patient_id, first_name, last_name FROM admissions JOIN patients
ON patients.patient_id = admissions.patient_id
WHERE primary_diagnosis = 'Dementia';

--16) Show patient_id, first_name, last_name from the patients table.
--    Order the rows by the first_name ascending and then by the last_name descending
SELECT patient_id, first_name, last_name FROM patients
ORDER BY first_name ASC, last_name DESC;

--17) Show the total amount of male patients and the total amount of female patients in the patients table
SELECT gender, COUNT(*) FROM patients
GROUP BY gender;

--SELECT (SELECT count(*) FROM patients WHERE gender='M') AS male_count,
--  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

--18) Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
--    Show results ordered ascending by allergies then by first_name then by last_name
SELECT first_name, last_name, allergies FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies, first_name, last_name;

--19) Show patient_id, primary_diagnosis from admissions. Find patients admitted multiple times for the same primary_diagnosis
SELECT patient_id, primary_diagnosis FROM admissions
GROUP BY patient_id, primary_diagnosis
HAVING COUNT(*) > 1;

--20) Show the city and the total number of patients in the city in the order from most to least patients
SELECT city, Count(patient_id) FROM patients
GROUP BY city
ORDER BY COUNT(patient_id) DESC;

--21) Show first name, last name and role of every person that is either patient or physician.
--    The roles are either "Patient" or "Physician"
SELECT first_name, last_name, 'Patient' FROM patients
UNION
SELECT first_name, last_name, 'Physician' FROM physicians
ORDER BY last_name;

--22) Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query
SELECT allergies, COUNT(patient_id) FROM patients
WHERE allergies != 'NKA' AND allergies NOT NULL
GROUP BY allergies
ORDER BY COUNT(patient_id) DESC;

--23) Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade.
--    Sort the list starting from the earliest birth_date
SELECT first_name, last_name, birth_date FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

--24) We want to display each patient's full name in a single column.
--    Their last_name in all upper letters must appear first, then first_name in all lower case letters.
--    Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane
SELECT CONCAT(UPPER(last_name), ",", LOWER(first_name)) AS full_name  FROM patients
ORDER BY first_name DESC;

--25) Show the cities where the patient's average weight, rounded-up, is less than 70kg. Sort the list by highest to lowest avg_weight
SELECT city, ROUND(AVG(weight),0) AS avg_weight FROM patients
GROUP BY city HAVING avg_weight < 70
ORDER BY avg_weight DESC;

--26) Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000
SELECT province_id, SUM(height) AS sum_height FROM patients
GROUP BY province_id HAVING sum_height >= 7000;

--27) Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT MAX(weight)-MIN(weight) FROM patients
WHERE last_name = 'Maroni';

--28) Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT(city) FROM patients
WHERE province_id = 'NS';

--29) Show all of the patients grouped into weight groups.
--    Show the total amount of patients in each weight group. Order the list by the weight group decending
SELECT
       count(*)                	AS COUNT,
       10 * ( weight / 10 )    	AS range
FROM  patients
GROUP BY range
ORDER BY range DESC;

--30) Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1.
--    Obese is defined as weight(kg)/(height(m)2) >= 30. weight is in units kg. height is in units cm

SELECT patient_id, weight, height,
       CASE
       WHEN weight/(POWER((height/100.),2)) >= 30 THEN 1
       ELSE 0
       END AS isObese
FROM  patients;

--31) Show patient_id, first_name, last_name, and attending physician's specialty.
--    Show only the patients who has a primary_diagnosis as 'Dementia' and the physician's first name is 'Lisa'.
--    Check patients, admissions, and physicians tables for required information

SELECT patients.patient_id, patients.first_name, patients.last_name, physicians.specialty
FROM patients JOIN admissions, physicians
ON (patients.patient_id = admissions.patient_id
    AND admissions.attending_physician_id = physicians.physician_id)
WHERE primary_diagnosis = 'Dementia' AND physicians.first_name = 'Lisa';

--  SELECT p.patient_id, p.first_name as patient_first_name, p.last_name as patient_last_name, ph.specialty as attending_physician_specialty
--  FROM patients p
--  JOIN admissions a ON a.patient_id = p.patient_id
--  JOIN physicians ph ON ph.physician_id = a.attending_physician_id
--  WHERE primary_diagnosis = 'Dementia' AND ph.first_name = 'Lisa';


--32) All patients who have gone through admissions, can see their medical documents on our site.
--    Those patients are given a temporary password after their first admission. Show the patient_id and temp_password
--    The password must be the following, in order: patient_id,
--    the numerical length of patient's last_name, year of patient's birth_date

SELECT DISTINCT patients.patient_id,
CONCAT(patients.patient_id, LEN(last_name), YEAR(birth_date)) AS temp_password
FROM patients JOIN admissions
ON (patients.patient_id = admissions.patient_id);

--33) Each admission costs $50 for patients without insurance, and $10 for patients with insurance.
--    All patients with an even patient_id have insurance Give each patient a 'Yes' if they have insurance,
--    and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group

SELECT
       has_insurance,
       CASE
       WHEN has_insurance = 'Yes' THEN COUNT(*)*10
       WHEN has_insurance = 'No'  THEN COUNT(*)*50
       END
FROM (SELECT
       CASE
       WHEN MOD(patient_id, 2) = 0  THEN 'Yes'
       ELSE 'No'
       END AS has_insurance
       FROM admissions)
GROUP BY has_insurance;


--SELECT
--CASE WHEN patient_id % 2 = 0 Then 'Yes'
--ELSE 'No'
--END as has_insurance,
--SUM(CASE WHEN patient_id % 2 = 0 Then 10
--ELSE 50
--END) as cost_after_insurance FROM admissions
--GROUP BY has_insurance;

--34) Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
SELECT CASE
WHEN m.number>f.number THEN m.province_name
END AS province
FROM
(SELECT province_name, gender, count(*) AS number
FROM provinces JOIN patients
ON (provinces.province_id = patients.province_id)
GROUP BY province_name, gender HAVIng gender = 'F'
) AS f
JOIN
(SELECT province_name, gender, count(*) AS number
FROM provinces JOIN patients
ON (provinces.province_id = patients.province_id)
GROUP BY province_name, gender HAVIng gender = 'M'
) AS m
ON (f.province_name=m.province_name)
WHERE province IS NOT NULL;

--SELECT pr.province_name FROM patients as pa
--JOIN provinces as pr
--ON pa.province_id = pr.province_id
--GROUP BY pr.province_name
--HAVING COUNT(CASE WHEN gender = 'M' THEN 1 END) > COUNT(CASE WHEN gender = 'F' THEN 1 END);

--35) We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
--First_name contains an 'r' after the first two letters. Identifies their gender as 'F'. Born in February, May, or December.
--Their weight would be between 60kg and 80kg. Their patient_id is an odd number. They are from the city 'Halifax'

SELECT * From patients
WHERE gender = 'F'
AND MONTH(birth_date) IN (2, 5, 12)
AND weight BETWEEN 60 AND 80
AND Mod(patient_id, 2) = 1
AND city = 'Halifax'
AND first_name LIKE '__r%';

--36) Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form
SELECT CONCAT(ROUND(100.0*COUNT(CASE WHEN gender = 'M' THEN patient_id END)/COUNT(patient_id),2), '%') FROM patients;

--SELECT
--CONCAT(ROUND((SELECT COUNT(*) FROM patients WHERE gender = 'M')/(CAST(COUNT(*) as float)),4)*100,'%') as percent_of_male_patients
--FROM patients;
