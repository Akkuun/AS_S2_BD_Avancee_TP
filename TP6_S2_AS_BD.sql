/Une view est une référence  d'une table'
elle permet de creer de nouvelle tables à partir de référence de table

1)
create view BungalowsLFB(idbungalow,nombungalow,superficiebungalow) as
select idbungalow,nombungalow,superficiebungalow from campings
    join bungalows on campings.idcamping=bungalows.idcamping
        where nomcamping='Les Flots Bleus'




select count(idbungalow) from bungalowsLFB


2)

create view LocationLFB(idlocation,idClient,nomClient,prenomClient,idBungalow,nomBungalow)
    as select idlocation,
              clients.idClient,
              nomClient,
              prenomClient,
              locations.idBungalow,
              nomBungalow from bungalowsLFB
                  join locations on bungalowsLFB.idbungalow=locations.idbungalow
                  join clients on clients.idclient=locations.idclient


select idbungalow,nombungalow,count(idlocation) as nblocations
from LocationLFB
group by idbungalow,nombungalow

3) on peut update ou inserer sur la table car cette view contient la clé primaire de la source

create or replace view  EmployesSansCamping (idemploye,nomemploye,prenomemploye,salaireemploye,idemployechef)
    as select idemploye,nomemploye,prenomemploye,salaireemploye,idemployechef
       from employes where idcamping is null


INSERT INTO EmployesSansCamping
VALUES ('E100','vert','Harryco',3000,null)

UPDATE EmployesSansCamping
SET nomemploye='TOTO'
WHERE idemploye='E100'


delete
from EmployesSansCamping where idemploye='E100'

4)ici normalement on ne pas inserer car la vue ne contient pas la clé primaire de la source
mais on peut update les colonnes qui sont présentent dans la view

create or replace view employesaveccamping(nomemploye,prenomeploye,salaireemploye) as
select nomemploye,prenomemploye,salaireemploye from employes where idcamping is not null

5)

create or replace view clientsparville (ville,nbclient) as
select villeclient,count(idclient) as nbclient from clients
group by villeclient


    insert into clientsparville
   values ('Rodez',3)
on ne peut pas inserer car on a pas idclient la clé primaire


A cause du group by de notre view qui nous donne une colonne (nbclients) dans la
view , on ne peut plus inserer ou delete avec notre view, c'est bloqué'


6)



