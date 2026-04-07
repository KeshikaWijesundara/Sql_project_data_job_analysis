--What are the top 5 most in-demand remote skills for Data Analyst roles?
SELECT
    skills,
    count(skills_job_dim.job_id) AS demand_count
FROM  
    job_postings_fact
INNER JOIN skills_job_dim ON  job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = true
GROUP BY 
    skills
ORDER BY 
    Demand_Count DESC
LIMIT 5

/*
 Insights from the top 5 most in-demand skills for remote Data Analyst roles:
 
 - SQL (7,291): The most demanded skill, essential for querying and managing data.
 - Excel (4,611): Highly relevant for quick analyses, reporting, and financial data handling.
 - Python (4,330): Important for programming, automation, and advanced data analysis.
 - Tableau (3,745): Visualization skill in demand for creating dashboards and communicating insights.
 - Power BI (2,609): Another key visualization tool, especially in Microsoft-oriented environments.
 
 Insight:
 Remote Data Analyst roles require a combination of querying, analytical, programming, and visualization skills. SQL leads, Python and visualization tools complement the technical skillset, and Excel remains a foundational skill.
 */