// le join de preference que avec un select sur une clé primaire avec une relation un plusieurs
// Opérateurs ensembliste uniquement sur les clées primaire
// Not in ne marche pas si il y a des valeurs null dans la sous requête sauf si on met une confidition  where idxxx is not null
// Not exists performante dans tous les cas
R3A
select nomemploye,prenomemploye from employes where idemployechef is null

R3B
select nombungalow from bungalows where not exists (
        select * from locations where locations.idbungalow=bungalows.idbungalow

    )

ou bien

select nombungalow from bungalows where idbungalow not in (
    select idbungalow from locations

)

ou bien

select nombungalow from bungalows
where idbungalow in (

    select idbungalow from bungalows minus
select bungalows.idbungalow from bungalows join locations on bungalows.idbungalow=locations.idbungalow


    )

R30

select nomcamping from campings where not exists(
        select * from employes where campings.idcamping=employes.idcamping

    )

R31

select count(distinct idbungalow) from bungalows where not exists(
        select * from proposer where proposer.idbungalow=bungalows.idbungalow
    )

R32

select nomclient from clients

where not exists (

        select * from bungalows join locations on bungalows.idbungalow=locations.idbungalow
        where clients.idclient=locations.idclient and superficiebungalow<58

    ) and idclient in(select idclient from locations)  // il ya une condition dans le not exists on doit donc verifier quil sont bien dans la classe location et après on va filtrer

R33 // tous ==antijointure

select nomcamping from campings where not exists( // ceux qui ont pas un salaire <1000
        select * from employes where employes.idcamping=campings.idcamping and salaireemploye<1000

    ) and idcamping in (select idcamping from employes) // parmis tous les employes

R34

SELECT nomClient
FROM Clients
WHERE villeClient = 'Montpellier'
  AND NOT EXISTS (SELECT *
                  FROM Locations
                  WHERE Locations.idClient = clients.idClient
                    AND NOT EXISTS (SELECT *
                                    FROM Proposer
                                    WHERE Proposer.idBungalow = locations.idBungalow));


R40 // parmis tout les clients ceux qui ont fait au moins une locatione et qui existe dans la table où la villecamping est la même que la ville client

select  distinct clients.idclient,nomclient,prenomclient from clients

                    join locations on clients.idclient=locations.idclient where  exists(
                                  select * from campings where campings.villecamping=clients.villeclient
                                                                                         )
R41

select count(distinct bungalows.idbungalow) from bungalows join locations on bungalows.idbungalow=locations.idbungalow where idcamping=(

    select idcamping from campings where nomcamping ='La Décharge Monochrome'
) and idclient =( select idclient from clients where nomclient='Zeblouse')

R42

select nomclient,prenomclient from clients where not exists (
        select * from locations join bungalows on locations.idbungalow=bungalows.idbungalow join
            campings on campings.idcamping=bungalows.idcamping where locations.idclient=clients.idclient and nomcamping='Les Flots Bleus')

R43 // copie de la table employe avec e2 pour avoir les couples chef employe puis left join pour avoir aussi les
couple vide

SELECT employes.nomemploye,employes.prenomemploye,e2.nomemploye as nomemployechef
from employes left join employes e2 on employes.idemployechef=e2.idemploye
order by nomemploye

R44 // on fait une copie de la copie pour avoir les suborodee des surbonnes des employes

SELECT distinct  e3.nomemploye,e3.prenomemploye
from employes left join employes e2 on employes.idemployechef=e2.idemploye
              join employes e3 on e2.idemployechef=e3.idemploye
order by nomemploye

R45 // ici je cherche les villeclient qui n existe pas dans la table des campings qui ont leur ville
= a la ville du client

select distinct  villeclient from clients where not exists(

        select * from campings where clients.villeclient=campings.villecamping )

R46





