-- What are the highest-paying skills for Data Analyst roles?

SELECT
    skills,
    ROUND(AVG(salary_year_avg)) As avg_salary
FROM  
    job_postings_fact
INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25

/*
Insights from top-paying skills for Data Analyst roles:

1. SVN, Solidity, Couchbase, DataRobot, Golang – specialized programming, blockchain, databases, and ML tools drive the highest salaries.
2. Dplyr, VMware, Terraform, Twilio – data manipulation, cloud, and infrastructure skills are well-compensated.
3. Keras, PyTorch, TensorFlow – deep learning expertise commands strong pay.
4. DevOps & workflow tools like GitLab, Kafka, Puppet also boost average salaries.

Insight: Niche technical skills in programming, cloud, ML, and DevOps significantly increase earning potential for Data Analysts.
*/