-- CTE (Common Table Expression):
-- A temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement
-- Exists only during the execution of a query
-- It is a defined query that can be referenced in the main query or other CTEs
-- WITH is used to define a CTE at the beginning of a query



-- Question:
-- Find the companies that have the most job openings.
-- • Get the total number of job postings per company_id
-- • Return the total number of jobs along with the company name
-- Step 1: Create a CTE to count total jobs per company
WITH company_job_count AS(
SELECT
    company_id,
    COUNT(*) AS Total_jobs  -- Count total number of job postings per company
FROM
    job_postings_fact 
GROUP BY
    company_id  -- Group job postings by company_id
)
-- Step 2: Select company name and total jobs
SELECT 
    company_dim.name as Company_Name,  -- Get company name from company_dim
    company_job_count.Total_jobs       -- Get total jobs from CTE

FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id  -- Join CTE with company_dim
ORDER BY Total_jobs DESC;  -- Order companies by total jobs in descending order