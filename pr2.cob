IDENTIFICATION DIVISION.
PROGRAM-ID. SpaceX2118.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

SELECT Fastronautes ASSIGN TO "astronautes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fa_stat
        RECORD KEY fa_idAstro
        ALTERNATE RECORD KEY fa_pays WITH DUPLICATES
        ALTERNATE RECORD KEY fa_role WITH DUPLICATES
        ALTERNATE RECORD KEY fa_idEquipe WITH DUPLICATES.


SELECT Fequipes ASSIGN TO "equipes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fe_stat
        RECORD KEY fe_idEquipe
        ALTERNATE RECORD KEY fe_idMission.

SELECT Fmissions ASSIGN TO "missions.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fm_stat
        RECORD KEY fm_idMission
        ALTERNATE RECORD KEY fm_nomLieu WITH DUPLICATES.


SELECT Flieux ASSIGN TO "lieux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fl_stat
        RECORD KEY fl_nomLieu
        ALTERNATE RECORD KEY fl_typeLieu WITH DUPLICATES.

SELECT Fvaisseaux ASSIGN TO "vaiseaux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fv_stat
        RECORD KEY fv_cleV
        ALTERNATE RECORD KEY fv_nomLieu WITH DUPLICATES
        ALTERNATE RECORD KEY fv_typeVaisseau WITH DUPLICATES.

DATA DIVISION.
FILE SECTION.

        FD Fastronautes.
        01 aTampon.
                02 fa_idAstronaute PIC 9(5).
                02 fa_nom PIC A(30).
                02 fa_prenom PIC A(30).
                02 fa_role PIC X(30).
                02 fa_pays PIC A(30).
                02 fa_idEquipe PIC 9(5).

        FD Fequipes.
        01 eTampon.
                02 fe_idEquipe PIC 9(5).
                02 fe_nbAstronautes PIC 9(5).
                02 fe_description PIC X(50).
                02 fe_idMission PIC 9(5).

        FD Fmissions.
        01 mTampon.
                02 fm_idMission PIC 9(5).
                02 fm_nomLieu PIC X(30).
                02 fm_description PIC X(30).

        FD Flieux.
        01 lTampon.
                02 fl_nomLieu PIC X(30).
                02 fl_typeLieu PIC X(30).
                02 fl_habitable PIC 9.

        FD Fvaisseaux.
        01 vTampon.
                02 fv_cleV.
                    03 fv_nomVaisseau PIC X(30).
                    03 fv_typeVaisseau PIC X(30).
                02 fv_capacite PIC 9(3).
                02 fv_nomLieu PIC X(30).

WORKING-STORAGE SECTION.

        77 choix PIC 9.
        77 fa_stat PIC 9(2).
        77 fe_stat PIC 9(2).
        77 fm_stat PIC 9(2).
        77 fv_stat PIC 9(2).
        77 fl_stat PIC 9(2).

PROCEDURE DIVISION.

        OPEN I-O Fastronautes
        IF fa_stat=35 THEN
                OPEN OUTPUT Fastronautes
        END-IF
        CLOSE Fastronautes

        OPEN I-O Fequipes
        IF fe_stat=35 THEN
                OPEN OUTPUT Fequipes
        END-IF
        CLOSE Fequipes
       
        OPEN I-O Fmissions
        IF fm_stat=35 THEN
                OPEN OUTPUT Fmissions
        END-IF
        CLOSE Fmissions

        OPEN I-O Fvaisseaux
        IF fv_stat=35 THEN
                OPEN OUTPUT Fvaisseaux
        END-IF
        CLOSE Fvaisseaux

        OPEN EXTEND Flieux
        IF fl_stat=35 THEN
                OPEN OUTPUT Flieux
        END-IF
        CLOSE Flieux

STOP RUN.

COPY astronautes.cob
