/***** question 1 *****/
create or replace PROCEDURE AjouterJourneeTravail (
p_codeSalarie Travailler.codeSalarie%TYPE,
p_codeProjet Travailler.codeProjet%TYPE,
p_dateTravail Travailler.dateTravail%TYPE) is

begin
insert into Travailler VALUES (p_codeSalarie,p_dateTravail,p_codeProjet);
UPDATE Salaries set nbTotalJourneesTravail = nbTotalJourneesTravail+1
where codeSalarie=p_codeSalarie;

end;
/
show errors ;


CALL AjouterJourneeTravail('S1','P1','02/02/2017');


create or replace trigger ajouterJourneeTravailTrigger after insert on travailler
for each row
begin
update salaries set nbTotalJourneesTravail = nbTotalJourneesTravail+1 where codeSalarie = :NEW.codeSalarie;


end;
/
show errors ;

/*** question 2***/

create or replace  PROCEDURE AffecterSalarieEquipe (

p_codeSalarie EtreAffecte.codeSalarie%TYPE,
p_codeEquipe EtreAffecte.codeEquipe%TYPE)
is
v_nbDansEquipe number:=0;
begin
select count(codeEquipe) into v_nbDansEquipe from ETREAFFECTE where
codeSalarie=p_codeSalarie;
if(v_nbDansEquipe>=3) then RAISE_APPLICATION_ERROR(-20001, 'Le salarié est déjà affecté à
au moins 3 équipes');
else insert into ETREAFFECTE values (p_codeSalarie,p_codeEquipe);
end if;
end;
/
show errors;


create or replace trigger ajouterElementEtreAffecter before insert on etreaffecte
for each row
DECLARE
v_nbDansEquipe number:=0;
begin
select count(codeEquipe) into v_nbDansEquipe from ETREAFFECTE where
        codeSalarie=:New.codeSalarie;
if(v_nbDansEquipe>=3) then RAISE_APPLICATION_ERROR(-20001, 'Le salarié est déjà affecté à
au moins 3 équipes');
else insert into ETREAFFECTE values (:New.codeSalarie,:New.codeEquipe);
end if;

end;
/
show errors;

/*** question 3***/

create or replace trigger nbTotalJournee after insert or update or delete on Travailler
for each row
begin
if (inserting or updating) then update salaries set nbTotalJourneesTravail = nbTotalJourneesTravail+1 where codeSalarie = :NEW.codeSalarie;
end if;
if (deleting or updating) then update salaries set nbTotalJourneesTravail = nbTotalJourneesTravail-1 where codeSalarie = :OLD.codeSalarie;
end if;
end;
/
show errors;