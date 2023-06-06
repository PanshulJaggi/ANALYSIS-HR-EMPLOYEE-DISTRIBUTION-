# What is the gender breakdown of employees in the company?
select gender, count(*) as count
from hr
where age>=18
group by gender;
#It selects the gender and count of employees in each gender category from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by gender using the GROUP BY clause, which allows you to see the count of employees in each gender category separately.
#This query can provide useful insights into the gender demographics of the company's workforce, which can be helpful for diversity and inclusion initiatives, as well as other business purposes.


--------------------------------------------------------------------------------------------
# What is the race/ethnicity breakdown of employees in the company?
select race, count(*) as count
from hr
where age>=18
group by race
order by count desc;
#It selects the race and count of employees in each race from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by race using the GROUP BY clause, which allows you to see the count of employees in each race separately.
#The results are also sorted by count in descending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the racial demographics of the company's workforce, which can be helpful for diversity and inclusion initiatives, as well as other business purposes.


--------------------------------------------------------------------------------------------
# What is the age distribution of employees in the company?
select min(age) as youngest, max(age) as oldest
from hr
where age>=18;
#######################
SELECT FLOOR(age/10)*10 AS age_group, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY FLOOR(age/10)*10;
########################
SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, 
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group
ORDER BY age_group;
#It selects the age group and count of employees in each age group from a table called "hr" where the age is greater than or equal to 18.
#The age groups are determined using a CASE statement that checks the age of each employee 
#and assigns them to a specific age group based on their age range. The results are grouped by age group using the GROUP BY clause, 
#which allows you to see the count of employees in each age group separately.
#The results are also sorted by age group using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the age demographics of the company's workforce.

#(below is another way to write the above code)

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group, gender
ORDER BY age_group, gender;
#It selects the age group, gender, and count of employees in each age group and 
#gender category from a table called "hr" where the age is greater than or equal to 18.
#The age groups are determined using a CASE statement that checks the age of each employee and assigns them to a specific age group based on their age range. 
#The results are grouped by age group and gender using the GROUP BY clause, which allows you to see the count of employees in each age group and gender category separately.
#The results are also sorted by age group and gender using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the age and gender demographics of the company's workforce.


--------------------------------------------------------------------------------------------
# How many employees work at headquarters versus remote locations?
select location, count(*) as count
from hr
where age >=18
group by location;
# It selects the location and count of employees in each location from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by location using the GROUP BY clause, which allows you to see the count of employees in each location separately.
#This query can provide useful insights into the distribution of employees across different locations, 
#which can be helpful for resource allocation, staffing decisions, and other business purposes.


--------------------------------------------------------------------------------------------
# What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;
#It selects the average length of employment in years for employees who have a non-zero termination date 
#and whose termination date is on or before the current date, and whose age is greater than or equal to 18.
#The DATEDIFF function calculates the difference between the termination date and the hire date in days, 
#and the AVG function calculates the average of these differences. The result is then rounded to the nearest whole number using the ROUND function.
#Overall, this query provides useful information about the average length of employment for a subset of employees in the "hr" table.


--------------------------------------------------------------------------------------------
#How does the gender distribution vary across departments?
select department, gender, count(*) as count
from hr
where age>=18
group by department, gender
order by department;
#It selects the department, gender, and count of employees in each department and gender category from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by department and gender using the GROUP BY clause, which allows you to see the count of employees in each department and gender category separately.
#The results are also sorted by department using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the gender demographics of the company's workforce across different departments.


--------------------------------------------------------------------------------------------
# What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;
#It selects the job title and count of employees in each job title from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by job title using the GROUP BY clause, which allows you to see the count of employees in each job title separately.
#The results are also sorted by job title in descending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the distribution of employees across different job titles, which can be helpful for resource allocation, staffing decisions, and other business purposes.


--------------------------------------------------------------------------------------------
# Which department has the highest turnover rate?
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;
#It selects the department, total count of employees in each department, terminated count of employees in each department, active count of employees in each department, 
#and termination rate of employees in each department from a table called "hr" where the age is greater than or equal to 18.
#The query calculates the terminated count of employees in each department by filtering the employees who have a non-zero termination date and whose termination date is on or before the current date. 
#The active count of employees in each department is calculated by filtering the employees who have a zero termination date.
#The termination rate of employees in each department is calculated by dividing the terminated count by the total count of employees in each department.
#The results are sorted by termination rate in descending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the termination rates of employees across different departments, which can be helpful for identifying areas of improvement and making informed business decisions.


--------------------------------------------------------------------------------------------
# What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;
#It selects the location state and count of employees in each state from a table called "hr" where the age is greater than or equal to 18.
#The results are grouped by location state using the GROUP BY clause, which allows you to see the count of employees in each state separately.
#The results are also sorted by count in descending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the distribution of employees across different states, which can be helpful for resource allocation, staffing decisions, and other business purposes.


--------------------------------------------------------------------------------------------
# How has the company's employee count changed over time based on hire and term dates?
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
#It selects the year, number of hires, number of terminations, net change (hires - terminations), and net change percentage for each year from a table called "hr" where the age is greater than or equal to 18.
#The query calculates the number of hires and terminations for each year using the YEAR function to extract the year from the hire date. 
#The terminations are filtered to only include those with a non-zero termination date and whose termination date is on or before the current date.
#The query also calculates the net change and net change percentage by subtracting the number of terminations from the number of hires and dividing the result by the number of hires, respectively. 
#The results are rounded to two decimal places using the ROUND function.
#The results are sorted by year in ascending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the hiring and termination trends of the company over time.

#(below is another way to write the above code)
   
SELECT 
    year, 
    hires, 
    terminations, 
    (hires - terminations) AS net_change,
    ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM 
        hr
    WHERE age >= 18
    GROUP BY 
        YEAR(hire_date)
) subquery
ORDER BY 
    year ASC;
#It selects the year, number of hires, number of terminations, net change (hires - terminations), 
#and net change percentage for each year from a table called "hr" where the age is greater than or equal to 18.
#The subquery selects the year, count of hires, and count of terminations for each year using the YEAR function to extract the year from the hire date. 
#The terminations are filtered to only include those with a non-zero termination date and whose termination date is on or before the current date.
#The outer query calculates the net change and net change percentage by subtracting the number of terminations from the number of hires and dividing the result by the number of hires, respectively. 
#The results are rounded to two decimal places using the ROUND function.
#The results are sorted by year in ascending order using the ORDER BY clause, which arranges the data in a logical and easy-to-read format. 
#This query can provide useful insights into the hiring and termination trends of the company over time.

    
--------------------------------------------------------------------------------------------  
# What is the tenure distribution for each department?
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department
#It selects the department and the average tenure in years for employees who have a non-zero termination date 
#and whose termination date is on or before the current date, and whose age is greater than or equal to 18.
#The DATEDIFF function calculates the difference between the current date and the termination date in days, 
#and the AVG function calculates the average of these differences. 
#The result is then rounded to the nearest whole number using the ROUND function.
#The results are grouped by department using the GROUP BY clause, which allows you to see the average tenure for each department separately. 
#This query can provide useful insights into the retention rates and employee satisfaction levels for different departments within the company.--
