/*
 Find the count of the number of remote job postings per skill
     • Display the top 5 skills by their demand in remote jobs
     • Include skill ID, skill name, and count of postings requiring the skill
*/


-- Step 1: Create a CTE to count remote job postings per skill
WITH remote_job_skills AS (
    SELECT
        skill_id,                        -- ID of the skill
        COUNT(*) AS Skill_Count           -- Count of remote job postings requiring this skill
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact AS Job_postings 
        ON Job_postings.job_id = skills_to_job.job_id   -- Join skills to their job postings
    WHERE
        Job_postings.job_work_from_home = true         -- Only consider remote jobs
    GROUP BY
        skill_id                                       -- Group by skill to get count per skill
)

-- Step 2: Select skill details and top 5 skills
SELECT 
    skills.skill_id,                                -- Skill ID
    skills AS skill_name,                            -- Skill name from skills_dim
    skill_count                                     -- Number of remote job postings requiring the skill
FROM 
    remote_job_skills
INNER JOIN 
    skills_dim AS skills 
    ON skills.skill_id = remote_job_skills.skill_id -- Match skill IDs to get names
ORDER BY 
    skill_count DESC                                -- Order by demand, highest first
LIMIT 5;                                           -- Only top 5 skills