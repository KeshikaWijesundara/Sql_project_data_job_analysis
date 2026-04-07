-- Notes:
-- A CASE expression in SQL is used to apply conditional logic in a query.

-- Example:
-- SELECT
--     CASE
--         WHEN column_name = 'Value1' THEN 'Description for Value1'
--         WHEN column_name = 'Value2' THEN 'Description for Value2'
--         ELSE 'Other'
--     END AS column_description
-- FROM table_name;

-- Explanation:
-- CASE  -> starts the expression
-- WHEN  -> specifies the condition
-- THEN  -> result if condition is TRUE
-- ELSE  -> (optional) result if no conditions match
-- END   -> ends the CASE expression




-- Question:
-- Write a query to categorize job postings based on their location.
-- If the job_location is 'Anywhere', label it as 'Remote'.
-- If the job_location is 'New York' or 'NY', label it as 'Local'.
-- Otherwise, label it as 'Onsite'.
-- Display job_title_short, job_location, and the new categorized column (location_category).
SELECT
    COUNT(job_id) as number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
        END AS location_category --new column name 

FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'

GROUP BY 
    location_category
ORDER BY
    number_of_jobs ;
    
