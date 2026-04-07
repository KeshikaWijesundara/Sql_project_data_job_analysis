/*
Combines results of twp or more SELECT statemnts in to a single row 
Union - remove duplicate rows
union all - Include Duplicate rows

*/

/*
UNION
 - Combines results of three months (January, February, March)
 - Removes duplicate rows automatically
 - Use this when you want only unique records across multiple SELECTs
*/
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
UNION
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

/*
UNION ALL
 - Combines results of three months (January, February, March)
 - Keeps all rows including duplicates
 - Use this when you want to count or preserve all entries even if they repeat
*/
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION ALL
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
UNION ALL
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs   