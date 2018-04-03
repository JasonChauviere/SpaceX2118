        VERIF_LIEU2.
        OPEN INPUT Flieux        
        MOVE Wfl_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
              MOVE 0 TO Wverif_l
        NOT INVALID KEY
              MOVE 1 TO Wverif_l
              DISPLAY "ERREUR ! Identifiant déja attribué !"
        END-READ
        CLOSE Flieux.

        AJOUT_LIEU.
        PERFORM WITH TEST AFTER UNTIL Waj_l = 0
            DISPLAY ' '
            DISPLAY "Nom du lieu ?"
            ACCEPT Wfl_nomLieu2
            MOVE FUNCTION LOWER-CASE(Wfl_nomLieu2) TO Wfl_nomLieu
            PERFORM VERIF_LIEU2
            IF Wverif_l = 0 THEN
                DISPLAY "Type du lieu ?"
                DISPLAY "1 : Étoile"
                DISPLAY "2 : Planète"
                DISPLAY "3 : Astéroïde"
                DISPLAY "4 : Trou noir"
                DISPLAY "5 : Non identifié"                    
                PERFORM WITH TEST AFTER UNTIL
                                Wl_typeL < 6 AND Wl_typeL > 0
                    ACCEPT Wl_typeL
                END-PERFORM
                DISPLAY "Lieu habitable ? (0 : Non // 1 : Oui)"
                PERFORM WITH TEST AFTER UNTIL Wl_hab = 0 OR Wl_hab = 1
                    ACCEPT Wl_hab
                END-PERFORM
                MOVE Wl_typeL TO fl_typeLieu
                MOVE Wl_hab TO fl_habitable
                OPEN I-O Flieux
                WRITE lTampon END-WRITE
                CLOSE Flieux
                DISPLAY "Lieu ajouté avec succès."
            END-IF
            PERFORM WITH TEST AFTER UNTIL Waj_l = 0 OR Waj_l = 1
                DISPLAY ' '
                DISPLAY "Autres lieux à ajouter ? (0 : Non // 1 : Oui)"
                    ACCEPT Waj_l
            END-PERFORM
        END-PERFORM.

        SUPPRIMER_LIEU.
        MOVE 0 TO Wl_NOTALLOW
        OPEN I-O Flieux
        DISPLAY "Nom du lieu à détruire ?"
        ACCEPT Wfl_nomLieu2
        MOVE FUNCTION LOWER-CASE(Wfl_nomLieu2) TO Wfl_nomLieu
        MOVE Wfl_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
            DISPLAY "Ce lieu n'existe pas, impossible à détruire !"
        NOT INVALID KEY
            OPEN I-O Fmissions
            MOVE Wfl_nomLieu TO fm_nomLieu
            START Fmissions, KEY IS = fm_nomLieu
            INVALID KEY
                DISPLAY " "
            NOT INVALID KEY 
                MOVE 0 TO fm_fin
                PERFORM WITH TEST AFTER UNTIL fm_fin = 1
                    READ Fmissions NEXT
                    AT END MOVE 1 TO fm_fin
                    NOT AT END
                        IF Wfl_nomLieu = fm_nomLieu THEN
                            MOVE 1 TO Wl_NOTALLOW
                        END-IF
                    END-READ
                END-PERFORM
            END-START
            CLOSE Fmissions
        END-READ
        IF Wl_NOTALLOW = 0 THEN
            DELETE Flieux RECORD END-DELETE
            DISPLAY "Lieu du nom de ", Wfl_nomLieu, " détruit."
        END-IF
        IF Wl_NOTALLOW = 1 THEN
            DISPLAY "Destruction du lieu impossible."
            DISPLAY "Au moins une mission est connectée à ce lieu !"
        END-IF
        CLOSE Flieux. 

        MODIFIER_LIEU.
        DISPLAY "Nom du lieu à modifier ?"
        ACCEPT Wfl_nomLieu2
        MOVE FUNCTION LOWER-CASE(Wfl_nomLieu2) TO Wfl_nomLieu
        OPEN I-O Flieux        
        MOVE Wfl_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
            DISPLAY "ERREUR ! Identifiant inconnu !"
        NOT INVALID KEY    
            DISPLAY "Que souhaitez-vous modifier ?"
            DISPLAY "1 : Type // 2 : Habitable ?"
            MOVE 0 TO Wfmodif_l
            PERFORM WITH TEST AFTER UNTIL
                    Wfmodif_l = 1 OR
                    Wfmodif_l = 2           
              ACCEPT Wfmodif_l
            END-PERFORM
            IF Wfmodif_l = 1 THEN
                DISPLAY "Type du lieu ?"
                DISPLAY "1 : Étoile"
                DISPLAY "2 : Planète"
                DISPLAY "3 : Astéroïde"
                DISPLAY "4 : Trou noir"
                DISPLAY "5 : Non identifié"                    
                PERFORM WITH TEST AFTER UNTIL
                                Wl_typeL < 6 AND Wl_typeL > 0
                    ACCEPT Wl_typeL
                END-PERFORM
                MOVE Wl_typeL TO fl_typeLieu
                REWRITE lTampon END-REWRITE
                DISPLAY "Lieu modifié."
            END-IF
            IF Wfmodif_l = 2 THEN    
                DISPLAY "Lieu habitable ? (0 : Non // 1 : Oui)"
                PERFORM WITH TEST AFTER UNTIL Wl_hab = 0 OR Wl_hab = 1
                    ACCEPT Wl_hab
                END-PERFORM
                MOVE Wl_hab TO fl_habitable
                REWRITE lTampon END-REWRITE
                DISPLAY "Lieu modifié."
            END-IF
        END-READ
        CLOSE Flieux.

        AFFICHER_LIEU.
        OPEN INPUT Flieux
        DISPLAY "Nom du lieu ?"
        ACCEPT Wfl_nomLieu2
        MOVE FUNCTION LOWER-CASE(Wfl_nomLieu2) TO Wfl_nomLieu
        MOVE Wfl_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
            DISPLAY "Ce nom de lieu est inexistant."
        NOT INVALID KEY
            DISPLAY "#############"
            DISPLAY "<-- Nom du lieu : ", fl_nomLieu, " -->"
            IF fl_typeLieu = 1 THEN
                MOVE "Étoile" TO Wfl_typeLieuECR
            END-IF
            IF fl_typeLieu = 2 THEN
                MOVE "Planète" TO Wfl_typeLieuECR
            END-IF
            IF fl_typeLieu = 3 THEN
                MOVE "Astéroïde" TO Wfl_typeLieuECR
            END-IF
            IF fl_typeLieu = 4 THEN
                MOVE "Trou noir" TO Wfl_typeLieuECR
            END-IF
            IF fl_typeLieu = 5 THEN
                MOVE "Non identifié" TO Wfl_typeLieuECR
            END-IF
            DISPLAY "Type du lieu : ", Wfl_typeLieuECR
            IF fl_habitable = 0 THEN
                MOVE "Non" TO Wfl_habitableECR
            END-IF
            IF fl_habitable = 1 THEN
                MOVE "Oui" TO Wfl_habitableECR
            END-IF
            DISPLAY "Lieu habitable ? ", Wfl_habitableECR
        END-READ
        CLOSE Flieux.

        STAT_NB_LIEUX.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieux
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                ADD 1 TO WS_nbLieux
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieux, " lieu(x) dans les données."
        CLOSE Flieux.

        STAT_NB_LIEUX_HAB.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieuxHab
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                IF fl_habitable = 1 THEN
                    ADD 1 TO WS_nbLieuxHab
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieuxHab, " lieu(x) habitable(s) ",
"dans les données."
        CLOSE Flieux.

        STAT_NB_ETOILES.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieuxEto
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                IF fl_typeLieu = 1 THEN
                    ADD 1 TO WS_nbLieuxEto
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieuxEto, " étoile(s) ",
"dans les données."
        CLOSE Flieux.

        STAT_NB_PLANETES.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieuxPla
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                IF fl_typeLieu = 2 THEN
                    ADD 1 TO WS_nbLieuxPla
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieuxPla, " planète(s) ",
"dans les données."
        CLOSE Flieux.

        STAT_NB_ASTEROIDES.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieuxAst
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                IF fl_typeLieu = 3 THEN
                    ADD 1 TO WS_nbLieuxAst
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieuxAst, " astéroïde(s) ",
"dans les données."
        CLOSE Flieux.

        STAT_NB_TROUS_NOIRS.
        OPEN INPUT Flieux
        MOVE 0 TO Wlieu_fin
        MOVE 0 TO WS_nbLieuxTN
        PERFORM WITH TEST AFTER UNTIL Wlieu_fin = 1
            READ Flieux NEXT
            AT END
                MOVE 1 TO Wlieu_fin
            NOT AT END
                IF fl_typeLieu = 4 THEN
                    ADD 1 TO WS_nbLieuxTN
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbLieuxTN, " trou(s) noir(s) ",
"dans les données."
        CLOSE Flieux.

        COLLECTION_DONNEES_LIEU.
        MOVE "soleil" TO fl_nomLieu
        MOVE 1 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "étoile noire" TO fl_nomLieu
        MOVE 1 TO fl_typeLieu
        MOVE 1 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "étoile de la mort" TO fl_nomLieu
        MOVE 1 TO fl_typeLieu
        MOVE 1 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "mercure" TO fl_nomLieu
        MOVE 2 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "vénus" TO fl_nomLieu
        MOVE 2 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "mars" TO fl_nomLieu
        MOVE 2 TO fl_typeLieu
        MOVE 1 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "jupiter" TO fl_nomLieu
        MOVE 2 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "ceres" TO fl_nomLieu
        MOVE 3 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "pallas" TO fl_nomLieu
        MOVE 3 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "juno" TO fl_nomLieu
        MOVE 3 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "vesta" TO fl_nomLieu
        MOVE 3 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "cygnus a" TO fl_nomLieu
        MOVE 4 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        MOVE "markarian" TO fl_nomLieu
        MOVE 4 TO fl_typeLieu
        MOVE 0 TO fl_habitable
        OPEN I-O Flieux
            WRITE lTampon END-WRITE
        CLOSE Flieux

        DISPLAY "SPACEX 2118 -- Génération de 13 lieux effectués !".
