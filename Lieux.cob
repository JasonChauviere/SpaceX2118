*> FICHIER LIEU
AJOUTER_LIEU.

    OPEN I-O Flieux

    DISPLAY "donnez le nom du lieu"
    ACCEPT fl_nomLieu

    READ flieux  KEY IS fl_nomLieu
        INVALID KEY
            DISPLAY "donnez type lieu"
            ACCEPT fl_typeLieu

            DISPLAY "Habitable 1 "
            DISPLAY "Pas habitable 2 "
            PERFORM WITH TEST AFTER UNTIL fl_habitable = 1 OR fl_habitable = 0
                ACCEPT fl_habitable
            END-PERFORM

            WRITE lTampon
                INVALID KEY
                    DISPLAY "erreur"
                NOT INVALID KEY
                    DISPLAY "ajout effectuer"
            END-WRITE
        NOT INVALID KEY
            DISPLAY "lieu existe deja"
    END-READ

    CLOSE Flieux.

MODIFIER_LIEU.

    OPEN I-O Flieux

    DISPLAY "donnez le nom du lieu"
    ACCEPT fl_nomLieu

    READ flieux  KEY IS fl_nomLieu
        INVALID KEY
            DISPLAY "lieu existe pas"
        NOT INVALID KEY
            DISPLAY "donnez type lieu"
            ACCEPT fl_typeLieu

            DISPLAY "Habitable 1 "
            DISPLAY "Pas habitable 2 "
            PERFORM WITH TEST AFTER UNTIL fl_habitable = 1 OR fl_habitable = 0
                ACCEPT fl_habitable
            END-PERFORM

            REWRITE lTampon END-REWRITE
    END-READ

    CLOSE Flieux.

*> FICHIER STATS

ASTRO_CHOMEUR.

    MOVE 0 TO Wfin
    OPEN INPUT Fastronautes

    PERFORM WITH TEST AFTER UNTIL  Wfin = 1
        READ Fastronautes
            AT END
                MOVE 1 TO Wfin
            NOT AT END
                IF fa_idEquipe = 0 THEN
                    DISPLAY "astronaute " fa_idAstronaute
                    DISPLAY "nom " fa_nom
                    DISPLAY "prenom " fa_prenom
                    DISPLAY "role " fa_role
                    DISPLAY "pays " fa_pays
                END-IF
        END-READ
    END-PERFORM
    CLOSE Fastronautes.

ROLE_STATS.

    OPEN INPUT Fastronautes
    CLOSE Fastronautes.
STOP RUN.
