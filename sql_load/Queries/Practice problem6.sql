-- Practice Problem 6
-- Question:
-- Create three tables:
--   • Jan 2023 jobs
--   • Feb 2023 jobs
--   • Mar 2023 jobs
-- Foreshadowing: This will be used in another practice problem below.

-- Hints:
--   • Use CREATE TABLE table_name AS syntax to create your table
--   • Look at a way to filter out only specific months (EXTRACT)

--Jan 2023 jobs
CREATE TABLE January_Jobs AS
    SELECT *
    FROM job_postings_fact  
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1;

--Feb 2023 jobs
CREATE TABLE February_Jobs AS
    SELECT *
    FROM job_postings_fact  
    WHERE EXTRACT (MONTH FROM job_posted_date) = 2;

--Mar 2023 jobs
CREATE TABLE Practice problem6.sql AS
    SELECT *
    FROM job_postings_fact  
    WHERE EXTRACT (MONTH FROM job_posted_date) = 3;



