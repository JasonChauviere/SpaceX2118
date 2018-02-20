*> CHAUVIERE JASON, KARAMI YASSINE ET NYUNTING ELBERT || 689T
*> Projet SPACEX2118

IDENTIFICATION DIVISION.
PROGRAM-ID. SpaceX2118.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

SELECT Fastronautes ASSIGN TO "astronautes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fa_stat
        RECORD KEY a
        ALTERNATE RECORD KEY a WITH DUPLICATES.

DATA DIVISION.
FILE SECTION.
        FD Fastronautes.
        01 astroTampon.
                02 .

WORKING-STORAGE SECTION.
        77 choix PIC 9.
        77 fa_stat PIC 9(2).

PROCEDURE DIVISION.
        OPEN I-O Fastronautes
        IF fa_stat=35 THEN
                OPEN OUTPUT Fastronautes
        END-IF
        CLOSE Fastronautes

        PERFORM WITH TEST AFTER UNTIL choix = 0 
        PERFORM WITH TEST AFTER UNTIL choix <= 9
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '                SPACEX 2118                '
        DISPLAY '  ---------------------------------------  '
        ACCEPT choix
        EVALUATE choix
        WHEN 1 PERFORM 
        END-EVALUATE
        END-PERFORM
        END-PERFORM
        STOP RUN.

STOP RUN.

COPY astronautes.cob
COPY 
