R01

select  nom,prenom from client where villeClient = 'Montpellier' order by nomClient

R02


select  distinct clients.idClient, nomClient, prenomClient from client join location on client.idclient=location.idclient where montantLocation >1000

R03

select idClient,nomClient from  client join location on client.idClient=locations.idClient
 join   propose on location.idbungalow=propose.idbungalow
join service on service.idService=location.idService
where villeClient= 'Montpellier' and nomService='Climatisation'

R04

select nom, prenom from employes where idEmployeChef=(select idEmploye from enmploye where nom='Deuf' and prenom='John')

R05

select count (idBungalow)as nbcaravane from bungalows join camping on bungalows.idCamping=camping.idCamping where nomCamping ='Les Flots Bleus'

R06

select AVG(superficieBungalow) from bungalows join campings on bungalows.idCamping=camping.idCamping where
nomCamping ='Les Flots Bleus'

R07

select count (distinct  categorieService) from services

R08

select nomEploye from employes where salaireEmploye = (select max(salaireEmploye) from employe)

R09

select nomClient from client
minus
select nomClient from client join locations on clients.idclient=locations.idclient

R10

select nomBungalow,idBungalow from bungalows join propose on bungalows.idbungalow=propose.idbungalow join service on propose.idService=service.idService
where nomService='Climatisation'

intersect

select nomBungalow,idBungalow from bungalows join propose on bungalows.idbungalow=propose.idbungalow join service on propose.idService=service.idService
where nomService='TV'