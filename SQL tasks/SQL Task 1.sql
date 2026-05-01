----- 1. Retrieve all records from a table named Employees. ---
select * from employees;
----- 2. Get the distinct departments from the Employees table.
select distinct department from employees;
----- 3. Count the total number of employees in the Employees table. 
select count(*) from employees;
----- 4. Retrieve all employees whose salary is greater than 50,000. 
select * from employees where salary>50000;
----- 5. List names of employees whose name starts with 'A'. 
select * from employees where empname like 'A%';
----- 6. Fetch the top 5 highest-paid employees. 
select * from employees order by salary desc LIMIT 5;
----- 7. Retrieve employees who do not have a manager (i.e., NULL in manager_id). 
select * from employees where empid In (select empid from managers where manager_id is null);
----- 8. Show all columns from Employees where hire_date is in 2024.
select * from employees where year(hire_date)=2024;
----- 9. Fetch records where department_id is either 10, 20, or 30.
select * from departments where department_id IN (10,20,30);        
----- 10. Get the total salary paid to all employees. 
select sum(salary) from employees;
----- 11. Fetch employee names along with their department names (use Employees and Departments tables). 
select empname,department from employees where empid In (select empid from departments);
----- 12. List all employees and their manager names.
select EmpName,ManagerName from employees,managers where employees.empid = managers.empid;
-- or
select EmpName,ManagerName from employees left join managers on employees.empid = managers.empid;
----- 13. Show employees who work in the same department as 'John'. 
select * from employees where department in (select department from employees where empname='John');
----- 14. Get a list of employees and their project names using a many-to-many relationship (via EmployeeProjects table). 
select * from employees;
select * from projects;
select * from EmployeeProjects;
select e.EmpID, e.EmpName, p.ProjectName from Employees e
join EmployeeProjects ep on e.EmpID = ep.EmpID
join Projects p on ep.ProjectID = p.ProjectID
ORDER BY e.EmpID;
----- 15. Write a query to display employees with no assigned project.
select e.EmpID, e.EmpName, p.ProjectName
from Employees e
left join EmployeeProjects ep on e.EmpID = ep.EmpID
left join Projects p on ep.Projectid=p.Projectid
WHERE ep.ProjectID IS NULL;
