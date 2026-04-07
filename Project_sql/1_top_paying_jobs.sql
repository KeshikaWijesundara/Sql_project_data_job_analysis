-- What are the top 10 highest paying jobs in the data analytics field?

SELECT 
    job_id,
    Job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    round(salary_year_avg),
    Job_posted_date::date
FROM 
    job_postings_fact 
LEFT JOIN company_dim  ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere'AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10

