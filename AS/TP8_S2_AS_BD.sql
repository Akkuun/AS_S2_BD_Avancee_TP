/*** question 6        **/


CREATE
OR
REPLACE FUNCTION nbEtudiantsParGroupe(p_idGroupe groupes.idgroupe%TYPE) RETURN NUMBER IS
      v_nbEleves NUMBER;
v_nbGroupe NUMBER;
BEGIN
SELECT COUNT(*)
INTO v_nbEleves
FROM Groupes
WHERE idGroupe = p_idGroupe;

IF v_nbEleves > 0
THEN
SELECT COUNT(*)
INTO v_nbEleves
FROM Etudiants
WHERE idGroupe = p_idGroupe;
RETURN v_nbEleves;
ELSE
RETURN NULL;
END IF;

END;
/     <- permet de compiler le code avant et lancer une autre execution
SHOW ERRORS;

SELECT nbEtudiantsParGrocreate
           or
       replace function nbEtudiantsParPromotion (p_idPromotion IN Promotions.idPromotion%TYPE) RETURN NUMBER is
value_nbEleves NUMBER;
BEGIN
select SUM(nbEtudiantsParGroupe(idGroupe))
into value_nbEleves
from groupes
where idpromotion = p_idPromotion;
return value_nbEleves;
upe
    ('T1')
    FROM DUAL;

/*****question 7*********
 */
/*  pn peut faire désomrais select count(*) from nbetudiantParGroupe */



end;
/
show errors;

/*   deuxieme partie où on met à jour l'attribut de la table promotion avec le résultat obtenu      */
SELECT nbEtudiantsParPromotion('A1')
FROM DUAL;


create
or
replace function nbEtudiantsParPromotion (p_idPromotion IN Promotions.idPromotion%TYPE) RETURN NUMBER is
value_nbEleves NUMBER;
BEGIN
select SUM(nbEtudiantsParGroupe(idGroupe))
into value_nbEleves
from groupes
where idpromotion = p_idPromotion;

update promotions
set nbEtudiantsPromotion = value_nbEleves
where idpromotion = p_idPromotion;

return value_nbEleves; /* return marque la fin de la fonction*/
end;
/
show errors;


SELECT nbEtudiantsParPromotion('A1')
FROM DUAL;


/**** question 8 ***********/


create
or
replace procedure affichageInfosEtudiant( p_idEtudiant IN Etudiants.idEtudiant%TYPE) is

value_attribut_etu etudiants%ROWTYPE;
begin
select *
into value_attribut_etu
from etudiants
where idetudiant = p_idEtudiant;
DBMS_OUTPUT.PUT_LINE('ID etudiant : ' || value_attribut_etu.IDETUDIANT);
DBMS_OUTPUT.PUT_LINE('Nom etudiant : ' || value_attribut_etu.NOMETUDIANT);
DBMS_OUTPUT.PUT_LINE('Prenom etudiant : ' || value_attribut_etu.PRENOMETUDIANT);
DBMS_OUTPUT.PUT_LINE('Sexe etudiants : ' || value_attribut_etu.sexeetudiant);
DBMS_OUTPUT.PUT_LINE('Date naissance etudiant  : ' || value_attribut_etu.datenaissanceetudiant);
DBMS_OUTPUT.PUT_LINE('Groupe etudiant : ' || value_attribut_etu.IDGROUPE);

exception when no_data_found then DBMS_OUTPUT.PUT_LINE('erreur');
end;
/
show errors;



/*** question 9 à faire plus tard ****/

CREATE OR REPLACE PROCEDURE miseAJourCoefficientModules IS
BEGIN
UPDATE Modules mo
SET coefficientModule = (SELECT SUM(coefficientMatiere)
                         FROM Matieres ma
                         WHERE ma.idModule = mo.idModule);
END;


/*** question 10 ****/
create
or
replace PROCEDURE affichageNotesEtudiant(p_idEtudiant IN Etudiants.idEtudiant%TYPE) is
begin for v_ligne in ( select nommatiere,note from notes join matieres on matieres.idmatiere=notes.idmatiere where idetudiant = p_idEtudiant) LOOP
    DBMS_OUTPUT.PUT_LINE( v_ligne.nommatiere || ' : ' || v_ligne.note);
end loop;
end;
/
show errors;


/*** question 11 ***/

create
or
replace PROCEDURE affichageNotesEtudiantSemestre(p_idEtudiant IN Etudiants.idEtudiant%TYPE,
                                                                p_idSemestre IN Semestres.idSemestre%TYPE) is

    v_idetudiant NUMBER;

begin

select count(idetudiant)
into v_idetudiant
from etudiants
where idetudiant = p_idetudiant; /*c'est comme un if idgroupe existe in groupe res=true else res=false'*/

if v_idetudiant>0
then

for v_ligne in ( select nommatiere,note from notes join matieres on matieres.idmatiere=notes.idmatiere
    join modules on modules.idmodule=matieres.idmodule
    where idetudiant = p_idEtudiant and idsemestre = p_idSemestre ) LOOP
    DBMS_OUTPUT.PUT_LINE( v_ligne.nommatiere || ' : ' || v_ligne.note);
end loop;
else
   DBMS_OUTPUT.PUT_LINE( 'error mon KOYOUAH');
end if;

end;
/
show errors;


/*** question 12 ***/
create
or
replace PROCEDURE affichageToutEtudiantSemestre(
                                                        p_idEtudiant IN Etudiants.idEtudiant%TYPE,
                                                        p_idSemestre IN Semestres.idSemestre%TYPE) is

begin
    affichageInfosEtudiant
    (p_idetudiant);
affichageNotesEtudiantSemestre
    (p_idetudiant,p_idsemestre);


end;
/
show errors;


/**** question 14 ****/
/*** debut TPERIGE 4**/

create or replace function moyenneEtudiantModule(p_idEtudiant IN Etudiants.idEtudiant%TYPE,p_idModule IN Modules.idModule%TYPE)
RETURN NUMBER is
v_nbCoefficientDansModule NUMBER;
v_note NUMBER;
BEGIN
v_note:=0;
Select sum(note*coefficientMatiere)/sum(coefficientMatiere) into v_note
From Matieres M
         Join Notes N On M.idMatiere=N.idMatiere
Where idEtudiant=p_idEtudiant and idModule = p_idModule;

RETURN v_note;
end;
/
show errors;

/*** question 15***/
create or replace FUNCTION valideEtudiantModule(p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idModule IN Modules.idModule%TYPE) RETURN NUMBER is
v_note number;
begin

if moyenneEtudiantModule(p_idEtudiant,p_idModule)>=8  then return 1;
else return 0;
end if;
end;
/
show errors;


/*** question 16 ***/

create or replace FUNCTION moyenneEtudiantSemestre (p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE)
RETURN NUMBER is

v_moyenneSemestre NUMBER;
begin
Select sum(moyenneEtudiantModule (p_idEtudiant, idModule)*coefficientModule)/sum(coefficientModule) Into v_moyenneSemestre
From Modules Mo
Where idSemestre=p_idSemestre;
RETURN v_moyenneSemestre;
END;
/
show errors;


/*** question 17****/


Create Or Replace PROCEDURE affichageMoyEtudiantSemestre(p_idEtudiant IN Etudiants.idEtudiant%TYPE, p_idSemestre IN Semestres.idSemestre%TYPE)
Is

Begin
    affichageInfosEtudiant( p_idEtudiant);

For moyenne in
(Select nomModule, idModule
From Modules Mo
Where idSemestre =  p_idSemestre)
Loop

For noteMat in
(Select note, nomMatiere
From Notes N
Join Matieres Ma On N.idMatiere=Ma.idMatiere
Where idEtudiant= p_idEtudiant and idModule = moyenne.idModule )
Loop
Dbms_Output.Put_Line(noteMat.nomMatiere || ' : ' || noteMat.note);

End Loop;
Dbms_Output.Put_Line('Moyenne module ' || moyenne.nomModule || ' : ' || moyenneEtudiantModule(p_idEtudiant, moyenne.idModule));
End Loop;
Dbms_Output.Put_Line('Moyenne semestre  :  ' || moyenneEtudiantSemestre(p_idEtudiant,p_idSemestre));
End;


/**** question18 ****/


create or replace FUNCTION valideSemestre(p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE)
RETURN VARCHAR is
v_moyenneSemestre NUMBER;
v_note NUMBER;
v_compteur NUMBER;
v_boolean NUMBER;
v_totalSemestre NUMBER;
BEGIN
v_note:=0;
v_compteur:=0;
v_boolean:=0;
v_totalSemestre:=0;
for v_ligne in (select Modules.idmodule from modules join
matieres on matieres.idmodule=modules.idmodule
join notes on notes.idmatiere=matieres.idmatiere where idetudiant=p_idEtudiant) loop

if (moyenneEtudiantModule(p_idetudiant,v_ligne.idmodule)>=8) then v_boolean:=1;
else v_boolean:=0;
end if;
end loop;
v_totalSemestre:=moyenneEtudiantSemestre(p_idetudiant,p_idsemestre);
if(v_boolean=1 and v_totalSemestre>=10)
then return 'O';
else return 'N';
end if;
end;
/
show errors ;


/*** question 19 ***/

Create Or Replace FUNCTION classementEtudiantSemestre(p_idEtudiant IN Etudiants.idEtudiant%TYPE, p_idSemestre IN Semestres.idSemestre%TYPE)
RETURN NUMBER Is
moyEtud Number;
NbmoyEtudSup Number;
Begin
Select moyenneEtudiantSemestre(p_idEtudiant,  p_idSemestre) into moyEtud
From Etudiants
Where idEtudiant=p_idEtudiant;

Select count(moyenneEtudiantSemestre(idEtudiant,  p_idSemestre)) into NbmoyEtudSup
From Etudiants
Where moyenneEtudiantSemestre(idEtudiant,  p_idSemestre) > moyEtud;

Return NbmoyEtudSup+1;
End;
/
show errors;
/** question 20 **/

create or replace PROCEDURE affichageResEtudiantSemestre(

p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE)
 is

begin

DBMS_OUTPUT.PUT_LINE('Resultat :  '|| validesemestre(p_idetudiant,p_idsemestre));
DBMS_OUTPUT.PUT_LINE('Classement : ' ||classementEtudiantSemestre(p_idetudiant,p_idsemestre));

end;
/
show errors ;

/*** question 21 **/

create or replace PROCEDURE affichageReleveNotes(

p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE) is
begin
    affichageMoyEtudiantSemestre(p_idetudiant,p_idsemestre);
affichageResEtudiantSemestre(p_idetudiant,p_idsemestre);
end;
/
show errors;
/*** partie5***/
/** question 22***/

create or replace procedure lignes(p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE)  is
begin
    DBMS_OUTPUT.PUT('+-----------------------+');
For moyenne in
(Select nomModule, idModule
From Modules Mo
Where idSemestre =  p_idSemestre)
Loop
for note in (select note from notes join matieres on matieres.idmatiere=notes.idmatiere join
modules on matieres.idmodule=modules.idmodule
where matieres.idmodule=moyenne.idmodule and notes.idetudiant=p_idetudiant )loop
DBMS_OUTPUT.PUT('------');
End Loop;
DBMS_OUTPUT.PUT('+');
DBMS_OUTPUT.PUT('------');
DBMS_OUTPUT.PUT('++');
end loop;

DBMS_OUTPUT.PUT_LINE('------'|| '+---+');
End;
/
show errors;












create or replace procedure contenu(p_idEtudiant IN Etudiants.idEtudiant%TYPE,
p_idSemestre IN Semestres.idSemestre%TYPE)  is
v_moy number:=0;
v_nom varchar(30);
v_prenom varchar(30);
begin
select nometudiant into v_nom from etudiants where idetudiant=p_idetudiant;
select prenometudiant into v_prenom from etudiants where idetudiant=p_idetudiant;
DBMS_OUTPUT.PUT('  |');
DBMS_OUTPUT.PUT(RPAD(v_nom,9) || RPAD(v_prenom,9) || '     |');
For moyenne in
(Select nomModule, idModule
From Modules Mo
Where idSemestre =  p_idSemestre)
Loop
for note in (select note from notes join matieres on matieres.idmatiere=notes.idmatiere join
modules on matieres.idmodule=modules.idmodule
where matieres.idmodule=moyenne.idmodule and notes.idetudiant=p_idetudiant )loop
DBMS_OUTPUT.PUT(RPAD(note.note,6));
End Loop;
DBMS_OUTPUT.PUT('|');
DBMS_OUTPUT.PUT(RPAD(moyenneetudiantModule(p_idetudiant,moyenne.idmodule),6));
DBMS_OUTPUT.PUT('||');
end loop;
DBMS_OUTPUT.PUT_LINE(RPAD(moyenneEtudiantSemestre(p_idEtudiant,p_idSemestre),6) ||'|  '|| valideSemestre(p_idetudiant,p_idsemestre) || '|');
End;
/
show errors;


create or replace PROCEDURE affichagePV( p_idSemestre IN Semestres.idSemestre%TYPE) is
    begin
for v_ligne in (select idEtudiant from etudiants join groupes on etudiants.idgroupe=groupes.idgroupe join
        semestres on semestres.idpromotion=groupes.idpromotion where idsemestre=p_idsemestre) loop //prendre les etudiants du semestre
lignes(v_ligne.idetudiant,p_idsemestre);
contenu(v_ligne.idetudiant,p_idsemestre);
lignes(v_ligne.idetudiant,p_idsemestre);
end loop;
end;
/
show errors ;




