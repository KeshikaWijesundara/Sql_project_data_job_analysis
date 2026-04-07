# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
This project was inspired by my curiosity to explore the data analyst job market and uncover which skills and roles offer the best opportunities. The goal was to make it easier for aspiring analysts to identify high-paying positions and the skills that can maximize their career growth.  

The dataset comes from my SQL course and contains detailed information on job postings, including job titles, salaries, locations, work-from-home options, and required skills. It serves as a rich resource for understanding trends in the field.

The key questions I aimed to answer with my SQL analysis were:  
- 💼 Which data analyst roles offer the highest salaries?  
- 🛠️ What skills are most important for landing top-paying positions?  
- 📈 Which skills are in highest demand across the job market?  
- 💵 Which skills are associated with higher salaries?  
- 🎯 What combination of skills offers the best balance of demand and pay, making them optimal to learn?  

# 🛠️ Tools Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](Project_sql-assests/1_top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts;

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

![Top Paying Skills](Assets/2_top_paying_roles_skills.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts;

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills      | Demand Count | Avg Salary ($) |
|----------|-------------|--------------|----------------|
| 98       | Kafka       | 40           | 129,999        |
| 101      | PyTorch     | 20           | 125,226        |
| 31       | Perl        | 20           | 124,686        |
| 99       | TensorFlow  | 24           | 120,647        |
| 63       | Cassandra   | 11           | 118,407        |
| 219      | Atlassian   | 15           | 117,966        |
| 96       | Airflow     | 71           | 116,387        |
| 3        | Scala       | 59           | 115,480        |
| 169      | Linux       | 58           | 114,883        |
| 234      | Confluence  | 62           | 114,153        |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Paying Specialized Skills:** Technologies like Kafka, PyTorch, TensorFlow, and Perl offer the highest average salaries, showing that niche expertise in machine learning, distributed systems, and advanced programming can significantly boost earning potential.

- **Balanced Skills (High Demand + Good Salary):** Skills such as Airflow, Scala, Linux, and Confluence provide a strong balance between demand and salary, making them valuable for steady career growth.

- **Big Data & Cloud Ecosystem:** Tools like Spark, Databricks, Snowflake, and GCP show strong demand along with competitive salaries, highlighting the importance of working with large-scale data and cloud-based platforms.

- **Machine Learning & Advanced Analytics:** Skills like PyTorch and TensorFlow reflect the growing role of machine learning in data analytics, where analysts are expected to contribute to predictive modeling and advanced insights.

- **Engineering & Workflow Tools:** Technologies such as Git, Airflow, and Linux indicate that modern data analysts benefit from knowledge of data pipelines, automation, and system operations, bridging the gap between analytics and data engineering.

# What I learned
Through this project, I was able to strengthen both my technical and analytical skills in a practical way.

- **Complex Query Writing:** I gained hands-on experience writing more advanced SQL queries, especially using joins and WITH clauses to break down problems and organize my logic more clearly.

- **Data Aggregation:** I became more comfortable using GROUP BY along with functions like COUNT() and AVG() to summarize data and extract meaningful patterns.

- **Analytical Thinking:** This project helped me think more like a data analyst—starting with a question and translating it into structured queries to uncover useful insights.

Overall, this experience improved my ability to work with real datasets and approach problems in a more structured and analytical way.

# Conclusion 
### Insights
From my analysis, a few key takeaways stood out:

1. **Top-Paying Data Analyst Jobs**: I noticed that remote data analyst roles can offer a very wide salary range, with some positions reaching extremely high salaries. This shows how much earning potential exists in the field depending on role and expertise.

2. **Skills for Top-Paying Jobs**: From the top-paying roles, it became clear to me that strong SQL skills are almost always required. It seems to be a core skill that plays a big role in reaching higher-paying positions.

3. **Most In-Demand Skills**: SQL consistently appeared as the most in-demand skill across job postings. This reinforced my understanding that having a solid foundation in SQL is essential for anyone entering this field.

4. **Skills with Higher Salaries**: I also observed that more specialized skills, especially in areas like machine learning and big data technologies, tend to be associated with higher salaries. This suggests that going beyond basic tools can really increase earning potential.

5. **Optimal Skills for Job Market Value**: Combining both demand and salary insights, I realized that the most valuable skills are those that balance both. While SQL remains a must-have, adding skills in cloud platforms, big data, or machine learning can make a strong difference in career growth.

