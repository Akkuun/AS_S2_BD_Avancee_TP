E1  P1 //travailler sur les 3 projet
E1  P2
E1  P3

E2 P2 //seulement sur deux

E2 P3


E3 P1 // que un


Projets  nombre projet en tout =3
P1
P2
P3

Quelle sont les employes qui ont bossé sur chaque projets

Select idenmploye from etreaffecte
group by idemploye
having count(*)=(select  count(*) from projets)

R70 //on compte dans les bungalow qui proposent des services

select nombungalow from bungalows
    join proposer on bungalows.idbungalow=proposer.idbungalow
    join services on proposer.idservice=services.idservice
group by nombungalow
having count(proposer.idservice)= (select count(nomservice) from services)

R71 //correlation donc where dans la table de base et la sous requête

select nombungalow from bungalows
                            join proposer on bungalows.idbungalow=proposer.idbungalow
                            join services on proposer.idservice=services.idservice where categorieservice='Luxe'
group by nombungalow
having count(proposer.idservice)= (select count(nomservice) from services where categorieservice='Luxe')

R72 // si une condition en bas ne pas oublier de la rajouter la même en haut


select nombungalow from bungalows // dans les bungalow ceux qui propose les même service que le bungalow la poubelle
join proposer on bungalows.idbungalow=proposer.idbungalow
where idservice in ( select idservice from proposer join bungalows on proposer.idbungalow=bungalows.idbungalow where nombungalow='La Poubelle')



group by nombungalow // pour chaque bungalow on compte le nombre de service proposer dans la table proposer pour le bungalow la poubelle
having count(*)= (select count(idservice) from proposer join bungalows on proposer.idbungalow=bungalows.idbungalow where nombungalow='La Poubelle')

R73 //on va chercher les clients qui on fait une location

select nomclient from clients
join locations on clients.idclient=locations.idclient
join bungalows on bungalows.idbungalow=locations.idbungalow
join campings on campings.idcamping=bungalows.idcamping
group by nomclient,clients.idclient // et pour chaque client distinct on compte le fait que leur nombre de villecamping = nb villecamping dans les ville de campings
having count(distinct villecamping) = (select count(distinct villecamping) from campings)

R74




R80

select nomclient,prenomclient,idclient from clients where not exists(

        select idclient from locations join bungalows on locations.idbungalow=bungalows.idbungalow join campings on campings.idcamping=bungalows.idcamping where locations.idclient=clients.idclient and villecamping='Palavas'

    )
order by nomclient

R81

R82 //condition dans la sous requete donc mettre cette condiation dans la requete de base

//en premier on va chercher le bungalow du camping les flots bleus qui a la superficie la plus grande
select nomservice from services
    join proposer on services.idservice=proposer.idservice
    join bungalows on bungalows.idbungalow = proposer.idbungalow
    join campings on campings.idcamping=bungalows.idcamping
    where nomcamping='Les Flots Bleus' and superficiebungalow =
                                           (select max(superficiebungalow)   from bungalows
                                               join campings on campings.idcamping=bungalows.idcamping
                                                        where nomcamping='Les Flots Bleus')

R83

SELECT e.nomEmploye, e.prenomEmploye, COUNT(sub.idEmploye) AS "NB SUBORDONNES"
FROM Employes e
         JOIN Campings c ON e.idCamping = c.idCamping
         LEFT OUTER JOIN Employes sub ON sub.idEmployeChef = e.idEmploye
WHERE nomCamping = 'La Décharge Monochrome'
GROUP BY e.idEmploye, e.nomEmploye, e.prenomEmploye;

R84

SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS (SELECT *
                  FROM Bungalows b
                  WHERE superficieBungalow <= 50
                    AND b.idCamping = c.idCamping);

R85

SELECT nomClient
FROM Clients c
         JOIN Locations l ON c.idClient = l.idClient
GROUP BY c.idClient, nomClient
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM Locations l
                            JOIN Clients c ON l.idClient = c.idClient
                   WHERE nomClient = 'Zeblouse'
                     AND prenomClient = 'Agathe');

R86

SELECT nomService
FROM Services s
         LEFT OUTER JOIN Proposer p ON p.idService = s.idService
GROUP BY s.idService, nomService
HAVING COUNT(idBungalow) < 5;

R87
SELECT nomCamping
FROM Campings c
         JOIN Employes e ON e.idCamping = c.idCamping
GROUP BY c.idCamping, nomCamping
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM Employes
                   GROUP BY idCamping);

R88

SELECT nomBungalow
FROM Bungalows b
         JOIN Proposer p ON b.idBungalow = p.idBungalow
         JOIN Services s ON p.idService = s.idService
GROUP BY b.idBungalow, nomBungalow
HAVING COUNT(DISTINCT categorieService) = (SELECT COUNT(DISTINCT categorieService)
                                           FROM Services);

R89

SELECT nomBungalow
FROM Bungalows b1
WHERE NOT EXISTS (SELECT idService
                  FROM Bungalows b
                           JOIN Proposer p ON b.idBungalow = p.idBungalow
                  WHERE nomBungalow = 'La Suite Régalienne'
                  MINUS
                  SELECT idService
                  FROM Proposer p
                  WHERE p.idBungalow = b1.idBungalow)
  AND NOT EXISTS (SELECT idService
                  FROM Proposer p
                  WHERE p.idBungalow = b1.idBungalow
                  MINUS
                  SELECT idService
                  FROM Bungalows b
                  JOIN Proposer p ON b.idBungalow = p.idBungalow
                  WHERE nomBungalow = 'La Suite Régalienne');


R90

SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS (SELECT *
                  FROM Locations l
                  WHERE l.idBungalow = b.idBungalow)
  AND superficieBungalow = (SELECT MIN(superficieBungalow)
                            FROM Bungalows b
                            WHERE NOT EXISTS (SELECT *
                                              FROM Locations l
                                              WHERE l.idBungalow = b.idBungalow));


R91
SELECT nomBungalow
FROM Bungalows b1
WHERE superficieBungalow > (SELECT AVG(superficieBungalow)
                            FROM Bungalows b2
                            WHERE b2.idCamping = b1.idCamping);

R92

SELECT nomCamping, nomEmploye, prenomEmploye
FROM Campings c
         JOIN Employes e ON c.idCamping = e.idCamping
WHERE (salaireEmploye, c.idCamping) IN (SELECT MAX(salaireEmploye), idCamping
                                        FROM Employes
                                        GROUP BY idCamping);


