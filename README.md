<div align="center">

# 💼 Job Application Tracker

### Organize your job search. Track every application. Stay ready for your next opportunity.

A simple MySQL project to keep company details, job openings, applications, and interview schedules organized in one place.

<br>

![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-336791?style=for-the-badge&logo=databricks&logoColor=white)
![Project](https://img.shields.io/badge/Project-Portfolio%20Project-6C63FF?style=for-the-badge)

</div>

---

## 📌 About the Project

The **Job Application Tracker** is a database project designed to help organize a job search. It stores information about companies, job postings, submitted applications, interviews, and the skills associated with each application.

The project includes a single SQL script with table creation, sample records, example queries, index creation, and verification queries.

## ✨ Features

- 🏢 Store company details.
- 💻 Record job postings, job types, locations, and salary ranges.
- 📋 Track application dates and application statuses.
- 🗓️ Record interview rounds, dates, modes, and results.
- 🧩 Associate skills with applications.
- 🔎 Query and summarize application information.
- 🧪 Use sample data to test the database.
- ⚡ Create and inspect an index on application status.

## 🗺️ Entity–Relationship Diagram

The diagram below shows the six tables and how they are related.

![Job Application Tracker ER Diagram](ER%20Diagram%20for%20Job%20Tracker.png)

## 🧱 Database Structure

The database is named `JobTracker` and contains six tables.

| Table | Purpose |
|---|---|
| `Companies` | Stores company names, industries, and locations. |
| `Job_Postings` | Stores job titles, job types, salary ranges, locations, and posting dates. |
| `Applications` | Records applications, dates, statuses, sources, and notes. |
| `Interviews` | Stores interview rounds, dates, modes, and results. |
| `Skills` | Maintains a list of skills. |
| `Application_Skills` | Connects applications with skills. |

### 🔗 Relationships

- One company can have multiple job postings.
- One job posting can receive multiple applications.
- One application can have multiple interviews.
- Applications and skills have a many-to-many relationship, implemented through `Application_Skills`.

Primary keys identify records, while foreign keys connect related tables.

## 🛠️ Technologies Used

- **MySQL** — relational database
- **SQL** — database definition, sample data, and queries
- **MySQL Workbench** — running SQL and viewing the database

## 📂 Repository Contents

```text
Job-Application-Tracker-MySQL/
├── ER Diagram for Job Tracker.png
├── README.md
└── job_Application_Tracker.sql
```

> The SQL filename shown above is an example. Use the exact filename displayed in this repository when opening the script.

## 🚀 Getting Started

### Prerequisites

- MySQL Server
- MySQL Workbench (recommended)

### Setup Instructions

1. Clone or download this repository.
2. Open MySQL Workbench and connect to your local MySQL server.
3. Open the project's `.sql` file.
4. Review the script before executing it.
5. Execute the schema section to create the database and tables.
6. Execute the sample-data section to insert example records.
7. Run the example queries to explore the data.

**Important:** Run the sample-data section only once. Running it repeatedly can insert duplicate records. If you already created the tables and inserted the sample data, do not rerun those sections unnecessarily.

## 🔍 What You Can Explore

The SQL script demonstrates queries for:

- Counting applications and calculating salary summaries.
- Displaying company and job information together.
- Filtering applications by status or date.
- Searching job titles.
- Finding jobs with salaries above the average.
- Finding the highest salary.
- Counting applications by status and jobs by company.
- Creating and checking an index.

## 🧾 Example Queries

### View applications with company and job details

```sql
USE JobTracker;

SELECT
    a.application_id,
    c.company_name,
    j.job_title,
    a.application_date,
    a.application_status
FROM Applications AS a
INNER JOIN Job_Postings AS j
    ON a.job_id = j.job_id
INNER JOIN Companies AS c
    ON j.company_id = c.company_id;
```

### Count applications by status

```sql
SELECT application_status, COUNT(*) AS total
FROM Applications
GROUP BY application_status;
```

### Find jobs above the average maximum salary

```sql
SELECT job_title, salary_max
FROM Job_Postings
WHERE salary_max > (
    SELECT AVG(salary_max)
    FROM Job_Postings
);
```

## 🎯 Project Objective

The objective of this project is to practice building and querying a relational database for a practical use case: organizing a job search and monitoring application progress.

## 🔮 Possible Future Improvements

- Add more realistic sample records.
- Add reports for application outcomes and interview progress.
- Extend the database as new tracking requirements arise.

## 👩‍💻 Author

**Rittika Kundu**

---

<div align="center">

Made with 💙 and MySQL

</div>
