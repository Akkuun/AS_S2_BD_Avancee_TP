R01 //Nom et prénom des client qui habitent dans la ville de Montpellier classé dans l'ordre' lexicographique de leur nom

select  nom,prenom from client where villeClient = 'Montpellier' order by nomClient

R02 l'identifiant , le nom, et le prenom des client' qui ont réaliser au moins une location qui a couté plus de 1000 euro


select  distinct clients.idClient, nomClient, prenomClient from client
    join location on client.idclient=location.idclient
where montantLocation >1000

R03 identifiant et le nom des clients Montpellelierrain qui ont loue un bungalow qui porpose le service climatisation

select  idClient,distinct nomClient from  client join location on client.idClient=locations.idClient
 join   propose on location.idbungalow=propose.idbungalow
join service on service.idService=location.idService
where villeClient= 'Montpellier' and nomService='Climatisation'

R04 nom et prenom du chef de lemploye John Deuf

select nom, prenom from employes where idEmployeChef IN (select idEmploye from enmploye where nom='Deuf' and prenom='John')

R05 le nombre de bungalow que possède le camping 'Les flots Bleu'

select count (idBungalow)as nbcaravane from bungalows join camping on bungalows.idCamping=camping.idCamping where nomCamping ='Les Flots Bleus'

R06 la superficie moyenne des bungalow du camping 'Les flots Bleu'

select AVG(superficieBungalow) from bungalows join campings on bungalows.idCamping=camping.idCamping where
nomCamping ='Les Flots Bleus'

R07 le nombre de catégorie de service

select count (distinct  categorieService) from services

R08 le nom de lemploye le mieux paye

select nomEploye from employes where salaireEmploye = (select max(salaireEmploye) from employe)

R09 le nom des client qui nont jamais realise de location

select nomClient from client
minus
select nomClient from client join locations on clients.idclient=locations.idclient

R10 le nom de bungalow et lidentifiant du camping des bungalow qui proposenet a la fois le service Climatisation et service TV

select nomBungalow,idBungalow from bungalows join propose on bungalows.idbungalow=propose.idbungalow join service on propose.idService=service.idService
where nomService='Climatisation'

intersect

select nomBungalow,idBungalow from bungalows join propose on bungalows.idbungalow=propose.idbungalow join service on propose.idService=service.idService
where nomService='TV'

EXISTS synthaxe :




SELECT *
FROM table 1
WHERE EXISTS (
              SELECT *
              FROM table 2
              WHERE table 2.aa=table 1.aa and condition
          )
 // cest possible de lier une autre table dans le premier from afin de le relier dans le where

R11 // le exists  renvoie les elements qui sont bien présent dans la "jointure"
SELECT nomemploye,prenomemploye
FROM employes
WHERE EXISTS (
              SELECT nomemploye,prenomemploye
              FROM campings
              WHERE employes.idcamping=campings.idcamping  // fait office de jointure
                and nomcamping='Les Flots Bleus'
          )
order by salaireemploye DESC


// le join de preference que avec un select sur une clé primaire avec une relation un plusieurs

R12  // a corriger

SELECT DISTINCT c.idClient, nomClient, prenomClient FROM clients c
                                                             JOIN locations l ON c.idClient = l.idClient
                                                             JOIN bungalows b ON b.idBungalow = l.idBungalow
                                                             JOIN campings cp ON cp.idCamping = b.idCamping
WHERE villeCamping = 'Palavas';

R13 // imbrication de 2 exists

select nomclient from clients
where exists ( //premier exists  pour la premier jointure
              select nomclient from
                  locations where clients.idclient=locations.idclient  and EXISTS (

                      select nomclient from bungalows where locations.idbungalow=bungalows.idbungalow // deuxieme jointure
                        and nomBungalow='Le Caniveau'
                  )

          )
order by nomclient

R14 // on cherche les villeclient qui sont aussi present dans villecamping de camping
on met in car on peut attendre plusieurs reponses

select nomclient,prenomclient from clients
where villeclient in (
    select villecamping from campings

)

R15  // sous requête = car on attend que une reponse

select nomemploye,prenomemploye from employes where idemployechef =(
    select idemploye from employes where nomemploye ='Alizan' and prenomemploye='Gaspard'

)


R16


select locations.idclient,prenomclient,nomclient from clients join locations on clients.idclient=locations.idclient  join bungalows on locations.idbungalow=bungalows.idbungalow join campings on campings.idcamping=bungalows.idcamping


where datedebut<='14/07/21' and nomcamping ='Les Flots Bleus' and datefin >'14/07/21'

R17 // a corrige

SELECT nomClient, prenomClient FROM clients c
WHERE EXISTS (
              SELECT * FROM locations l
              WHERE c.idClient = l.idClient
                AND dateDebut <= '31/07/2021'
                AND dateFin >= '01/07/2021'
                AND EXISTS (
                      SELECT * FROM bungalows b
                      WHERE b.idBungalow = l.idBungalow
                        AND EXISTS (
                              SELECT * FROM campings cp
                              WHERE cp.idCamping = b.idCamping
                                AND nomCamping = 'Les Flots Bleus'
                          )
                  )
          );

R18

select  count (nomservice) as nbservice from services join proposer on services.idservice=proposer.idservice where idbungalow = (
    select idbungalow from bungalows where nombungalow ='Le Titanic'

)

R19

select max(salaireemploye) from employes where idcamping IN (
    select idcamping from campings where nomcamping='Les Flots Bleus'


)

R20

select  count( distinct idcamping) as nbcamping from campings where idcamping in(
    select campings.idcamping from campings join bungalows on bungalows.idcamping=campings.idcamping join locations on locations.idbungalow=bungalows.idbungalow join clients on locations.idclient=clients.idclient where nomclient='Zeblouse' and prenomclient='Agathe'


)
R21
select nombungalow from bungalows where superficiebungalow =(
    select max(superficiebungalow) from bungalows

)

R22

select nomemploye,prenomemploye
from employes join campings on employes.idcamping=campings.idcamping  where nomcamping='Les Flots Bleus' and salaireemploye in(
    select min(salaireemploye) from employes where  idcamping=(

        select idcamping from campings
        where nomcamping='Les Flots Bleus'

    )

)

R23 // minus, union,intersect toujours avec les cle primaire

select nombungalow from bungalows where not exists (
        select idbungalow from proposer where proposer.idbungalow=bungalows.idbungalow
    )

ou bien

SELECT nomBungalow FROM Bungalows b
WHERE idbungalow NOT in (SELECT idBungalow FROM Proposer p);


R24

SELECT nomEmploye, prenomEmploye FROM employes
WHERE idEmploye IN (
    SELECT idEmploye FROM employes
                              MINUS
SELECT chef.idEmploye FROM employes chef
                               JOIN employes sub ON sub.idEmployeChef = chef.idEmploye
    );

R25

SELECT b.idBungalow, nomBungalow FROM Bungalows b
                                          JOIN Campings ca ON b.idCamping = ca.idCamping
WHERE nomCamping = 'La Décharge Monochrome'
UNION
SELECT b.idBungalow, nomBungalow FROM Bungalows b
                                          JOIN Proposer p ON b.idBungalow = p.idBungalow
                                          JOIN Services s ON p.idService = s.idService
WHERE nomService = 'Kit de Bain';

R26

select nombungalow from bungalows where not exists(

        select * from services join proposer on services.idservice=proposer.idservice where
                bungalows.idbungalow=proposer.idbungalow and nomService='TV')
intersect
select nombungalow from bungalows where not exists(

        select * from services join proposer on services.idservice=proposer.idservice where
                bungalows.idbungalow=proposer.idbungalow and nomService='Climatisation'  )

27

SELECT nomClient, prenomClient
FROM Clients
WHERE idClient IN (SELECT idClient
                   FROM Locations l
                            JOIN Bungalows b ON l.idBungalow = b.idBungalow
                            JOIN Campings c ON b.idCamping = c.idCamping
                   WHERE nomCamping = 'Les Flots Bleus'
                   INTERSECT
                   SELECT idClient
                   FROM Locations l
                            JOIN Bungalows b ON l.idBungalow = b.idBungalow
                            JOIN Campings c ON b.idCamping = c.idCamping
                   WHERE nomCamping = 'La Décharge Monochrome')
ORDER BY nomClient, prenomClient ;




R28
SELECT nomEmploye, prenomEmploye, nomCamping
FROM Employes e
         JOIN Campings c ON e.idCamping = c.idCamping
UNION
SELECT nomEmploye, prenomEmploye, 'Pas affecté à un camping'
FROM Employes e
WHERE idCamping IS NULL
ORDER BY nomEmploye;




