1-Write a query to get the number of employees by job id


on groupe pour chaque job_id

select JOB_ID,count(*) from employees group by JOB_ID



2- . Write a query to get the job titles where the number of employees is greater than 4, ordered
    by descending order

on regroupe pour chaque titre d'emploi et on regarde que ceux (job title) qui ont plus de 4 employe'

select JOB_TITLE,count(*)
from jobs join employees e on jobs.JOB_ID = e.JOB_ID

group by JOB_TITLE having count(*)>4 order by count(*) desc

3- Write a query to find the manager ID and the salary of the lowest-paid employee for that
manager.


select MANAGER_ID,min(SALARY)
from employees group by MANAGER_ID
order by min(SALARY) desc

4 Same question as above but with the managers’ lastnames

5.Write a query to get the months in which more than 10 employees joined

on groupe pour chaque mois

select monthname(HIRE_DATE),count(*)
from employees group by monthname(HIRE_DATE)

6. Write a query to get the average salary for each job having more than 5 employees, ordered
    by the number of employees, in decreasing order.

    on groupe pour chaque job id et pour chaque ligne on recupère seulement celle qui ont plus de 5 employé

    select JOB_TITLE,avg(SALARY),count(*)
    from employees join jobs j on employees.JOB_ID = j.JOB_ID
    group by j.JOB_ID
    having count(j.JOB_ID)>5
    order by count(*) desc

7. Write a query to get the average salary for all departments employing more than 10
    employees.

    on groupe pour chaque departement et on compte que le nombre demploye soit > 10

    select departments.DEPARTMENT_ID,avg(SALARY)
    from departments join employees e on departments.DEPARTMENT_ID = e.DEPARTMENT_ID
    group by departments.DEPARTMENT_ID having count(EMPLOYEE_ID)>10

    8. Write a query to find the departments having an average salary higher than the company-wide
    average salary

ici on groupe pour chaque department name et on regarde que pour que la moyenne
soit > a la moyenne totale de la table (sous requete)

select DEPARTMENT_NAME,avg(SALARY) from departments join employees e on departments.DEPARTMENT_ID = e.DEPARTMENT_ID
group by DEPARTMENT_NAME having avg(SALARY)> (select avg(SALARY) from departments join employees e2 on departments.DEPARTMENT_ID = e2.DEPARTMENT_ID) order by avg(SALARY) desc


9.Write a query to return the total bonus (commission times salary) by department

ici on fait un produit dans le select, on doit le rajouter dans le group by et on groupe pour chaque departement

select employees.DEPARTMENT_ID,DEPARTMENT_NAME,COMMISSION_PCT*SALARY from employees left  join departments d on employees.DEPARTMENT_ID = d.DEPARTMENT_ID

group by DEPARTMENT_NAME order by DEPARTMENT_ID

10.

Extend the query 8 to get the average salaries for each department, the column « higher »
    indicates wether this average is larger than the average company one. Hint : use UNION.



11. Write a to find the number of employees per region

select REGION_NAME,count(EMPLOYEE_ID) from regions join countries c on regions.REGION_ID = c.REGION_ID join locations l on c.COUNTRY_ID = l.COUNTRY_ID join departments d on l.LOCATION_ID = d.LOCATION_ID join employees e on d.DEPARTMENT_ID = e.DEPARTMENT_ID group by REGION_NAME


12. Write a query to return the number of people with the same job, ordered in descending order

select  jobs.JOB_ID,JOB_TITLE,count(EMPLOYEE_ID) from jobs join employees e on jobs.JOB_ID = e.JOB_ID group by JOB_ID, JOB_TITLE
order by count(EMPLOYEE_ID) desc


13. Write a query to find the number of job positions occupied by more than one employee, as
well as the total number of employees in these positions.

select count(*) from (select count(*)
    from employees
    group by JOB_ID
    having count(*) > 1) as nouvelleTable


