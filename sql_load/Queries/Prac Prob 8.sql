/**
 Find job postings from the first quarter in data anaysts  that have a salary greater than $70K
 • Combine job posting tables from the first quarter of 2023 (January to March)
 • Get job postings with an average yearly salary > $70,000
*/
SELECT 
    Quarter1_job_postings.job_title_short,   -- table name here is not neccessary 
    Quarter1_job_postings.job_location,
    Quarter1_job_postings.job_via,
    Quarter1_job_postings.job_posted_date::date,
    Quarter1_job_postings.salary_year_avg
FROM  (
        SELECT *  
        from  january_jobs
        UNION ALL
        SELECT  * 
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs 
        ) AS Quarter1_job_postings
WHERE 
        Quarter1_job_postings.salary_year_avg > 70000   AND     --table name here is not neccessary 
        Quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY Quarter1_job_postings.salary_year_avg DESC