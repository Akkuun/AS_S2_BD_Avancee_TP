/*1)*/

SET SERVEROUTPUT ON;


DECLARE
    v_ID_Groupe VARCHAR2(30);
    v_nb_Eleves number;
BEGIN

    SELECT COUNT(*)
    into v_nb_Eleves
    from etudiants
    where idgroupe = 'T1';
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_nb_Eleves || 'eleves dans le groupe T1');

end ;

/*2)*/

SET SERVEROUTPUT ON;
ACCEPT ID_Groupe PROMPT 'Saisir le ID du groupe'

DECLARE
    v_ID_Groupe VARCHAR2(30);
    v_nb_Eleves number;
BEGIN
    v_ID_Groupe := '&ID_Groupe';
    SELECT COUNT(*)
    into v_nb_Eleves
    from etudiants
    where idgroupe = v_ID_Groupe;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_nb_Eleves || 'eleves dans le groupe' || v_ID_Groupe);

end ;

/*3)*/
SET SERVEROUTPUT ON;
ACCEPT ID_Groupe PROMPT 'Saisir le ID du groupe';

DECLARE
    v_ID_Groupe VARCHAR2(30);
    v_id        varchar2(30);
    v_nb_Eleves number;
BEGIN
    v_ID_Groupe := '&ID_Groupe';

    select idgroupe into v_id from etudiants where idgroupe = '&ID_Groupe';
    SELECT COUNT(*)/* le count renvoie ici 0 ou 1 l'exepction ne marchera pas, on doit checj avant par une sous-requete que l'id existes */
    into v_nb_Eleves
    from etudiants
    where idgroupe = v_ID_Groupe;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_nb_Eleves || 'eleves dans le groupe' || v_ID_Groupe);

EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('le groupe n existe pas');
end ;

/*4)   ici notre condition "boolean" nous permet d'enlever les exceptions*/

SET SERVEROUTPUT ON;
ACCEPT ID_Groupe PROMPT 'Saisir le ID du groupe';

DECLARE
    v_ID_Groupe VARCHAR2(30);
    v_id        varchar2(30);
    v_nb_Eleves number;
BEGIN
    v_ID_Groupe := '&ID_Groupe';

    select count(*) into v_id from groupes where idgroupe = '&ID_Groupe'; /*c'est comme un if idgroupe existe in groupe res=true else res=false'*/

    if v_id > 0
    then
        SELECT COUNT(*)
        into v_nb_Eleves
        from etudiants
        where idgroupe = v_ID_Groupe;
        DBMS_OUTPUT.PUT_LINE('Il y a ' || v_nb_Eleves || 'eleves dans le groupe' || v_ID_Groupe);
    else
        DBMS_OUTPUT.PUT_LINE('Le groupe n existe pas ');
    end if;
end ;

/*5)*/
ACCEPT num_etudiant PROMPT 'Saisir un etudiant';

DECLARE
    var_etudiant Etudiants%ROWTYPE;

BEGIN
    SELECT * INTO var_etudiant
    FROM etudiants
    WHERE idEtudiant = '&num_etudiant';

    DBMS_OUTPUT.PUT_LINE('Nom etudiant : ' || var_etudiant.nomEtudiant);
    DBMS_OUTPUT.PUT_LINE('Prenom etudiant : ' || var_etudiant.prenomEtudiant);
    DBMS_OUTPUT.PUT_LINE('Sex étudiants : ' || var_etudiant.sexeEtudiant);
    DBMS_OUTPUT.PUT_LINE('Date naissance étudiant  : ' || var_etudiant.dateNaissanceEtudiant);
    DBMS_OUTPUT.PUT_LINE('Groupe étudiant : ' || var_etudiant.idGroupe);
END;
