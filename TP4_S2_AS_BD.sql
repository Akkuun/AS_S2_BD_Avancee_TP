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

