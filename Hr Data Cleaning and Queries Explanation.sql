create database HiltopGroup;

USE hiltopgroup;
#this is used to tell sql that we are now using the hiltopgroup database ( this is very important as there a re many databases)

select * from hr;

alter table hr
change column ï»¿id emp_id VARCHAR(20) NULL;
#here we are changing the name of the id column and also the datatype

describe hr;
#we want to see the datayps of all the columns in our table

select birthdate from hr;

set sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
#This SQL code is updating the "birthdate" column in a table called "hr". 
#The code is using a CASE statement to check if the birthdate is in a certain format.
#If the birthdate is in the format of "month/day/year" (e.g. 05/20/1990), 
#then the code is using the str_to_date function to convert the birthdate to a date format, 
#and then using the date_format function to convert it to the format of "year-month-day" (e.g. 1990-05-20). 
#If the birthdate is in the format of "month-day-year" (e.g. 05-20-1990), 
#then the code is doing the same conversion to the "year-month-day" format. 
#If the birthdate is not in either of these formats, then the code is setting the birthdate to NULL.
#In summary, this code is updating the birthdate column in the hr table to a standardized "year-month-day" format, 
#based on whether the original birthdate was in a "month/day/year" or "month-day-year" format.


ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

select * from hr;


UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
# this query follow the same explanation as that of the birthdate query


ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';
#This SQL code is updating the "termdate" column in a table called "hr". 
#The code is using the str_to_date function to convert the "termdate" column from a string format to a date format, 
#using the format of "year-month-day hour:minute:second UTC". 
#The date function is then used to convert the resulting date to a date-only format, without the time component.
#The WHERE clause is used to filter out any rows where the "termdate" column is NULL or an empty string. 
#This ensures that only rows with a valid "termdate" value are updated.
#In summary, this code is updating the "termdate" column in the hr table to a date-only format, 
#based on the original "termdate" value in a string format of "year-month-day hour:minute:second UTC".


ALTER TABLE hr
MODIFY COLUMN termdate DATE;


ALTER TABLE hr ADD COLUMN age INT;
# this sql query adds a new column called age


UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());
# this code subtracts the birthdate from the current date (which is today).

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;
#This SQL code is selecting the minimum and maximum values of the "age" column in a table called "hr". #
#The MIN function is used to calculate the minimum value of the "age" column, which represents the youngest age in the table. 
#The MAX function is used to calculate the maximum value of the "age" column, which represents the oldest age in the table.
#The AS keyword is used to assign aliases to the resulting columns, with "youngest" assigned to the minimum value and "oldest" assigned to the maximum value. 
#The FROM clause is used to specify the table from which the data is being selected.
#In summary, this code is selecting the youngest and oldest ages from the "age" column in the hr table.

SELECT count(*) FROM hr WHERE age < 18;
#This SQL code is selecting the count of all rows in the "hr" table where the "age" column is less than 18. 
#The WHERE clause is used to filter the rows based on the condition that the "age" column is less than 18.
#The COUNT function is used to count the number of rows that meet this condition. 
#The "*" symbol is used as an argument to the COUNT function to indicate that all rows should be counted.
#In summary, this code is selecting the count of all rows in the hr table where the age is less than 18.



SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();
#This SQL code is selecting the count of all rows in the "hr" table where the "termdate" column is greater than the current date (as determined by the CURDATE function). 
#The WHERE clause is used to filter the rows based on the condition that the "termdate" column is greater than the current date.
#The COUNT function is used to count the number of rows that meet this condition. 
#The "*" symbol is used as an argument to the COUNT function to indicate that all rows should be counted.
#In summary, this code is selecting the count of all rows in the hr table where the termdate is in the future, 
#meaning the employee has not yet been terminated.


SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';
#This SQL code is selecting the count of all rows in the "hr" table where the "termdate" column is equal to '0000-00-00'. 
#The WHERE clause is used to filter the rows based on the condition that the "termdate" column is equal to '0000-00-00'.
#The COUNT function is used to count the number of rows that meet this condition. 
#The "*" symbol is used as an argument to the COUNT function to indicate that all rows should be counted.
#In summary, this code is selecting the count of all rows in the hr table where the termdate is equal to '0000-00-00', 
#which may indicate that the employee has not yet been terminated or that the termination date is unknown.


SELECT location FROM hr;