drop table if exists Employees;
drop table if exists Titles;
create table Employees(
	emp_no INT,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);


create table Titles(
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE
);
select Employees.emp_no, Employees.first_name, Employees.last_name,
		Titles.title, Titles.from_date, Titles.to_date 
into retired_titles
from Employees
inner join Titles on Employees.emp_no=Titles.emp_no
where Employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by Employees.emp_no

select * from retired_titles;

SELECT DISTINCT ON (retired_titles.emp_no) retired_titles.emp_no, retired_titles.first_name,
		retired_titles.last_name,retired_titles.title, retired_titles.from_date,
		retired_titles.to_date
INTO unique_titles
FROM retired_titles
ORDER BY retired_titles.emp_no, retired_titles.to_date DESC;

SELECT COUNT(unique_titles.emp_no),unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY COUNT (unique_titles.emp_no) DESC;

drop table if exists Department_Employees;
create table Department_Employees(
	emp_no INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE
);

drop table if exists mentorship_eligibilty;
select distinct on(employees.emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date,
			department_employees.from_date, department_employees.to_date,
			titles.title
into mentorship_eligibilty
from employees
inner join department_employees on employees.emp_no=department_employees.emp_no
inner join titles on employees.emp_no=titles.emp_no
where (employees.birth_date between '1965-01-01' and '1965-12-31') 
	and (department_employees.to_date = '9999-01-01')
order by employees.emp_no;
select * from mentorship_eligibilty;
