1) Créez une requête qui permet de trouver pour chaque département les employés
avec le plus grand salaire. Pour cette question, on pourra faire une sous requête,
un join …

select e.department_id,e.first_name,e.last_name,d.salary salairemax
from employees e
         inner join  (select department_id ,max(salary) salary  from employees group by department_id) d
                     on e.department_id = d.department_id
                         and e.salary = d.salary;
order by 1,4 desc



2)
Même question mais cette fois en utilisant les fonctions de « windowing ». Motcle ROW_NUMBER()

//on cherche avec partition by ... les info pour chaque departement et après on filltre en prenant que la ligne n°1 donc le mieux payé
select * from (
                  select department_id,last_name,first_name,salary
                       ,row_number() over (partition by department_id order by salary desc) R
                  from employees
              ) A
where R=1// la on recupere le premier la premier ligne de la requete qui retourne les mecs le plus payé pour chaque departement_id
order by 1,4 desc

3)En utilisant une fonction de « windowing », votre requête doit renvoyer pour
    chaque employé l’EMPLOYEE_ID de la personne qui a le salaire au dessus.
    Pour cela, on peut trier les enregistrements comment en question 2 et faire une
    jointure

la strat ici , c'est' de trouver la personne qui a le salaire au dessus de lui
donc on va faire une premiere table ou on recupere le ligne de l'employe sur le classement des salaire'
et une deuxième en copie avec un left join pour recuperer ceux qui ont n'ont ' personne au dessus de eux
ensuite dans la jointure on va faire table on va afficher  les ligne de rank-1=rankcopie=2 donc afficher ceux qui sont en dessous

select * from (
                  select last_name,first_name,salary
                       ,row_number() over ( order by salary desc) Rank1
                  from employees
              ) A
                  left join  (select last_name,first_name,salary
                                   ,row_number() over ( order by salary desc) Rank2
                              from employees
) B
                             on A.Rank1-1=B.Rank2

4)





