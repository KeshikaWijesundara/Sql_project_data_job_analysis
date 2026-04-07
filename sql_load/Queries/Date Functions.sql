-- use ::DATE to extract only the date part (removes time/timestamp)

SELECT
    job_title_short as title,
    job_location as Location,
    job_posted_date :: DATE
FROM
    job_postings_fact;

-- AT TIME ZONE is used to convert timestamps from one time zone to another
-- first defines the original timezone, then converts it to the target timezone

SELECT
    job_title_short AS title,
    job_location AS Location,
    job_posted_date  at TIME ZONE 'UTC' AT TIME ZONE 'EST'  AS date   -- treat time as UTC and convert it to EST
FROM
    job_postings_fact

LIMIT 4;

-- EXTRACT is used to get a specific part (year, month, day, etc.) from a date/time value

SELECT
    job_title_short AS title,
    job_location AS Location,
    EXTRACT(MONTH FROM job_posted_date) as Posted_month   -- extracts only the month from the date
FROM 
    job_postings_fact

LIMIT 4;


-- show the number of Data Analyst job postings for each month
SELECT
    count(job_id) AS job_posted_count,
    EXTRACT (MONTH FROM job_posted_date ) AS MONTH
    
FROM
    job_postings_fact
WHERE
    job_title_short  = 'Data Analyst'
GROUP BY 
    MONTH
ORDER BY 
    job_posted_count DESC;


-- Practice Problem 1
-- Question:
-- Write a query to find the average salary both yearly and hourly for job postings 
-- that were posted after June 1, 2023. Group the results by job schedule type.

SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS yearly_avg_salary,
    AVG(salary_hour_avg) AS hourly_avg_salary

FROM
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type




-- Practice Problem 2
-- Question:
-- Write a query to count the number of job postings for each month in 2023, 
-- adjusting the job_posted_date to be in 'America/New_York' time zone before extracting the month.
-- Assume the job_posted_date is stored in UTC. Group by and order by the month.


-- Practice Problem 3
-- Question:
-- Write a query to find companies (include company name) that have posted jobs 
-- offering health insurance, where these postings were made in the second quarter of 2023.
-- Use date extraction to filter by quarter.