        VERIF_EQUIPE.
        OPEN INPUT Fequipes        
        MOVE Wfe_idEquipe TO fe_idEquipe
        READ Fequipes
        INVALID KEY
              MOVE 0 TO Wverif_e
        NOT INVALID KEY
              MOVE 1 TO Wverif_e
              DISPLAY "ERREUR ! Identifiant d�ja attribu� !"
        END-READ
        CLOSE Fequipes.

        VERIF_COMMANDANT.
        OPEN I-O Fastronautes
        MOVE Wfe_idCdt TO fa_idAstronaute
        READ Fastronautes
        INVALID KEY
            DISPLAY "Cet identifiant d'astronaute est inexistant."
            MOVE 1 TO Wverif_cdt
        NOT INVALID KEY
            IF fa_role = 1 THEN
                IF fa_idEquipe = 0 THEN
                    MOVE Wfe_idEquipe TO fa_idEquipe
                    REWRITE aTampon END-REWRITE
                    MOVE 0 TO Wverif_cdt
                ELSE
                    DISPLAY "Ce commandant a d�j� une �quipe."
                    MOVE 1 TO Wverif_cdt
                END-IF
            ELSE
                DISPLAY "Cet astronaute n'est pas commandant."
                MOVE 1 TO Wverif_cdt
            END-IF
        END-READ
        CLOSE Fastronautes.

        AJOUT_EQUIPE.
        PERFORM WITH TEST AFTER UNTIL Waj_e = 0
            DISPLAY ' '
            DISPLAY "Identifiant de l'�quipe ?"
            PERFORM WITH TEST AFTER UNTIL Wfe_idEquipe > 0
                ACCEPT Wfe_idEquipe
            END-PERFORM
            PERFORM VERIF_EQUIPE
            IF Wverif_e = 0 THEN
                DISPLAY "Identifiant de l'astronaute commandant ?"
                ACCEPT Wfe_idCdt
                PERFORM VERIF_COMMANDANT
                IF Wverif_cdt = 0 THEN
                    DISPLAY "Description rapide de l'�quipe ?"
                    ACCEPT fe_description
                    MOVE Wfe_idEquipe TO fe_idEquipe
                    MOVE 1 TO fe_nbAstronautes
                    MOVE 0 TO fe_idMission
                    OPEN I-O Fequipes
                    WRITE eTampon END-WRITE
                    CLOSE Fequipes
                    DISPLAY "�quipe ajout�e avec succ�s."
                END-IF
            END-IF
            PERFORM WITH TEST AFTER UNTIL Waj_e = 0 OR Waj_e = 1
                    DISPLAY ' '
                    DISPLAY 'Autres �quipes � ajouter ? ',
"(0 : Non // 1 : Oui)"
                        ACCEPT Waj_e
            END-PERFORM
        END-PERFORM.

        SUPPRIMER_EQUIPE.
        OPEN I-O Fequipes
        DISPLAY "Identifiant de l'�quipe � d�truire ?"
        ACCEPT Wfe_idEquipe
        MOVE Wfe_idEquipe TO fe_idEquipe
        READ Fequipes
        INVALID KEY
            DISPLAY "Cette �quipe n'existe pas, impossible � d�truire !"
        NOT INVALID KEY
            OPEN I-O Fastronautes
            MOVE Wfe_idEquipe TO fa_idEquipe
            START Fastronautes, KEY IS = fa_idEquipe
            INVALID KEY
                DISPLAY "Impossible"
            NOT INVALID KEY
                MOVE 0 TO Was_fin
                PERFORM WITH TEST AFTER UNTIL Was_fin = 0
                    READ Fastronautes NEXT
                    AT END
                        MOVE 1 TO Was_fin
                    NOT AT END
                        IF fa_idEquipe = Wfe_idEquipe THEN
                            MOVE 0 TO fa_idEquipe
                            REWRITE aTampon END-REWRITE
                        END-IF
                    END-READ
                END-PERFORM
            END-START
            DELETE Fequipes RECORD END-DELETE
            DISPLAY "�quipe n�", Wfe_idEquipe, " d�truite."
        END-READ    
        CLOSE Fequipes.

        MODIFIER_EQUIPE.
        MOVE 0 TO Wmission
        DISPLAY "Identifiant de l'�quipe � modifier ?"
        ACCEPT Wfe_idEquipe
        OPEN I-O Fequipes        
        MOVE Wfe_idEquipe TO fe_idEquipe
        READ Fequipes
        INVALID KEY
              DISPLAY "ERREUR ! �quipe inexistante !"
        NOT INVALID KEY
              DISPLAY "Que souhaitez-vous modifier ?"
              DISPLAY "1 : Description // 2 : Mission"
              MOVE 0 TO Wfmodif
              PERFORM WITH TEST AFTER UNTIL Wfmodif = 1 OR Wfmodif = 2
                ACCEPT Wfmodif
              END-PERFORM
              IF Wfmodif = 1 THEN
                DISPLAY "Nouvelle description ?"
                ACCEPT Wfm_description
                MOVE Wfm_description TO fe_description
                REWRITE eTampon END-REWRITE
                DISPLAY "�quipe modifi�e."
              END-IF  
              IF Wfmodif = 2 THEN
                DISPLAY "Nouvelle mission ?"
                ACCEPT Wfm_idMission
                OPEN INPUT Fmissions
                MOVE Wfm_idMission TO fm_idMission
                READ Fmissions
                INVALID KEY
                    DISPLAY "Cette mission n'existe pas."
                NOT INVALID KEY
                    MOVE 1 TO Wmission
                END-READ
                CLOSE Fmissions
                IF Wmission = 1 THEN
                    CLOSE Fequipes
                    OPEN INPUT Fequipes
                    MOVE Wfm_idMission TO fe_idMission
                    START Fequipes, KEY IS = fe_idMission
                    INVALID KEY
                        MOVE 1 TO Wmission
                    NOT INVALID KEY
                        MOVE 0 TO Wm_fin
                        PERFORM WITH TEST AFTER UNTIL Wm_fin = 1
                            READ Fequipes NEXT
                            AT END MOVE 1 TO Wm_fin
                            NOT AT END
                              DISPLAY "Cette mission est d�j� attribu�e."
                              MOVE 0 TO Wmission
                            END-READ
                        END-PERFORM
                    END-START
                    CLOSE Fequipes
                    IF Wmission = 1 THEN
                        OPEN I-O Fequipes
                        MOVE Wfe_idEquipe TO fe_idEquipe
                        READ Fequipes
                        INVALID KEY
                            DISPLAY "Impossible"
                        NOT INVALID KEY
                            MOVE Wfm_idMission TO fe_idMission
                            REWRITE eTampon END-REWRITE
                            DISPLAY "�quipe modifi�e."
                        END-READ
                    END-IF
                END-IF
            END-IF
        END-READ
        CLOSE Fequipes.
        
        AFFICHER_EQUIPE.
        OPEN INPUT Fequipes
        DISPLAY "Identifiant de l'�quipe ?"
        ACCEPT Wid_equipe
        MOVE Wid_equipe TO fe_idEquipe
        READ Fequipes
        INVALID KEY
            DISPLAY "Cet identifiant d'�quipe est inexistant."
        NOT INVALID KEY
            DISPLAY "#############"
            DISPLAY "<-- ID de l'�quipe : ", fe_idEquipe, " -->"
            DISPLAY "Nombre d'astronautes : ", fe_nbAstronautes
            DISPLAY "Description de l'�quipe : ", fe_description
            DISPLAY "Mission de l'�quipe : ", fe_idMission
        END-READ
        CLOSE Fequipes.

        RECHERCHE_EQUIPE.
        MOVE 0 TO Wfer_choix
        DISPLAY "Vous voulez savoir..."
        DISPLAY "1 : o� se trouve une �quipe (le lieu) ?"
        DISPLAY "2 : les �quipes-voisines d'une �quipe donn�e ? "
        PERFORM WITH TEST AFTER UNTIL
                    Wfer_choix = 1 OR
                    Wfer_choix = 2              
                ACCEPT Wfer_choix
        END-PERFORM
        IF Wfer_choix = 1 THEN
                PERFORM RECHERCHE_EQUIPE_LIEU
        END-IF
        IF Wfer_choix = 2 THEN
                PERFORM RECHERCHE_EQUIPE_VOISINS
        END-IF.

        RECHERCHE_EQUIPE_LIEU.
        DISPLAY " "
        DISPLAY "De quelle �quipe (identifiant) ?"
        PERFORM WITH TEST AFTER UNTIL Wfe_idEquipe > 0
            ACCEPT Wfe_idEquipe
        END-PERFORM
        MOVE Wfe_idEquipe TO fe_idEquipe
        OPEN INPUT Fequipes
        READ Fequipes
        INVALID KEY
            DISPLAY "Cette �quipe n'existe pas."
        NOT INVALID KEY
            IF fe_idMission = 0 THEN
                DISPLAY "Cette �quipe n'est pas en mission."
            ELSE
                MOVE fe_idMission TO fm_idMission
                OPEN INPUT Fmissions
                READ Fmissions
                INVALID KEY
                    DISPLAY "Impossible"
                NOT INVALID KEY
                    DISPLAY "#############"
                    DISPLAY "L'�quipe n�", fe_idEquipe, " se trouve",
" dans le lieu ", fm_nomLieu, "."
                END-READ
            END-IF
        END-READ
        CLOSE Fmissions
        CLOSE Fequipes.

        RECHERCHE_EQUIPE_VOISINS.
        DISPLAY " "
        DISPLAY "De quelle �quipe (identifiant) ?"
        PERFORM WITH TEST AFTER UNTIL Wfe_idEquipe > 0
            ACCEPT Wfe_idEquipe
        END-PERFORM
        MOVE Wfe_idEquipe TO fe_idEquipe
        OPEN INPUT Fequipes
        READ Fequipes
        INVALID KEY
            DISPLAY "Cette �quipe n'existe pas."
        NOT INVALID KEY   
            IF fe_idMission = 0 THEN
                DISPLAY "Cette �quipe n'est pas en mission."
            ELSE
                MOVE fe_idMission TO fm_idMission
                OPEN INPUT Fmissions
                READ Fmissions
                INVALID KEY
                    DISPLAY "Impossible"
                NOT INVALID KEY
                    MOVE fm_nomLieu TO LieuEquipe
                END-READ
                CLOSE Fmissions
            END-IF
        END-READ
        CLOSE Fequipes
        OPEN INPUT Fmissions
        MOVE LieuEquipe TO fm_nomLieu
        START Fmissions, KEY IS = fm_nomLieu
        INVALID KEY
            DISPLAY " "
        NOT INVALID KEY
            MOVE 0 TO Wm_fin
            PERFORM WITH TEST AFTER UNTIL Wm_fin = 0
                READ Fmissions NEXT
                AT END MOVE 1 TO Wm_fin
                NOT AT END
                    IF LieuEquipe = fm_nomLieu THEN
                        OPEN INPUT Fequipes
                        MOVE fm_idMission TO fe_idMission
                        START Fequipes, KEY IS = fe_idMission
                        INVALID KEY
                            DISPLAY " "
                        NOT INVALID KEY
                            MOVE 0 TO We_fin
                            PERFORM WITH TEST AFTER UNTIL We_fin = 0
                                READ Fequipes NEXT
                                AT END MOVE 1 TO We_fin
                                NOT AT END
                                    IF fm_idMission = fe_idMission THEN
                                        DISPLAY "#############"
            DISPLAY "<-- ID de l'�quipe : ", fe_idEquipe, " -->"
            DISPLAY "Nombre d'astronautes : ", fe_nbAstronautes
            DISPLAY "Description de l'�quipe : ", fe_description
            DISPLAY "Mission de l'�quipe : ", fe_idMission
                                    END-IF
                                END-READ
                            END-PERFORM
                        END-START
                        CLOSE Fequipes
                    END-IF
                END-READ
            END-PERFORM
        END-START
        CLOSE Fmissions.

        STAT_NB_EQUIPES.
        OPEN INPUT Fequipes
        MOVE 0 TO Weq_fin
        MOVE 0 TO WS_nbEquipes
        PERFORM WITH TEST AFTER UNTIL Weq_fin = 1
            READ Fequipes NEXT
            AT END
                MOVE 1 TO Weq_fin
            NOT AT END
                ADD 1 TO WS_nbEquipes
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbEquipes, " �quipe(s) dans les donn�es."
        CLOSE Fequipes.

        COLLECTION_DONNEES_EQUIPE.
        MOVE 201 TO fe_idEquipe
        MOVE 5 TO fe_nbAstronautes
        MOVE "FCNantes" TO fe_description
        MOVE 302 TO fe_idMission
        OPEN I-O Fequipes
            WRITE eTampon END-WRITE
        CLOSE Fequipes

        MOVE 61 TO fe_idEquipe
        MOVE 3 TO fe_nbAstronautes
        MOVE "ParisSG" TO fe_description
        MOVE 0 TO fe_idMission
        OPEN I-O Fequipes
            WRITE eTampon END-WRITE
        CLOSE Fequipes

        DISPLAY "SPACEX 2118 -- G�n�ration de 2 �quipes effectu�es !".   
