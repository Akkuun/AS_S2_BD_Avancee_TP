1 - create database world

create database world

2- Write a SQL statement to create a simple table countries including columns
country_id,country_name and region_id, where the country is made of 1 or 3 characters, the
name cannot exceed 255 characters and the region ID is an integer.

CREATE TABLE countries (
  country_id VARCHAR(3) NOT NULL,
  country_name VARCHAR(255) NOT NULL,
  region_id INT NOT NULL,
  PRIMARY KEY (country_id)
);

3. Write a query to insert the country « France", identified by the id « FRA », with region id ‘1’

insert into countries (country_id, country_name, region_id)
values ('FRA','France',1);

4.
Write a query to insert the country « Mexico », identified by the id « MEX », no region specified

insert into countries (region_id,country_name,country_id)
values (1,'MEX','');

5. Alter the table countries to add the column country_id to the primary key (Google is your
friend). You can use command line or the menus of the Workbench.

alter table countries add constraint primary key on region_id

6. Try to insert the country France as in question 3

insert into countries
values (1,'FRA',1);

7. Alter the table countries to set the country_name as not null
ALTER TABLE coutries
    MODIFY column_name country_name NOT NULL;

8.Create a table « region » made of two columns, id (an auto increment integer) and a
mandatory column region_name as a string of maximum 60 caracters.

CREATE TABLE regions
(
region_id integer auto_increment ,
region_name varchar(60) not null ,
primary key (region_id)

)

9.Alter the table countries to add a foreign key reference from countries.region_id to region.id.
Why isn’t it possible ? Find a way

car un est une clé classique et l'autre' auto incrément donc pas de l'iason atomique car' les index s'incrémente tout seul'
faudra enlever le auto increment
10. Write a query to select the country names and their region names

11.
insert into regions (region_id, region_name) VALUE (1,'Europe');
insert into regions (region_id, region_name) VALUE (2,'Central America');
insert into regions (region_id, region_name) VALUE (3,'North America');
insert into regions (region_id, region_name) VALUE (4,'South America');
insert into regions (region_id, region_name) VALUE (5,'Asia');
insert into regions (region_id, region_name) VALUE (6,'Oceania');
insert into regions (region_id, region_name) VALUE (7,'Africa');

12. Clear the table countries, i.e. delete all rows

delete
from countries

15.Create a query to select the pair of cities of the same country, so that the smallest city has at
least 1M (million) population and the largest has at least 1M more population than the
smallest one

PART2


1. Open two MySQL client : 1 Workbench and 1 PhpMyAdmin or 2 Workbench, or 1
Workbench and 1 Dbeaver…
                     On client 1, start a new transaction :
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT * FROM city WHERE CountryCode=’FRA’;
→ How many results ?

40 rows
DELETE FROM city WHERE CountryCode=’FRA’;
SELECT * FROM city WHERE CountryCode=’FRA’;
→ How many results ?

0
On client 2 :
SELECT * FROM city WHERE CountryCode=’FRA’;
→ How many results ?
40 rows

On client 1:
COMMIT; OR ROLLBACK ;
→ As you wish, just agree with you and yourself !
SELECT * FROM city WHERE CountryCode=’FRA’;
→ How many results ?
0
On client 2 :
SELECT * FROM city WHERE CountryCode=’FRA’;
→ How many results ?

0


2. Find in documentation and try the different level of isolation :
REPEATABLE READ / READ COMMITTED / READ UNCOMMITTED / SERIALIZABLE
→ Can you find a little script for each case ?



READ UNCOMMITTED :
C'est le niveau d'isolation le plus faible. Les transactions peuvent accéder aux données non validées ou non encore confirmées. Cela peut entraîner des phénomènes de lecture sale (ou "dirty read"), où une transaction peut lire des données modifiées par une autre transaction qui n'a pas encore été confirmée. Cela peut également entraîner des phénomènes de lecture non répétable ("non-repeatable read"), où une transaction lit une ligne qui a été modifiée par une autre transaction après la lecture initiale.

READ COMMITTED :
Dans ce niveau d'isolation, les transactions peuvent accéder uniquement aux données confirmées. Cela permet d'éviter les phénomènes de lecture sale, mais peut entraîner des phénomènes de lecture non répétable, où une transaction peut lire une ligne qui a été modifiée par une autre transaction après la lecture initiale.

REPEATABLE READ :
Dans ce niveau d'isolation, les transactions peuvent accéder uniquement aux données confirmées et ne verront pas les modifications effectuées par d'autres transactions qui n'ont pas encore été confirmées. Cela permet d'éviter les phénomènes de lecture sale et de lecture non répétable, mais peut entraîner des phénomènes de lecture fantôme ("phantom read"), où une transaction peut voir une ligne qui a été ajoutée par une autre transaction qui n'a pas encore été confirmée.

SERIALIZABLE :
C'est le niveau d'isolation le plus élevé. Dans ce niveau, les transactions agissent comme si elles s'exécutaient séquentiellement, une après l'autre. Cela permet d'éviter tous les phénomènes d'isolation, y compris les phénomènes de lecture sale, non répétable et fantôme, mais cela peut entraîner une perte de performances, car les transactions doivent être sérialisées.

Il est important de choisir le niveau d'isolation approprié pour chaque transaction, en fonction des besoins en termes de performance et de l'importance de l'intégrité des données.







READ COMMITED

session1> BEGIN;
session1> SELECT firstname FROM names WHERE id = 7;
Aaron

session2> BEGIN;
session2> SELECT firstname FROM names WHERE id = 7;
Aaron
session2> UPDATE names SET firstname = 'Bob' WHERE id = 7;
session2> SELECT firstname FROM names WHERE id = 7;
Bob
session2> COMMIT;

session1> SELECT firstname FROM names WHERE id = 7;
Bob


REPEATABLE READ

session1> BEGIN;
session1> SELECT firstname FROM names WHERE id = 7;
Aaron

session2> BEGIN;
session2> SELECT firstname FROM names WHERE id = 7;
Aaron
session2> UPDATE names SET firstname = 'Bob' WHERE id = 7;
session2> SELECT firstname FROM names WHERE id = 7;
Bob
session2> COMMIT;

session1> SELECT firstname FROM names WHERE id = 7;
Aaron

READ UNCOMMITED

    https://stackoverflow.com/questions/4034976/difference-between-read-commited-and-repeatable-read-in-sql-server






