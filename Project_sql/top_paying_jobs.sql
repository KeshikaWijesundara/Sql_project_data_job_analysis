-- What are the top 10 highest paying jobs in the data analytics field?

SELECT 
    A.job_id,
    A.Job_title,
    B.name AS company_name,
    A.job_location,
    A.job_schedule_type,
    round(A.salary_year_avg),
    A.Job_posted_date::date
FROM 
    job_postings_fact AS A
LEFT JOIN company_dim AS B ON A.company_id = B.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere'AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10

