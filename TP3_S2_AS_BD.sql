R5A

select categorieservice, count(categorieservice  )as nbservice
from services
group by (categorieservice)


R5B

select count(*),villeclient
from clients
group by (villeclient)
having count(idclient)>=3


R5C

select  nomcamping,AVG(salaireemploye)
from campings join employes on campings.idcamping=employes.idcamping
group by (nomcamping)

R5D

select nomcamping
from campings join employes on campings.idcamping=employes.idcamping
group by (nomcamping)
having count(idemploye)>3


R50

select clients.idclient,clients.nomclient,clients.prenomclient,count(idlocation)
from clients join locations on clients.idclient=locations.idclient
group by(clients.idclient,clients.nomclient,clients.prenomclient)
order by count(idlocation) DESC

R51

select nomcamping
from campings join employes on campings.idcamping=employes.idcamping
group by (nomcamping)
having AVG(salaireemploye)>1400

R52

select  nomclient,prenomclient
from clients
         join locations on clients.idclient=locations.idclient
         join bungalows on bungalows.idbungalow=locations.idbungalow
group by (nomclient,prenomclient,clients.idclient)
having count( distinct idcamping)=2 //ils peuvent être de même camping

R53

select  nombungalow,count( idservice)
from bungalows
         left join proposer on bungalows.idbungalow=proposer.idbungalow


group by ( nombungalow,bungalows.idbungalow)

order by count( idservice) DESC

R54

SELECT nomCamping
FROM campings c
         JOIN bungalows b ON c.idCamping = b.idCamping
WHERE superficieBungalow < 65
GROUP BY nomCamping, c.idCamping
ORDER BY COUNT (*);

R55

SELECT nomCamping
FROM Campings c
         JOIN employes e ON e.idCamping=c.idCamping
GROUP BY nomCamping, c.idCamping
HAVING MIN(salaireEmploye)>=1000;


R56 // on doit trouver le même nombre de service ue propose le ROayl donc sous-requête
select nombungalow
from bungalows join proposer on bungalows.idbungalow=proposer.idbungalow
group by(nombungalow)

having count(idservice)=(
    select count(idservice) from bungalows
        join proposer on bungalows.idbungalow=proposer.idbungalow
    where nombungalow='Le Royal'

)

R57 //left join pour avoir les cas avec 0

select nombungalow,count(idlocation)
from bungalows join campings on bungalows.idcamping=campings.idcamping
               left join locations on bungalows.idbungalow=locations.idbungalow
where nomcamping='La Décharge Monochrome'
group by (nombungalow)

R58

select distinct nomclient,prenomclient
from clients join locations on clients.idclient=locations.idclient

group by (clients.idclient,nomclient,prenomclient)
having count(idlocation)>1  AND  AVG(montantlocation)>1100

R59

R60
select distinct nombungalow
from bungalows join proposer on bungalows.idbungalow=proposer.idbungalow
               join services on proposer.idservice=services.idservice join locations on bungalows.idbungalow=locations.idbungalow
where nomservice='Kit de Bain'


R61

select nombungalow
from bungalows join locations on locations.idbungalow=bungalows.idbungalow
group by (nombungalow)
having count(nombungalow)>4

R62

//toute les campings qui ne sont pas dans la table des ville des clients => condition dans la table client




select count(idclient)
from clients

where not exists(


        select * from campings where campings.villecamping=clients.villeclient)

R63
Pour chaque bungalow dans le camping la décharge monochrome son service associé

select nombungalow,count(nomservice)
from bungalows left join proposer on bungalows.idbungalow=proposer.idbungalow
                left join services on services.idservice=proposer.idservice
               left join campings on campings.idcamping=bungalows.idcamping
where nomcamping='La Décharge Monochrome'
group by nombungalow


R64 // on doit repréciser le nom du camping pour bien prendre le min de notre table actuel soit
les bungalows du campings les flots bleu

select nombungalow from bungalows
                            join campings on campings.idcamping=bungalows.idcamping
where nomcamping='Les Flots Bleus'  and superficiebungalow =
                                        (select min(superficiebungalow)
                                        from bungalows join campings on campings.idcamping=bungalows.idcamping
                                        where nomcamping='Les Flots Bleus')

R65

SELECT nomBungalow
FROM Bungalows
WHERE idBungalow IN (SELECT idBungalow
                     FROM Proposer
                     GROUP BY idBungalow
                     HAVING COUNT(*) > 1)
  AND idBungalow IN (SELECT idBungalow
                     FROM Locations
                     GROUP BY idBungalow
                     HAVING COUNT(*) > 2);



R66

SELECT nomBungalow
FROM Bungalows b
WHERE NOT EXISTS (SELECT *
                  FROM Locations l
                  WHERE dateDebut <= '31/08/2021'
                    AND dateFin >= '01/08/2021'
                    AND l.idBungalow = b.idBungalow);
R67

SELECT chef.nomEmploye
FROM Employes chef
         JOIN Employes sub ON sub.idEmployeChef = chef.idEmploye
GROUP BY chef.nomEmploye, chef.idEmploye
HAVING COUNT(sub.idEmploye) > 1;

R68
SELECT nomClient, prenomClient
FROM Clients c
WHERE EXISTS (SELECT *
              FROM Locations l
              WHERE l.idClient = c.idClient)
  AND NOT EXISTS (SELECT *
                  FROM Locations l
                  WHERE montantLocation <= 1200
                    AND l.idClient = c.idClient);
ou
SELECT nomClient, prenomClient
FROM Clients c
         JOIN Locations l ON l.idClient = c.idClient
GROUP BY c.idClient, nomClient, prenomClient
HAVING MIN(montantLocation) > 1200;


R69

SELECT nomCamping
FROM Campings c
WHERE NOT EXISTS (SELECT *
                  FROM Bungalows b
                  WHERE b.idCamping = c.idCamping
                    AND idBungalow IN (SELECT idBungalow
                                       FROM Proposer
                                       GROUP BY idBungalow
                                       HAVING COUNT(idService) >=4));

