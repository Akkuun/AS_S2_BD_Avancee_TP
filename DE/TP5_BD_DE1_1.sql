Ajoutez une colonne dans la table OrderDetails qui permettra de stocker le code
de l’article. Écrivez une requête qui permet de mettre à jour cette nouvelle
colonne

select * from tdjoin.orderdetails;
alter table orderdetails add ItemCode varchar(500);
update orderdetails inner join items set orderdetails.ItemCode=items.Id;


Écrivez une requête qui permet de mettre à jour toutes les commandes dont
l’article est de couleur est « Red » et ajouter la couleur dans le champ
« LineComment »

select * from tdjoin.items where Color like 'Red';
update orderdetails inner join items on items.Id=orderdetails.Id  set LineComment = CONCAT(LineComment, items.Color)
where Color='Red';

Écrivez une requête qui permet de mettre à jour le le champ « OrderComment ».
Si un des articles de la commande a le champ « Color = Red », il faut concaténer
le « OrderComment » et le champ « Color »


update orders inner join items on items.Id=orders.Id join orderdetails o on items.UnitPrice = o.UnitPrice set OrderComment = concat(OrderComment,items.Color)
where Color='Red';



Exécutez la requête dans le fichier « Question 4.txt ». Cette requête ajoute des
commandes avec un des articles invalides.
a. Écrivez une requête qui permet d’isoler les commandes avec des articles
invalides
b. Écrivez une requête qui permet de les supprimer

select * from orderdetails  where ItemId not in (select items.Id from items)



delete from orderdetails where ItemId not in (select items.Id from items);

Exécutez la requête dans le fichier « Question 5.txt ». Cette requête ajoute des
commandes qui sont sur des doublons d’articles.
a. Écrivez une requête qui permet de détecter les doublons.


select count(Code),Label,UnitPrice,Weight,Code,id as nb from items
group by Code
having count(Code)>1
autre méthde possible