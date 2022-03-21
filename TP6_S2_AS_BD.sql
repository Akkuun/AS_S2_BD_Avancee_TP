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
view , on ne peut plus inserer,update ou delete avec notre view, c'est bloqué'


6) ici pas de fonction pas de besoin de group by

create  or replace view BungalowEtCampings as
select idbungalow,nomBungalow,superficiebungalow,campings.idCamping,nomcamping from Bungalows join
    Campings on Campings.idcamping=Bungalows.idcamping



    insert into BungalowEtCampings VALUES  ('B13','Le Souterrain',75,'CAMP10','Yellow Shark')
 on ne peut pas inserer car on modifie plus d'une tablbe a cause de la jointure', on ne peut modifier qu'une table une par une '


insert into BungalowEtCampings (idbungalow,nombungalow,superficiebungalow) VALUES ('B14','Le Dépotoire',25)
ici on peut inserer car on n'interfere qu'' avec une table et on a sa cle primaire dans notre view'


UPDATE BungalowEtCampings SET superficieBungalow = 133 where nombungalow='Le Palace'
on peut bien Update car on ne change que une table

insert into BungalowEtCampings (idcamping,nombungalow) values ('CAMP11','Apelsin Mollusk')
ici dans la table camping ne respecte pas la contrainte d'unicité' (plusieurs fois id camping pareil) car un camping
peut avoir plsuieurs bugnalow donc même si toutes les conditions sont remplis cette contrainte d'unicité nous empeche d'inserer dans cette table

UPDATE BungalowEtCampings SET nombungalow='Le Majestique Blanc' where nombungalow='The White Majestic'
interdit de manipuler les données car ici on n'a pas la clé primaire dans la requête'



pour conclure la jointure nous empêche de modifier les deux tables en même temps, on ne peut en modifier que une par une



7)


create or replace view CampingsPalavas as
select idcamping,nomcamping,villecamping,nbEtoilesCamping from campings where villecamping='Palavas'





insert into CampingsPalavas values ('CAMP4','El Delfin Azul','Carnon',3)

on peut quand même inserer des ville qui ne sont pas de palavas actuellement

mais on ne peut pas le voir dans le view campingspalavas mais a bien été inserer dans la table campings

create or replace view CampingsPalavas as
select idcamping,nomcamping,villecamping,nbEtoilesCamping from campings where villecamping='Palavas'
with check option

create or replace view CampingsPalavas as
select idcamping,nomcamping,villecamping,nbEtoilesCamping from campings where villecamping='Palavas'
    with read only

8)

grant select on Clients to public

La table est visible par tous le monde.


    select * from DUCHEMINE.clients
    voir la table clients à partir d'une autre session'


    grant all on Clients to public
        donne tout les priviles a tout le monde pour écrire,lire,insérer ...PUBLIC

      insert into DUCHEMINE.clients values ('C60','toto','titi','20/12/2020','Totoland')
      COMMIT
      insère un tuple depuis la table , oublie pas de commit pour enregistrer la commande


create or replace view ClientEM as select * from clients


    revoke  all privileges on clients from PUBLIC

    enlève tout les privilège de ma table clients à un user


delete from DUCHEMINE.clients where villeclient='Totoland'




10)


R22)
create or replace view EmployeLFB as
select idemploye,nomemploye,prenomemploye,salaireemploye from employes where  idcamping in(

    select idcamping from campings where nomcamping='Les Flots Bleus'

)

Maintenant on peut faire la requete à partir de notre table qui retourne tout les employe du camping les flots bleu

select MIN(salaireemploye) from EmployeLFB

R87)

create or replace view EmployesParCamping as
select nomcamping,count(idemploye) as nbemploye from campings join employes on campings.idcamping=employes.idcamping group by (nomcamping)

on crée une view qui donne pour chaque camping le nombre d'employe'

select nomcamping from EmployesParCamping where nbemploye= (select MAX(nbemploye) from EmployesParCamping)

