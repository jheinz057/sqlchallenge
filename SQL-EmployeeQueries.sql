
--Dropping tables if they already exist

DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/9ZB9ua
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(200)   NOT NULL,
    "dept_name" varchar(200)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(200)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(200)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(200)   NOT NULL,
    "last_name" varchar(200)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" money   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(200)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Checking to see if info shows up
SELECT * from dept_emp;
SELECT * from dept_manager;
SELECT * from salaries;
SELECT * from titles;
SELECT * from employees;
SELECT * from departments;

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no,
  salaries.salary,
  employees.first_name,
  employees.last_name,
  employees.gender
FROM salaries
INNER JOIN employees ON
employees.emp_no = salaries.emp_no;

--2. List employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1985-12-12' and '1987-01-01'

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT
    dept_manager.dept_no,
    departments.dept_name,
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    dept_manager.from_date,
    dept_manager.to_date
FROM dept_manager
    JOIN departments ON dept_manager.dept_no = departments.dept_no
    INNER JOIN employees ON
employees.emp_no = dept_manager.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    departments.dept_name
FROM dept_emp
    JOIN departments ON dept_emp.dept_no = departments.dept_no
    INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no;


--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT
    employees.first_name,
    employees.last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    departments.dept_name
FROM dept_emp
    JOIN departments ON dept_emp.dept_no = departments.dept_no
    INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
WHERE dept_name = 'Sales'


--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    departments.dept_name
FROM dept_emp
    JOIN departments ON dept_emp.dept_no = departments.dept_no
    INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "name count"
FROM employees
GROUP BY last_name
ORDER BY "name count" DESC;



