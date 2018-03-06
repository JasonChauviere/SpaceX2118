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
                02 fmis_description PIC X(30).

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
     77 Wcontinuer PIC 9.


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



        PERFORM INIT_FILE


        STOP RUN.


MAIN-PROCEDURE.
    DISPLAY "Hello world"
    STOP RUN.

INIT_FILE.

    PERFORM INIT_ASTRONAUTE
    PERFORM INIT_EQUIPE
    PERFORM INIT_COMPO_EQUIPE
    PERFORM INIT_MISSIONS
    PERFORM INIT_LIEU
    PERFORM INIT_VAISSEAU

 .

*>***************INIT_ASTRONAUTE************************************************
INIT_ASTRONAUTE.
    OPEN OUTPUT Fastronautes


    MOVE 1 TO fast_idAstronaute
    MOVE "yassine" TO fast_nom
    MOVE "karami" TO fast_prenom
    MOVE "ingenieur" TO fast_role
    MOVE "maroc" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE


    MOVE 2 TO fast_idAstronaute
    MOVE "jason" TO fast_nom
    MOVE "chauviere" TO fast_prenom
    MOVE "pilote" TO fast_role
    MOVE "france" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE


    MOVE 3 TO fast_idAstronaute
    MOVE "aldrin" TO fast_nom
    MOVE "buzz" TO fast_prenom
    MOVE "pilote" TO fast_role
    MOVE "etat unis" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE


    MOVE 4 TO fast_idAstronaute
    MOVE "jason" TO fast_nom
    MOVE "chauviere" TO fast_prenom
    MOVE "physicien" TO fast_role
    MOVE "suede" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE


    MOVE 5 TO fast_idAstronaute
    MOVE "neil" TO fast_nom
    MOVE "armstrong" TO fast_prenom
    MOVE "mecanicien" TO fast_role
    MOVE "etat unis" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE


    MOVE 6 TO fast_idAstronaute
    MOVE "afanassiev" TO fast_nom
    MOVE "viktor" TO fast_prenom
    MOVE "hydrogeologiste" TO fast_role
    MOVE "russie" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE
    CLOSE Fastronautes.

    MOVE 7 TO fast_idAstronaute
    MOVE "Bondar" TO fast_nom
    MOVE "Roberta" TO fast_prenom
    MOVE "pilote" TO fast_role
    MOVE "canada" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE

    MOVE 7 TO fast_idAstronaute
    MOVE "de winne" TO fast_nom
    MOVE "frank" TO fast_prenom
    MOVE "ingenieur" TO fast_role
    MOVE "belgique" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE

    MOVE 8 TO fast_idAstronaute
    MOVE "tognini" TO fast_nom
    MOVE "michel" TO fast_prenom
    MOVE "physicien" TO fast_role
    MOVE "france" TO fast_pays

    WRITE astroTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "astronaute "fast_idAstronaute " ajoutee"
    END-WRITE

    CLOSE Fastronautes.


*>***************INIT_EQUIPE*************************************************

 INIT_EQUIPE.

    OPEN OUTPUT Fequipes

    MOVE 1 TO feq_idEquipe
    MOVE 3 TO feq_nbAstronautes
    MOVE "la super equipe" TO feq_description
    MOVE 1 TO feq_idMission

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "equipe "feq_idEquipe " ajoutee"
    END-WRITE


    MOVE 2 TO feq_idEquipe
    MOVE 2 TO feq_nbAstronautes
    MOVE "equipe des nulles" TO feq_description
    MOVE 2 TO feq_idMission

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "equipe "feq_idEquipe " ajoutee"
    END-WRITE


    MOVE 3 TO feq_idEquipe
    MOVE 4 TO feq_nbAstronautes
    MOVE "on etait livreurs de pizza" TO feq_description
    MOVE 3 TO feq_idMission

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "equipe "feq_idEquipe " ajoutee"
    END-WRITE


    CLOSE Fequipes.

*>***************INIT_COMPO_EQUIPE************************************************

INIT_COMPO_EQUIPE.

    OPEN OUTPUT Fcompo_equipes

    MOVE 1 TO fce_idAstronaute
    MOVE 1 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE


    MOVE 2 TO fce_idAstronaute
    MOVE 1 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.


    MOVE 3 TO fce_idAstronaute
    MOVE 1 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.


    MOVE 3 TO fce_idAstronaute
    MOVE 2 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.

    MOVE 4 TO fce_idAstronaute
    MOVE 2 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.

    MOVE 5 TO fce_idAstronaute
    MOVE 3 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.

    MOVE 6 TO fce_idAstronaute
    MOVE 3 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.

    MOVE 7 TO fce_idAstronaute
    MOVE 3 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.

    MOVE 8 TO fce_idAstronaute
    MOVE 3 TO fce_idEquipe

    WRITE equipTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "ajout effectuer"
    END-WRITE
    CLOSE Fcompo_equipes.


*>***************INIT_MISSION************************************************
INIT_MISSIONS.

    OPEN OUTPUT Fmissions

    MOVE 1 TO fmis_idMission
    MOVE "Mars" TO fmis_nomLieu
    MOVE "extermination population" TO fmis_description
    WRITE missTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "mission "fmis_idMission " ajoute"
    END-WRITE


    MOVE 2 TO fmis_idMission
    MOVE "Jupiter" TO fmis_nomLieu
    MOVE "reconaissance" TO fmis_description
    WRITE missTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "mission "fmis_idMission " ajoute"
    END-WRITE


    MOVE 4 TO fmis_idMission
    MOVE "Pluton" TO fmis_nomLieu
    MOVE "exploration" TO fmis_description
    WRITE missTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "mission "fmis_idMission " ajoute"
    END-WRITE

    CLOSE Fmissions.


 *>***************INIT_LIEU************************************************

 INIT_LIEU.

     OPEN OUTPUT Flieux

     MOVE "Mars" TO fli_nomLieu
     MOVE "desert" TO fli_typeLieu
     MOVE 1 TO fli_habitable

     WRITE lieuTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "lieu "fli_nomLieu " ajoute"
     END-WRITE

     MOVE "Jupiter" TO fli_nomLieu
     MOVE "foret" TO fli_typeLieu
     MOVE 1 TO fli_habitable

     WRITE lieuTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "lieu "fli_nomLieu " ajoute"
     END-WRITE

     MOVE "Pluton" TO fli_nomLieu
     MOVE "desert de glace" TO fli_typeLieu
     MOVE 0 TO fli_habitable

     WRITE lieuTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "lieu "fli_nomLieu " ajoute"
     END-WRITE

     CLOSE Flieux.


*>***************INIT_VAISSEAU************************************************

INIT_VAISSEAU.

    OPEN OUTPUT Fvaisseaux

    MOVE "faucon milenium" TO fv_nomVaisseau
    MOVE 2 TO fv_typeVaisseau
    MOVE 10 TO fv_capacite
    MOVE "Mars" TO fv_nomLieu

    WRITE vaissTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "vaisseau " fv_nomVaisseau " ajoute"
    END-WRITE

    MOVE "etoile de la mort" TO fv_nomVaisseau
    MOVE 3 TO fv_typeVaisseau
    MOVE 8 TO fv_capacite
    MOVE "Jupiter" TO fv_nomLieu

    WRITE vaissTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "vaisseau " fv_nomVaisseau " ajoute"
    END-WRITE

    MOVE "fusee nule" TO fv_nomVaisseau
    MOVE 1 TO fv_typeVaisseau
    MOVE 7 TO fv_capacite
    MOVE "Pluton" TO fv_nomLieu

    WRITE vaissTampon
        INVALID KEY
            DISPLAY "erreur"
        NOT INVALID KEY
            DISPLAY "vaisseau " fv_nomVaisseau " ajoute"
    END-WRITE

    CLOSE Fvaisseaux.

END PROGRAM YOUR-PROGRAM-NAME.
