1 Write a query to find the addresses (location_id, street_address, city, state_province,
country_name) in the database.

select street_address, location_id,city,state_province,country_name from locations join countries on  locations.COUNTRY_ID=countries.COUNTRY_ID

2 Write a query to find the names (first_name, last name), department ID and depatment name
of all the employees. Compare results with INNER JOIN and NATURAL JOIN. Explain Why


select first_name,last_name,employees.department_id from departments JOIN employees on employees.DEPARTMENT_ID=departments.DEPARTMENT_ID



    La principale différence entre INNER JOIN et NATURAL JOIN est que NATURAL JOIN
     effectue automatiquement la correspondance des colonnes qui ont le même nom et le même type de données
      dans les deux tables, tandis qu'INNER JOIN nécessite que vous spécifiez explicitement les colonnes sur lesquelles
       effectuer la correspondance. Cela signifie que NATURAL JOIN est souvent plus court et plus simple à écrire, mais il
        peut également être moins précis si vous avez des colonnes qui ont le même nom mais des types de données différents
         dans les deux tables.'


AVEC INNER JOIN on a les même resultats -> inner join

select first_name,last_name,employees.department_id from departments NATURAL JOIN employees ==> permet de faire une jointure sans préciser le lien entre les 2 tables
 avec natural join on a pas les mêmes résultat car il doit avoir une colonne dans une des deux tables qui ne doit pas idententique à celle de l'autre ' table

3 Display job title, employee name, and the difference between salary of the employee and
minimum salary for the job

select job_title,first_name,salary-min_salary from jobs NATURAL JOIN employees

4. Write a query to display the department name, manager name, and city


select DEPARTMENT_NAME,FIRST_name,city
from locations join departments on departments.LOCATION_ID=locations.LOCATION_ID
join employees on employees.DEPARTMENT_ID=departments.DEPARTMENT_ID where employees.EMPLOYEE_ID=departments.MANAGER_ID;

5. Write a query (using subquery) to find the names (first_name, last_name), the salary of the
employees whose salary is greater than the average salary

select first_name,last_name,salary from employees where salary > ( SELECT avg(salary) from employees);

6. Write a query to find the cities that have unused offices within the company

select city from locations where locations.LOCATION_ID not in (select location_id from departments );

7. Same query, but restricted to cities in Japan

select city from locations join countries on countries.COUNTRY_ID=locations.COUNTRY_ID where locations.LOCATION_ID not in (select location_id from departments )  and country_name like 'Japan'  ;

8. Find the names (first_name, last_name), job, department number, and department name of
the employees who work in London


select first_name,last_name,job_title,employees.department_id,department_name
from jobs join
     employees on employees.job_id=jobs.job_id
          join departments on departments.DEPARTMENT_ID=employees.DEPARTMENT_ID
          join locations on locations.LOCATION_ID=departments.LOCATION_ID where city = 'London'

9. Write a query to find all the employees hired before all the employees of department « SALES »

select first_name from employees join departments on departments.department_id=employees.department_id where hire_date < (

    select MIN(hire_date) from employees  join departments on departments.department_id=employees.department_id where department_name = 'Sales'
)


10 . Write a query to find the employee id, name (last_name) along with their manager_id,
    manager name (last_name)

select employee_id,last_name from employees
