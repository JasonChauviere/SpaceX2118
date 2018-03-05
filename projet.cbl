*>****************************************************************
*> Author:
*> Date:
*> Purpose:
*> Tectonics: cobc
*>****************************************************************
IDENTIFICATION DIVISION.
PROGRAM-ID. YOUR-PROGRAM-NAME.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

SELECT Fastronautes ASSIGN TO "astronautes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fast_stat
        RECORD KEY fast_idAstronaute
        ALTERNATE RECORD KEY fast_pays WITH DUPLICATES
        ALTERNATE RECORD KEY fast_role WITH DUPLICATES.


SELECT Fequipes ASSIGN TO "equipes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS feq_stat
        RECORD KEY feq_idEquipe
        ALTERNATE RECORD KEY feq_idMission.


SELECT Fcompo_equipes ASSIGN TO "compo_equipes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fce_stat
        RECORD KEY fce_cle
        ALTERNATE RECORD KEY fce_idEquipe WITH DUPLICATES.



SELECT Fmissions ASSIGN TO "missions.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fmis_stat
        RECORD KEY fmis_idMission
        ALTERNATE RECORD KEY fmis_nomLieu WITH DUPLICATES.



SELECT Flieux ASSIGN TO "lieux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fli_stat
        RECORD KEY fli_nomLieu
        ALTERNATE RECORD KEY fli_typeLieu WITH DUPLICATES.

SELECT Fvaisseaux ASSIGN TO "vaiseaux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fv_stat
        RECORD KEY fv_cleVaisseau
        ALTERNATE RECORD KEY fv_nomLieu WITH DUPLICATES
        ALTERNATE RECORD KEY fv_typeVaisseau WITH DUPLICATES.




DATA DIVISION.
FILE SECTION.

    FD Fastronautes.
        01 astroTampon.
                02 fast_idAstronaute PIC 9(5).
                02 fast_nom PIC A(30).
                02 fast_prenom PIC A(30).
                02 fast_role PIC X(30).
                02 fast_pays PIC A(30).


        FD Fequipes.
        01 equipTampon.
                02 feq_idEquipe PIC 9(5).
                02 feq_nbAstronautes PIC 9(5).
                02 feq_description PIC X(50).
                02 feq_idMission PIC 9(5).



        FD Fcompo_equipes.
        01 compoTamp.
            02 fce_cle.
                03 fce_idAstronaute PIC 9(5).
                03 fce_idEquipe PIC 9(5).


        FD Fmissions.
        01 missTampon.
                02 fmis_idMission PIC 9(5).
                02 fmis_nomLieu PIC X(30).
                02 fm_description PIC X(30).

        FD Flieux.
        01 lieuTampon.
                02 fli_nomLieu PIC X(30).
                02 fli_typeLieu PIC X(30).
                02 fli_habitable PIC 9.



        FD Fvaisseaux.
        01 vaissTampon.
                02 fv_cleVaisseau.
                    03 fv_nomVaisseau PIC X(30).
                    03 fv_typeVaisseau PIC X(30).
                02 fv_capacite PIC 9(3).
                02 fv_nomLieu PIC X(30).




WORKING-STORAGE SECTION.

     77 choix PIC 9.
     77 fast_stat PIC 9(2).
     77 feq_stat PIC 9(2).
     77 fce_stat PIC 9(2).
     77 fmis_stat PIC 9(2).
     77 fli_stat PIC 9(2).
     77 fv_stat PIC 9(2).



     77 Wok PIC 9.
     77 Wfin PIC 9.
     77 Wtrouve PIC 9.


     77 Wpays  PIC A(30).
     77 Wnom PIC A(30).
     77 Wprenom PIC A(30).
     77 Wrole PIC X(30).
     77 Wequipe PIC 9(5).

PROCEDURE DIVISION.

        OPEN I-O Fastronautes
        IF fast_stat=35 THEN
                OPEN OUTPUT Fastronautes
        END-IF
        CLOSE Fastronautes

        OPEN I-O Fequipes
        IF feq_stat=35 THEN
                OPEN OUTPUT Fequipes
        END-IF
        CLOSE Fequipes

        OPEN I-O Fcompo_equipes
        IF fce_stat=35 THEN
                OPEN OUTPUT Fcompo_equipes
        END-IF
        CLOSE Fcompo_equipes

        OPEN I-O Fmissions
        IF fmis_stat=35 THEN
                OPEN OUTPUT Fmissions
        END-IF
        CLOSE Fmissions

        OPEN I-O Fvaisseaux
        IF fv_stat=35 THEN
                OPEN OUTPUT Fvaisseaux
        END-IF
        CLOSE Fvaisseaux

        OPEN EXTEND Flieux
        IF fli_stat=35 THEN
                OPEN OUTPUT Flieux
        END-IF
        CLOSE Flieux



        PERFORM WITH TEST AFTER UNTIL choix = 0
        PERFORM WITH TEST AFTER UNTIL choix < 8
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '        MENU VISITEUR         '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Indiquer le chiffre correspondant a votre souhait ! '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le programme : 0                  '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter un astronaute : 1                '
        DISPLAY ' recherche astronaute  :  2  '
        DISPLAY ' modifier astronaute   :   3  '
        DISPLAY ' supprimer astronaute   :   4  '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter un athl??te : 3                    '
        DISPLAY ' Rechercher un athl??te (nom) : 4           '
        DISPLAY ' Rechercher des athl??tes (pays) : 5        '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter une course : 6                    '
        DISPLAY ' Rechercher une course (ville + type) : 7  '
        DISPLAY ' '
        ACCEPT choix
        EVALUATE choix
        WHEN 1 PERFORM AJOUTER_ASTRONAUTE
        WHEN 2 PERFORM RECHERCHE_ASTRONAUTE
        WHEN 3 PERFORM MODIFIER_ASTRONAUTE
        WHEN 4 PERFORM SUPPRIMER_ASTRONAUTE


        END-EVALUATE
        END-PERFORM
        END-PERFORM
        STOP RUN.


MAIN-PROCEDURE.
    DISPLAY "Hello world"
    STOP RUN.




AJOUTER_ASTRONAUTE.

    MOVE 0 TO Wok
    OPEN I-O Fastronautes

    DISPLAY "donnez l'identitiant de l'astronaute"
    ACCEPT fast_idAstronaute
    READ Fastronautes, KEY IS fast_idAstronaute
        INVALID KEY
            MOVE 1 TO Wok
        NOT INVALID KEY
            DISPLAY "l'identifiant existe deja "
    END-READ


    IF Wok = 1
        DISPLAY "donnez le nom de l'astronaute"
        ACCEPT fast_nom
        DISPLAY "donnez le prenom de l'astronaute"
        ACCEPT fast_prenom
        DISPLAY "donnez le pays de l'astronaute"
        ACCEPT Wpays

        PERFORM VERIF_HOMONYME

        IF Wtrouve = 0 THEN
            MOVE wPAYS TO fast_pays
            DISPLAY "donnez le role"
            ACCEPT fast_role

            WRITE astroTampon
                INVALID KEY DISPLAY "erreur"
                NOT INVALID KEY DISPLAY "ajout effectuer"
            END-WRITE

        ELSE IF Wtrouve = 1 THEN
            DISPLAY "pas d'homonyme de meme nationalite"
        END-IF
    CLOSE Fastronautes.


RECHERCHE_ASTRONAUTE.

        PERFORM WITH TEST AFTER UNTIL choix < 4
            DISPLAY '  ---------------------------------------  '
            DISPLAY ' recherche par role : 1          '
            DISPLAY ' recherche par pays : 2 '
            DISPLAY ' recherche par lieu : 3'
            DISPLAY ' recherche par equipe : 4'
            DISPLAY '  ---------------------------------------  '
            DISPLAY ' '
            ACCEPT choix
        END-PERFORM
        EVALUATE choix

            WHEN 1 PERFORM RECHERCHE_ASTRONAUTE_ROLE
            WHEN 2 PERFORM RECHERCHE_ASTRONAUTE_PAYS
            WHEN 2 PERFORM RECHERCHE_ASTRONAUTE_LIEU
            WHEN 2 PERFORM RECHERCHE_ASTRONAUTE_EQUIPE
 .


RECHERCHE_ASTRONAUTE_ROLE.

    MOVE 0 TO Wfin
    MOVE 0 TO Wtrouve
    OPEN INPUT Fastronautes

    DISPLAY "le role "
    ACCEPT Wrole

    MOVE Wrole TO fast_role
    START Fastronautes ,KEY IS = fast_role
         INVALID KEY
            DISPLAY "role inexistant"
        NOT INVALID KEY
            PERFORM WITH TEST AFTER UNTIL  Wfin = 1
                 IF fast_role= Wrole THEN
                     READ Fastronautes NEXT
                        AT END
                            MOVE 1 TO Wfin
                        NOT AT END
                            DISPLAY 'identifiant ' fast_idAstronaute
                            DISPLAY 'le nom ' fast_nom
                            DISPLAY 'le prenom ' fast_prenom
                            DISPLAY 'le pays ' fast_pays
                     END-READ
                 END-IF
            END-PERFORM

    END-START

    CLOSE Fastronautes.


RECHERCHE_ASTRONAUTE_PAYS.

    MOVE 0 TO Wfin
    MOVE 0 TO Wtrouve

    OPEN INPUT Fastronautes

    DISPLAY "le pays "
    ACCEPT Wpays

    MOVE Wpays TO fast_pays
    START Fastronautes ,KEY IS = fast_pays
         INVALID KEY
            DISPLAY "role inexistant"
        NOT INVALID KEY
            PERFORM WITH TEST AFTER UNTIL  Wfin = 1
                 IF fast_pays = Wpays THEN
                     READ Fastronautes NEXT
                        AT END
                            MOVE 1 TO Wfin
                        NOT AT END
                            DISPLAY 'identifiant ' fast_idAstronaute
                            DISPLAY 'le nom ' fast_nom
                            DISPLAY 'le prenom ' fast_prenom
                            DISPLAY 'le role  ' fast_role
                     END-READ
                 END-IF
            END-PERFORM

    END-START

    CLOSE Fastronautes.


RECHERCHE_ASTRONAUTE_LIEU.
    OPEN INPUT Fastronautes



    CLOSE Fastronautes.

RECHERCHE_ASTRONAUTE_EQUIPE.
    OPEN INPUT Fastronautes
    OPEN INPUT Fcompo_equipes

    DISPLAY "donnez l'equipe"
    ACCEPT Wequipe
    MOVE Wequipe TO fce_idEquipe
    START Fcompo_equipes , KEY IS  = fce_idEquipe
        INVALID KEY
            DISPLAY "equipe existe pas"
        NOT INVALID KEY
            PERFORM WITH TEST AFTER UNTIL Wfin = 1
              IF fce_idEquipe = Wequipe THEN
                    READ Fcompo_equipes NEXT
                        AT END
                            MOVE 1 to Wfin
                        NOT AT END
                            MOVE fce_idAstronaute TO fast_idAstronaute
                            READ Fastronautes KEY IS fast_idAstronaute
                                INVALID KEY
                                    DISPLAY "erreur"
                                NOT INVALID KEY
                                    DISPLAY "id astronaute " fast_idAstronaute
                                    DISPLAY "nom de l'astronaute " fast_nom
                                    DISPLAY "prenom de l'astronaute "fast_prenom
                                    DISPLAY "role de l'astronaute "fast_role
                                    DISPLAY "pays de l'astronaute "fast_pays
                                    DISPLAY ' '
                            END-READ
                    END-READ
                END-IF
            END-PERFORM
    END-START

    CLOSE Fcompo_equipes
    CLOSE Fastronautes.


MODIFIER_ASTRONAUTE.

    MOVE 0 TO Wfin
    MOVE 0 TO Wtrouve

    OPEN I-O Fastronautes
    DISPLAY "donnez l'identifiant de l'astronaute"
    ACCEPT fast_idAstronaute

    READ Fastronautes , KEY IS fast_idAstronaute
        INVALID KEY
            DISPLAY "identifiant n'existe pas"
        NOT INVALID KEY
            DISPLAY "nom de l'astronaute"
            ACCEPT fast_nom
            DISPLAY "prenom de l'astronaute"
            ACCEPT fast_prenom
            DISPLAY "le role de l'astronaute"
            ACCEPT fast_role
            DISPLAY "le pays de l'astronaute"
            ACCEPT Wpays

            PERFORM VERIF_HOMONYME
            IF Wtrouve = 0 THEN
                MOVE Wpays TO fast_pays
                REWRITE astroTampon
                    INVALID KEY
                        DISPLAY "erreur"
                    NOT INVALID KEY
                        DISPLAY "modification reussi"
                END-REWRITE

            ELSE IF  Wtrouve = 1
               DISPLAY "pas d'homonyme de meme nationalite"
            END-IF
    END-READ

    CLOSE Fastronautes.


SUPPRIMER_ASTRONAUTE.

    OPEN I-O Fastronautes

    DISPLAY "donnez l'identifiant de l'astronaute"
    ACCEPT fast_idAstronaute

    READ Fastronautes  KEY IS  fast_idAstronaute
        INVALID KEY
            DISPLAY "astronaute existe pas"
        NOT INVALID KEY
            DISPLAY "suppression de l'astronaute"
            DELETE Fastronautes RECORD

    END-READ


    CLOSE Fastronautes.

*>*******************FONCTION ANNEXE*********************************************

VERIF_HOMONYME.

    MOVE 0 TO Wfin
    MOVE 0 TO Wtrouve
    MOVE fast_nom TO Wnom
    MOVE Wpays TO fast_pays
    START Fastronautes ,KEY IS = fast_pays
        INVALID KEY
            DISPLAY "nationalite existe pas"
        NOT INVALID KEY
            PERFORM WITH TEST AFTER UNTIL Wfin = 1 OR Wtrouve = 1
                IF fast_pays = Wpays THEN
                    READ Fastronautes NEXT
                        AT END
                            MOVE 1 to Wfin
                        NOT AT END
                            IF Wnom = fast_nom THEN
                                MOVE 1 TO Wtrouve
                             END-IF
                    END-READ
                END-IF

            END-PERFORM
    END-START.



END PROGRAM YOUR-PROGRAM-NAME.
