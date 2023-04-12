/* 
Programmer's Name: Justin Dubin
Course: CSCI 2020 Section Number: 940 
Creation Date: 02/17/2022 Date of Last Modification: 02/20/2022
E-mail Address: dubinj@etsu.edu 
Purpose - 
Lab 5 – Advanced SQL (Writing Reports)
Identifier dictionary - 
Not Applicable 
 
Notes and Assumptions ? 
*/
-----------------------------------------------------------------
--1. Salary Report
SELECT e.employee_id "Employee ID", 
e.last_name || ', ' || e.first_name "Name", 
j.job_title "Job Title", 
TO_CHAR(e.salary, '$999999.99') "Current Salary",
TO_CHAR(j.max_salary, '$999999.99') "Maximum Salary",
TO_CHAR(e.salary / j.max_salary * 100, '99.99') || '%' "Percent of Maximum"
FROM hr.employees e
INNER JOIN hr.jobs j
ON e.job_id = j.job_id
ORDER BY e.last_name ASC, e.first_name ASC;

--2. Employee Location Report
SELECT e.employee_id "Employee ID", 
e.last_name || ', ' || e.first_name "Employee Name"
FROM hr.employees e
INNER JOIN hr.job_history j
ON e.employee_id = j.employee_id
INNER JOIN hr.departments d
ON j.department_id = d.department_id
INNER JOIN hr.locations l
ON d.location_id = l.location_id
WHERE l.state_province = 'Texas' AND j.end_date IS NOT NULL
ORDER BY e.last_name ASC, e.first_name ASC;

--3. Manager Discrepancy Report
SELECT e.employee_id "Employee ID", 
e.last_name || ', ' || e.first_name "Employee Name",
d.department_name "Department Name",
e.last_name || ', ' || e.first_name "Department Manager",
m.last_name || ', ' || m.first_name "Employee Manager"
FROM hr.employees e
INNER JOIN hr.job_history j
ON e.employee_id = j.employee_id
INNER JOIN hr.departments d
ON j.department_id = d.department_id
INNER JOIN HR.employees m
ON m.employee_id = e.manager_id
ORDER BY "Department Name" ASC, "Employee Name" ASC;

--4. Departments Without Employees Report
SELECT d.department_id "Department ID", 
d.department_name "Department Name"
FROM hr.departments d
WHERE NOT EXISTS
    (SELECT d.department_id
     FROM hr.employees e
     WHERE d.department_id = e.department_id)
ORDER BY "Department Name" ASC;

--5. Asian Employees Report
SELECT e.employee_id "Employee ID", 
e.last_name || ', ' || e.first_name "Employee Name",
c.country_name "Country Name", 
r.region_name "Region Name"
FROM hr.employees e
INNER JOIN hr.departments d
ON e.department_id = d.department_id
INNER JOIN hr.locations l
ON d.location_id = l.location_id
INNER JOIN hr.countries c
ON l.country_id = c.country_id
INNER JOIN hr.regions r
ON c.region_id = r.region_id
WHERE r.region_name = 'Asia'
ORDER BY "Employee Name" ASC;