Exécuter la requête suivante :
    SELECT e.emp_no
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01'
AND de.dept_no = 'd005'
AND year(e.hire_date) = 1985
AND CAST(e.emp_no AS varchar(500)) LIKE '1%'
Combien de temps prend-elle ? quelle serait la méthode la plus simple pour
optimiser le temps de réponse ?

    Le moyen efficace serait d'affihcher un index