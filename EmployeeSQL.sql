-- Dropping existing tables if they exist
Drop Table Department;
Drop Table Department_Employee;
Drop Table Department_Manager;
Drop Table Salary;
Drop Table Titles;
Drop Table Employees;

-- Creating a table to store department information
Create Table Department (
Dept_no VARCHAR(25) PRIMARY KEY,
Dept_name VARCHAR(25) NOT NULL);

-- Creating a table to assign employees to departments
Create Table Department_Employee(
Emp_no VARCHAR(25) PRIMARY KEY,
Dept_no VARCHAR(25) NOT NULL,
FOREIGN KEY (Dept_no) REFERENCES Department(Dept_no));

-- Creating a table to assign managers to departments
Create Table Department_Manager(
Dept_no VARCHAR(25) NOT NULL,
Emp_no VARCHAR(25) PRIMARY KEY,
FOREIGN KEY (Dept_no) REFERENCES Department(Dept_no));

-- Creating a table to store salary information of employees
Create Table Salary(
Emp_no VARCHAR(25) PRIMARY KEY,
Salary VARCHAR(25) NOT NULL,
FOREIGN KEY (Emp_no) REFERENCES Department_Employee(Emp_no),
FOREIGN KEY (Emp_no) REFERENCES Department_Manager(Emp_no)
);

-- Creating a table to store employee titles
Create Table Titles(
Title VARCHAR(25) NOT NULL,
Title_ID VARCHAR(25) PRIMARY KEY);

-- Creating a table to store employee details
Create Table Employees(
Emp_No VARCHAR(25) NOT NULL,
Emp_title VARCHAR(25) NOT NULL,
birthday DATE,
First_Name VARCHAR(25),
Last_Name VARCHAR(25),
Sex VARCHAR(25),
Hire_Date Date,
FOREIGN KEY (Emp_title) REFERENCES Titles(Title_ID),
FOREIGN KEY (Emp_no) REFERENCES Salary(Emp_no));

-- Query 1: Selecting employee details along with their salary
SELECT E.Emp_No, E.Last_Name, E.First_Name, E.Sex , S.Salary
FROM  Employees E
JOIN  Salary S
ON (E.Emp_No = S.Emp_No);

-- Query 2: Selecting employees hired in a specific year
Select First_Name, Last_Name, Hire_Date
From Employees
Where Hire_Date >= '1986-01-01' And Hire_Date <= '1986-12-31'

-- Query 3: Selecting department managers and their details
Select M.Dept_no, D.Dept_Name, E.Emp_no, E.Last_Name, E.First_Name
FROM  Employees E
JOIN Department_Manager AS M
  ON E.Emp_no = M.Emp_no 
JOIN Department AS D
  ON M.Dept_no = D.Dept_no;

-- Query 4: Selecting employees and their department details
Select D.Dept_no, D.Dept_Name, E.Emp_no, E.Last_Name, E.First_Name
FROM  Employees As E
JOIN Department_Employee AS M
  ON E.Emp_no = M.Emp_no 
JOIN Department AS D
  ON M.Dept_no = D.Dept_no;
  
-- Query 5: Selecting employees with specific first and last names
Select First_Name, Last_Name, Sex
From Employees
Where First_Name = 'Hercules' And Last_Name Like 'B%';

-- Query 6: Selecting employees in the Sales department
Select E.Emp_no, E.Last_Name, E.First_Name, D.dept_name
FROM Employees E
  Inner JOIN Department_Employee AS M
    ON E.Emp_no = M.Emp_no 
  Inner JOIN Department AS D
    ON M.Dept_no = D.Dept_no
Where D.Dept_Name = 'Sales'
Order by E.emp_no;

-- Query 7: Selecting employees in the Sales and Development departments
Select E.Emp_no, E.Last_Name, E.First_Name
FROM Employees E
	JOIN Department_Employee AS M
  	ON E.Emp_no = M.Emp_no 
	JOIN Department AS D
 	ON M.Dept_no = D.Dept_no
Where D.Dept_Name IN ('Sales', 'Development');

-- Query 8: Counting employees with the same last name
SELECT Last_Name, COUNT(Last_Name) AS "Employees Count"
FROM Employees
GROUP BY Last_Name
ORDER BY "Employees Count" DESC;