-- 1 Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company. Use a nested SELECT statement.

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary = (SELECT MIN(Salary)
FROM Employees)

-- 2 Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary <= (SELECT MIN(Salary) * 0.10 + MIN(Salary)
FROM Employees)
ORDER BY Salary

-- 3 Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department. Use a nested SELECT statement.

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name],
Salary, DepartmentID
FROM Employees e
WHERE Salary = (SELECT MIN(Salary)
FROM Employees
WHERE DepartmentID = e.DepartmentID)
ORDER BY DepartmentID

-- 4 Write a SQL query to find the average salary in the department #1.

SELECT AVG(Salary) AS AverageSalary
FROM Employees
WHERE DepartmentID = 1

-- 5 Write a SQL query to find the average salary  in the "Sales" department.

SELECT AVG(Salary)
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

-- 6 Write a SQL query to find the number of employees in the "Sales" department.

SELECT COUNT(*)
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

-- 7 Write a SQL query to find the number of all employees that have manager.

SELECT COUNT(*)
FROM Employees
WHERE ManagerID IS NOT NULL

-- 8 Write a SQL query to find the number of all employees that have no manager.

SELECT COUNT(*)
FROM Employees
WHERE ManagerID IS NULL

-- 9 Write a SQL query to find all departments and the average salary for each of them.

SELECT d.Name, ROUND(AVG(e.Salary), 2) AS [Average Salary]
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY AVG(e.Salary)

-- 10 Write a SQL query to find the count of all employees in each department and for each town.

SELECT t.Name, d.Name, COUNT(*) AS [Number of Employees]
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
INNER JOIN Addresses a ON e.AddressID = a.AddressID
INNER JOIN Towns t ON a.TownID = t.TownID
GROUP BY d.Name, t.Name
ORDER BY d.Name

-- 11 Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.

SELECT m.EmployeeID AS [ManagerID], CONCAT(m.FirstName, ' ', m.LastName) AS [Manager Name], COUNT(m.EmployeeID)
FROM Employees m
INNER JOIN Employees e ON e.ManagerID = m.EmployeeID
GROUP BY m.EmployeeID, m.FirstName, m.LastName
HAVING COUNT(m.EmployeeID) = 5

-- 12 Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)"

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS [Employee Name],
ISNULL(m.FirstName + ' ' + m.LastName, '(no manager)') AS [Manager Name]
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID

-- 13 Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) function.

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name]
FROM Employees
WHERE LEN(LastName) = 5

-- 14 Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds". Search in  Google to find how to format dates in SQL Server.

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy HH:mm:ss:fff')

-- 15 Write a SQL statement to create a table Users. Users should have username,
-- password, full name and last login time. Choose appropriate data types for the 
-- table fields. Define a primary key column with a primary key constraint.
-- Define the primary key column as identity to facilitate inserting records. 
-- Define unique constraint to avoid repeating usernames. 
-- Define a check constraint to ensure the password is at least 5 characters long.

CREATE TABLE Users (
    UserId Int IDENTITY,
    Username nvarchar(10) NOT NULL,
    Password nvarchar(20) NOT NULL CHECK (LEN(Password) > 5),
    FullName nvarchar(50) NOT NULL,
    LastLoginTime DATETIME,
    CONSTRAINT PK_Users PRIMARY KEY(UserId),
    CONSTRAINT UQ_Username UNIQUE(Username),
) 
GO

-- 16 Write a SQL statement to create a view that displays the users from the Users table that have been in the system today. Test if the view works correctly.

CREATE VIEW [Users logged in today] AS
SELECT Username
FROM Users
WHERE DATEDIFF(day, LastLoginTime, GETDATE()) = 0

