CREATE DATABASE IF NOT EXISTS JobTracker;
USE JobTracker;

-- 1. Companies
CREATE TABLE IF NOT EXISTS Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    location VARCHAR(100)
);

-- 2. Job postings
CREATE TABLE IF NOT EXISTS Job_Postings (
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    job_type VARCHAR(50),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    job_location VARCHAR(100),
    posted_date DATE,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

-- 3. Applications
CREATE TABLE IF NOT EXISTS Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT NOT NULL,
    application_date DATE NOT NULL,
    application_status VARCHAR(30) NOT NULL DEFAULT 'Applied',
    application_source VARCHAR(100),
    notes VARCHAR(500),
    FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id)
);

-- 4. Interviews
CREATE TABLE IF NOT EXISTS Interviews (
    interview_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    interview_round VARCHAR(50),
    interview_date DATETIME,
    interview_mode VARCHAR(30),
    interview_result VARCHAR(30),
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
);

-- 5. Skills
CREATE TABLE IF NOT EXISTS Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL UNIQUE
);

-- 6. Many-to-many mapping between applications and skills
CREATE TABLE IF NOT EXISTS Application_Skills (
    application_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (application_id, skill_id),
    FOREIGN KEY (application_id) REFERENCES Applications(application_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);


-- ==================== 2. SAMPLE DATA ====================
USE JobTracker;

INSERT INTO Companies (company_name, industry, location) VALUES
('TCS', 'IT Services', 'Kolkata'),
('Infosys', 'IT Services', 'Bangalore'),
('IBM', 'Technology', 'Bangalore'),
('Accenture', 'Consulting', 'Hyderabad'),
('Wipro', 'IT Services', 'Pune');

INSERT INTO Job_Postings
(company_id, job_title, job_type, salary_min, salary_max, job_location, posted_date)
VALUES
(1, 'Software Developer', 'Full-time', 350000, 500000, 'Kolkata', '2026-10-01'),
(2, 'Python Developer', 'Full-time', 400000, 600000, 'Bangalore', '2026-10-05'),
(3, 'Data Analyst', 'Full-time', 450000, 650000, 'Bangalore', '2026-10-10'),
(4, 'Graduate Software Engineer', 'Full-time', 400000, 550000, 'Hyderabad', '2026-10-12'),
(5, 'SQL Developer', 'Full-time', 300000, 450000, 'Pune', '2026-10-15');

INSERT INTO Applications
(job_id, application_date, application_status, application_source, notes)
VALUES
(1, '2026-10-15', 'Applied', 'Company Website', 'Application submitted'),
(2, '2026-10-16', 'Shortlisted', 'LinkedIn', 'Shortlisted for assessment'),
(3, '2026-10-17', 'Interview', 'Company Website', 'Interview scheduled'),
(4, '2026-10-18', 'Rejected', 'Job Portal', 'Application unsuccessful'),
(5, '2026-10-19', 'Under Review', 'Company Website', 'Waiting for response');

INSERT INTO Interviews
(application_id, interview_round, interview_date, interview_mode, interview_result)
VALUES
(2, 'Online Assessment', '2026-11-02 10:00:00', 'Online', 'Pending'),
(3, 'Technical Interview', '2026-11-04 14:00:00', 'Online', 'Pending');

INSERT INTO Skills (skill_name) VALUES
('Python'), ('MySQL'), ('Java'), ('Data Analysis'), ('Problem Solving');

INSERT INTO Application_Skills (application_id, skill_id) VALUES
(1, 1), (1, 2), (2, 1), (2, 2), (3, 4), (3, 5), (5, 2);


-- ==================== 3. PROJECT QUERIES ====================
USE JobTracker;



-- 1. Count all applications
SELECT COUNT(*) AS total_applications
FROM Applications;

-- 2. Average maximum salary across job postings
SELECT ROUND(AVG(salary_max), 2) AS average_max_salary
FROM Job_Postings;

-- 3. Highest and lowest maximum salary
SELECT MAX(salary_max) AS highest_salary,
       MIN(salary_max) AS lowest_salary
FROM Job_Postings;

-- 4. Display company names in uppercase
SELECT UPPER(company_name) AS company_name_upper
FROM Companies;



-- 5. Applications with company and job details
SELECT a.application_id, c.company_name, j.job_title,
       a.application_date, a.application_status
FROM Applications a
INNER JOIN Job_Postings j ON a.job_id = j.job_id
INNER JOIN Companies c ON j.company_id = c.company_id;

-- 6. All companies and any matching job postings
SELECT c.company_name, j.job_title
FROM Companies c
LEFT JOIN Job_Postings j ON c.company_id = j.company_id;

-- OPERATORS

-- 7. Applications in selected statuses
SELECT *
FROM Applications
WHERE application_status IN ('Applied', 'Shortlisted', 'Interview');

-- 8. Job postings with salary maximum between 400000 and 600000
SELECT job_title, salary_min, salary_max
FROM Job_Postings
WHERE salary_max BETWEEN 400000 AND 600000;

-- 9. Find Python-related roles
SELECT *
FROM Job_Postings
WHERE job_title LIKE '%Python%';

-- 10. Applications after a given date that are not rejected
SELECT *
FROM Applications
WHERE application_date >= '2026-10-16'
  AND application_status <> 'Rejected';

-- SUBQUERIES

-- 11. Jobs with maximum salary above the average maximum salary
SELECT job_title, salary_max
FROM Job_Postings
WHERE salary_max > (
    SELECT AVG(salary_max)
    FROM Job_Postings
);

-- 12. Find the job posting with the highest maximum salary
SELECT job_title, salary_max
FROM Job_Postings
WHERE salary_max = (
    SELECT MAX(salary_max)
    FROM Job_Postings
);

-- 13. Companies that have at least one application
SELECT company_name
FROM Companies
WHERE company_id IN (
    SELECT company_id
    FROM Job_Postings
    WHERE job_id IN (
        SELECT job_id
        FROM Applications
    )
);

-- AGGREGATION

-- 14. Count applications by status
SELECT application_status, COUNT(*) AS total
FROM Applications
GROUP BY application_status;

-- 15. Number of jobs listed by each company
SELECT c.company_name, COUNT(j.job_id) AS total_jobs
FROM Companies c
LEFT JOIN Job_Postings j ON c.company_id = j.company_id
GROUP BY c.company_id, c.company_name;

-- 16. Search applications using a date range
SELECT *
FROM Applications
WHERE application_date BETWEEN '2026-10-15' AND '2026-10-19';

-- INDEX EXAMPLE (run once; this creates an index)
-- CREATE INDEX idx_application_status ON Applications(application_status);
-- SHOW INDEX FROM Applications;


-- Create the index only if it does not already exist.
SET @idx_exists = (
    SELECT COUNT(*)
    FROM information_schema.statistics
    WHERE table_schema = DATABASE()
      AND table_name = 'Applications'
      AND index_name = 'idx_application_status'
);
SET @idx_sql = IF(
    @idx_exists = 0,
    'CREATE INDEX idx_application_status ON Applications(application_status)',
    'SELECT ''Index idx_application_status already exists'' AS message'
);
PREPARE idx_stmt FROM @idx_sql;
EXECUTE idx_stmt;
DEALLOCATE PREPARE idx_stmt;

SHOW INDEX FROM Applications;

-- ==================== 5. FINAL VERIFICATION ====================
SHOW TABLES;
SELECT COUNT(*) AS total_companies FROM Companies;
SELECT COUNT(*) AS total_jobs FROM Job_Postings;
SELECT COUNT(*) AS total_applications FROM Applications;
SELECT COUNT(*) AS total_interviews FROM Interviews;
