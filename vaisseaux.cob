        VERIF_VAISSEAU.
        OPEN INPUT Fvaisseaux        
        MOVE Wfv_nomVaisseau TO fv_nomVaisseau
        READ Fvaisseaux
        INVALID KEY
              MOVE 0 TO Wverif_v
        NOT INVALID KEY
              MOVE 1 TO Wverif_v
              DISPLAY "ERREUR ! Identifiant déja attribué !"
        END-READ
        CLOSE Fvaisseaux.

        VERIF_LIEU3.
        OPEN INPUT Flieux        
        MOVE Wfv_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
              MOVE 0 TO Wverif_l
              DISPLAY "Lieu inexistant !"
        NOT INVALID KEY
              MOVE 1 TO Wverif_l
        END-READ
        CLOSE Flieux.

        AJOUT_VAISSEAU.
        PERFORM WITH TEST AFTER UNTIL Waj_v = 0
            DISPLAY ' '
            DISPLAY "Nom du vaisseau ?"
            ACCEPT Wfv_nomVaisseau2
            MOVE FUNCTION LOWER-CASE(Wfv_nomVaisseau2) TO Wfv_nomVaisseau
            DISPLAY "Type du vaisseau ?"
            DISPLAY "1 : Galère"
            DISPLAY "2 : Frégate"
            DISPLAY "3 : Dreadnought"
            PERFORM WITH TEST AFTER UNTIL Wfv_typeV < 4 AND Wfv_typeV > 0
                ACCEPT Wfv_typeV
            END-PERFORM
            PERFORM VERIF_VAISSEAU
            IF Wverif_v = 0 THEN
                IF Wfv_typeV = 1 THEN
                    MOVE 5 TO fv_capacite2
                END-IF
                IF Wfv_typeV = 2 THEN
                    MOVE 15 TO fv_capacite2
                END-IF
                IF Wfv_typeV = 3 THEN
                    MOVE 30 TO fv_capacite2
                END-IF
                DISPLAY "Lieu attribué au vaisseau ?"
                ACCEPT Wfv_nomLieu2
                MOVE FUNCTION LOWER-CASE(Wfv_nomLieu2) TO Wfv_nomLieu
                PERFORM VERIF_LIEU3
                IF Wverif_l = 1 THEN
                    MOVE Wfv_nomVaisseau TO fv_nomVaisseau
                    MOVE Wfv_nomLieu TO fv_nomLieu
                    MOVE Wfv_typeV TO fv_typeVaisseau
                    MOVE fv_capacite2 TO fv_capacite
                    OPEN I-O Fvaisseaux
                    WRITE vTampon END-WRITE
                    CLOSE Fvaisseaux
                    DISPLAY "Vaisseau ajouté avec succès."
                END-IF
            END-IF
            PERFORM WITH TEST AFTER UNTIL Waj_v = 0 OR Waj_v = 1
                DISPLAY ' '
                DISPLAY 'Autres vaisseaux à ajouter ? ',
'(0 : Non // 1 : Oui)'
                    ACCEPT Waj_v
            END-PERFORM
        END-PERFORM.
   
        SUPPRIMER_VAISSEAU.
        OPEN I-O Fvaisseaux
        DISPLAY "Nom du vaisseau à détruire ?"
        ACCEPT Wfv_nomVaisseau2        
        MOVE FUNCTION LOWER-CASE(Wfv_nomVaisseau2) TO Wfv_nomVaisseau
        MOVE Wfv_nomVaisseau TO fv_nomVaisseau
        READ Fvaisseaux
        INVALID KEY
            DISPLAY "Ce vaisseau n'existe pas, impossible à détruire !"
        NOT INVALID KEY
            DELETE Fvaisseaux RECORD END-DELETE
            DISPLAY "Vaisseau détruit." 
        END-READ
        CLOSE Fvaisseaux.

        MODIFIER_VAISSEAU.
        DISPLAY "Nom du vaisseau à modifier ?"
        ACCEPT Wfv_nomVaisseau2
        MOVE FUNCTION LOWER-CASE(Wfv_nomVaisseau2) TO Wfv_nomVaisseau 
        OPEN I-O Fvaisseaux
        MOVE Wfv_nomVaisseau TO fv_nomVaisseau
        READ Fvaisseaux
        INVALID KEY
            DISPLAY "ERREUR ! Identifiant inconnu !"
        NOT INVALID KEY   
            DISPLAY "Que souhaitez-vous modifier ?"
            DISPLAY "1 : Lieu // 2 : Capacité"
            MOVE 0 TO Wfmodif_v
            PERFORM WITH TEST AFTER UNTIL
                    Wfmodif_v = 1 OR
                    Wfmodif_v = 2           
              ACCEPT Wfmodif_v
            END-PERFORM
            IF Wfmodif_v = 1 THEN
                DISPLAY "Nouveau lieu ?"
                ACCEPT Wfm_lieu2
                MOVE FUNCTION LOWER-CASE(Wfm_lieu2) TO Wfm_lieu
                OPEN INPUT Flieux        
                MOVE Wfm_lieu TO fl_nomLieu
                READ Flieux
                INVALID KEY
                      DISPLAY "ERREUR ! Lieu inexistant !"
                NOT INVALID KEY
                      REWRITE vTampon END-REWRITE
                      DISPLAY "Vaisseau modifié."
                END-READ
                CLOSE Flieux
            END-IF
            IF Wfmodif_v = 2 THEN
                DISPLAY "Nouvelle capacité ?"
                IF Wfv_typeV = 1 THEN
                    DISPLAY "Entre 5 et 14"
                    PERFORM WITH TEST AFTER UNTIL
                                    Wfv_typeVM < 15 AND Wfv_typeVM > 4
                        ACCEPT Wfv_typeVM
                    END-PERFORM
                    MOVE Wfv_typeVM TO fv_capacite
                    REWRITE vTampon END-REWRITE
                    DISPLAY "Vaisseau modifié."
                END-IF
                IF Wfv_typeV = 2 THEN
                    DISPLAY "Entre 15 et 29"
                    PERFORM WITH TEST AFTER UNTIL
                                    Wfv_typeVM < 30 AND Wfv_typeVM > 14
                        ACCEPT Wfv_typeVM
                    END-PERFORM
                    MOVE Wfv_typeVM TO fv_capacite
                    REWRITE vTampon END-REWRITE
                    DISPLAY "Vaisseau modifié."
                END-IF  
                IF Wfv_typeV = 3 THEN
                    DISPLAY "Entre 30 et 59"
                    PERFORM WITH TEST AFTER UNTIL
                                    Wfv_typeVM < 60 AND Wfv_typeVM > 29
                        ACCEPT Wfv_typeVM
                    END-PERFORM
                    MOVE Wfv_typeVM TO fv_capacite
                    REWRITE vTampon END-REWRITE
                    DISPLAY "Vaisseau modifié."
                END-IF
            END-IF
        END-READ 
        CLOSE Fvaisseaux.

        AFFICHER_VAISSEAU.
        DISPLAY "Nom du vaisseau ?"
        ACCEPT Wfv_nomVaisseau2
        MOVE FUNCTION LOWER-CASE(Wfv_nomVaisseau2) TO Wfv_nomVaisseau
        OPEN INPUT Fvaisseaux
        MOVE Wfv_nomVaisseau TO fv_nomVaisseau
        READ Fvaisseaux
        INVALID KEY
            DISPLAY "Ce nom de vaisseau est inexistant."
        NOT INVALID KEY
            DISPLAY "#############"
            DISPLAY "<-- Nom du vaisseau : ", fv_nomVaisseau, " -->"
            DISPLAY "Type de vaisseau : ", fv_typeVaisseau
            DISPLAY "Lieu du vaisseau : ", fv_nomLieu
        END-READ
        CLOSE Fvaisseaux.

        STAT_NB_VAISSEAUX.
        OPEN INPUT Fvaisseaux
        MOVE 0 TO Wvaiss_fin
        MOVE 0 TO WS_nbVaisseaux
        PERFORM WITH TEST AFTER UNTIL Wvaiss_fin = 1
            READ Fvaisseaux NEXT
            AT END
                MOVE 1 TO Wvaiss_fin
            NOT AT END
                ADD 1 TO WS_nbVaisseaux
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbVaisseaux, " vaisseau(x) dans ",
"les données."
        CLOSE Fvaisseaux.

        STAT_NB_VAISSEAUX_1.
        OPEN INPUT Fvaisseaux
        MOVE 0 TO Wvaiss_fin
        MOVE 0 TO WS_nbVaisseaux1
        PERFORM WITH TEST AFTER UNTIL Wvaiss_fin = 1
            READ Fvaisseaux NEXT
            AT END
                MOVE 1 TO Wvaiss_fin
            NOT AT END
                IF fv_typeVaisseau = 1 THEN
                    ADD 1 TO WS_nbVaisseaux1
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbVaisseaux1, " vaisseau(x) de taille 1 ",
"[galère(s)] dans les données."
        CLOSE Fvaisseaux.

        STAT_NB_VAISSEAUX_2.
        OPEN INPUT Fvaisseaux
        MOVE 0 TO Wvaiss_fin
        MOVE 0 TO WS_nbVaisseaux2
        PERFORM WITH TEST AFTER UNTIL Wvaiss_fin = 1
            READ Fvaisseaux NEXT
            AT END
                MOVE 1 TO Wvaiss_fin
            NOT AT END
                IF fv_typeVaisseau = 2 THEN
                    ADD 1 TO WS_nbVaisseaux2
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbVaisseaux2, " vaisseau(x) de taille 2 ",
"[frégate(s)] dans les données."
        CLOSE Fvaisseaux.

        STAT_NB_VAISSEAUX_3.
        OPEN INPUT Fvaisseaux
        MOVE 0 TO Wvaiss_fin
        MOVE 0 TO WS_nbVaisseaux3
        PERFORM WITH TEST AFTER UNTIL Wvaiss_fin = 1
            READ Fvaisseaux NEXT
            AT END
                MOVE 1 TO Wvaiss_fin
            NOT AT END
                IF fv_typeVaisseau = 3 THEN
                    ADD 1 TO WS_nbVaisseaux3
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbVaisseaux3, " vaisseau(x) de taille 3 ",
"[dreadnought(s)] dans les données."
        CLOSE Fvaisseaux.

        COLLECTION_DONNEES_VAISSEAU.
        MOVE "titanic" TO fv_nomVaisseau
        MOVE 3 TO fv_typeVaisseau
        MOVE 30 TO fv_capacite
        MOVE "mars" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "airfrance" TO fv_nomVaisseau
        MOVE 3 TO fv_typeVaisseau
        MOVE 30 TO fv_capacite
        MOVE "mercure" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "pédalo du soleil" TO fv_nomVaisseau
        MOVE 1 TO fv_typeVaisseau
        MOVE 5 TO fv_capacite
        MOVE "soleil" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "twingo spatiale" TO fv_nomVaisseau
        MOVE 2 TO fv_typeVaisseau
        MOVE 15 TO fv_capacite
        MOVE "pallas" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "corbeau cosmos" TO fv_nomVaisseau
        MOVE 1 TO fv_typeVaisseau
        MOVE 5 TO fv_capacite
        MOVE "markarian" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "bicloown" TO fv_nomVaisseau
        MOVE 1 TO fv_typeVaisseau
        MOVE 5 TO fv_capacite
        MOVE "vénus" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "superbus" TO fv_nomVaisseau
        MOVE 2 TO fv_typeVaisseau
        MOVE 15 TO fv_capacite
        MOVE "jupiter" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "galactikpoutine" TO fv_nomVaisseau
        MOVE 3 TO fv_typeVaisseau
        MOVE 30 TO fv_capacite
        MOVE "étoile noire" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        MOVE "tgvdupauvre" TO fv_nomVaisseau
        MOVE 1 TO fv_typeVaisseau
        MOVE 5 TO fv_capacite
        MOVE "mars" TO fv_nomLieu
        OPEN I-O Fvaisseaux
            WRITE vTampon END-WRITE
        CLOSE Fvaisseaux

        DISPLAY "SPACEX 2118 -- Génération de 9 vaisseaux !".
