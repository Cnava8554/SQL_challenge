-- Database: sql_challenge_db

-- DROP DATABASE IF EXISTS sql_challenge_db;

DROP TABLE IF EXISTS departments, departments CASCADE;
DROP TABLE IF EXISTS employee_department, employee_department CASCADE;
DROP TABLE IF EXISTS department_manager, department_manager CASCADE;
DROP TABLE IF EXISTS employees, employees CASCADE;
DROP TABLE IF EXISTS salaries, salaries CASCADE;
DROP TABLE IF EXISTS titles, titles CASCADE;

CREATE TABLE "departments" (
	"dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employee_department" (
	"emp_no" INT UNIQUE NOT NULL,
	"dept_no" VARCHAR NOT NULL
);

CREATE TABLE "department_manager" (
	"dept_no" VARCHAR NOT NULL,
	"emp_no" INT UNIQUE NOT NULL
);

CREATE TABLE "employees" (
	"emp_no" INT UNIQUE NOT NULL,
	"emp_title" VARCHAR UNIQUE NOT NULL,
	"birth_date" DATE NOT NULL,
	"first_name" VARCHAR NOT NULL,
	"last_name" VARCHAR NOT NULL,
	"sex" VARCHAR NOT NULL,
	"hire_date" DATE NOT NULL,
	CONSTRAINT "pk_employees" PRIMARY KEY (
	"emp_no"
	)
);

CREATE TABLE "salaries" (
	"emp_no" INT UNIQUE NOT NULL,
	"salary" INT NOT NULL
);

CREATE TABLE "titles" (
	"title_id" VARCHAR UNIQUE NOT NULL,
	"title" VARCHAR NOT NULL
);

ALTER TABLE "employee_department" ADD CONSTRAINT "employee_department_emp_no_fk" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
ALTER TABLE "employee_department" ADD CONSTRAINT "employee_department_dept_no_fk" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");
ALTER TABLE "department_manager" ADD CONSTRAINT "department_manager_dept_no_fk" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");
ALTER TABLE "department_manager" ADD CONSTRAINT "department_manager_emp_no_fk" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
ALTER TABLE "salaries" ADD CONSTRAINT "salaries_emp_no_fk" FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
ALTER TABLE "titles" ADD CONSTRAINT "titles_title_id_fk" FOREIGN KEY ("title_id") REFERENCES "employees" ("emp_title");

COPY departments(dept_no, dept_name)
FROM 'C:\Users\christian.nava\Desktop\SQL_challenge\Instructions\data\departments.csv'
DELIMITER ','
CSV HEADER;

COPY employee_department(emp_no, dept_no)
FROM 'C:\Users\christian.nava\Desktop\My_Repos\SQL_challenge\Instructions\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY department_manager(dept_no, emp_no)
FROM 'C:\Users\christian.nava\Desktop\My_Repos\SQL_challenge\Instructions\data\dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY employees(emp_no, emp_title, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Users\christian.nava\Desktop\My_Repos\SQL_challenge\Instructions\data\employees.csv'
DELIMITER ','
CSV HEADER;

COPY salaries(emp_no, salary)
FROM 'C:\Users\christian.nava\Desktop\My_Repos\SQL_challenge\Instructions\data\salaries.csv'
DELIMITER ','
CSV HEADER;

COPY titles(title_id, title)
FROM 'C:\Users\christian.nava\Desktop\My_Repos\SQL_challenge\Instructions\data\titles.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM departments;
SELECT * FROM employee_department;
SELECT * FROM department_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no=salaries.emp_no;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN 1/1/1986 and 1/1/1987;

SELECT departments.dept_no, departments.dept_name, department_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN department_manager
ON departments.dept_no=department_manager.dept_no
JOIN employees
ON department_manager.emp_no=employees.emp_no;

SELECT employee_department.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employee_department
JOIN employees
ON employee_department.emp_no=employees.emp_no
JOIN departments
ON employee_department.dept_no=departments.dept_no;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'B%'
AND first_name='Hercules';

SELECT employee_department.emp_no, employees.last_name, employees.first_name
FROM employee_department
JOIN employees
ON employee_department.emp_no=employees.emp_no
JOIN departments
ON employee_department.dept_no=departments.dept_no
WHERE departments.dept_name='Sales';

SELECT employee_department.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employee_department
JOIN employees
ON employee_department.emp_no=employees.emp_no
JOIN departments
ON employee_department.dept_no=departments.dept_no
WHERE departments.dept_name='Sales'
OR departments.dept_name='Development';

SELECT last_name, COUNT(last_name) AS Frequency
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name)DESC
