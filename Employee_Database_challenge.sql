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

select * from retiring_titles