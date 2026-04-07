-- query within another query (subquery)
-- subquery runs first and returns a list of company_id values

-- list of companies that are offering jobs that do not require a degree
SELECT
    company_id,
    name as company_name
FROM 
    company_dim
WHERE 
    company_id IN (


SELECT
    company_id
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true
)

