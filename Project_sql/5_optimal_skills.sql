--What are the most optimal skills to learn? (high demand and high paying skill)
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM  
        job_postings_fact
    INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
  GROUP BY 
    skills_dim.skill_id,
    skills_dim.skills

), average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg)) As avg_salary
    FROM  
        job_postings_fact
    INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand 
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

--Same Query but moore concisely
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) As avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
        skills_job_dim.skill_id,skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

/*
Insights from the Data Analyst skills dataset:

1. High-Demand Skills:
   - Snowflake (241 jobs), Spark (187 jobs), Hadoop (140 jobs), Databricks (102 jobs)
     are the most requested skills, showing strong demand for cloud and big data technologies.

2. High-Paying Skills:
   - Kafka (129,999), PyTorch (125,226), Perl (124,686), TensorFlow (120,647)
     offer higher salaries despite lower demand, reflecting the premium for specialized skills.

3. Balanced Skills:
   - Airflow, Git, Scala, Linux, GCP have moderate-to-high demand and competitive salaries (~113k–116k),
     making them valuable for career growth.
   - Pandas and PySpark also show strong adoption with solid pay.

4. Niche vs. General Tools:
   - Tools like Phoenix, Splunk, and Confluence have lower demand but may be strategically useful in
     specific contexts.

5. Salary-Demand Tradeoff:
   - Some highly demanded skills (Snowflake, Spark) offer slightly lower salaries (~111k–113k),
     while specialized ML tools (PyTorch, TensorFlow) pay more but are less common.
   - Acquiring rare but specialized skills can be financially advantageous.

Takeaway:
- For aspiring data analysts, a combination of high-demand tools and specialized ML skills
  maximizes employability and salary potential.
*/