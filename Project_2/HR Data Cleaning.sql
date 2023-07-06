CREATE DATABASE IF NOT EXISTS hrproject;
USE hrproject;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

UPDATE hr 
SET birthdate = CASE
        WHEN birthdate LIKE ('%/%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'),'%d-%m-%Y')
        WHEN birthdate LIKE ('%-%') THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%d-%m-%Y'),'%d-%m-%Y')
        ELSE NULL
    END;
    
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr 
SET hire_date = CASE
        WHEN hire_date LIKE ('%/%') THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
        WHEN hire_date LIKE ('%-%') THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%d-%m-%Y'),'%Y-%m-%d')
        ELSE NULL
    END;
    
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM hr;

UPDATE hr 
SET 
    termdate = IF(termdate IS NOT NULL AND termdate != '',
        DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')),
        '0000-00-00')
WHERE
    TRUE;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) as youngest,
    max(age) as oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;