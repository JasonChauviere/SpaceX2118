        VERIF_MISSION.
        OPEN INPUT Fmissions        
        MOVE Wfm_idMission TO fm_idMission
        READ Fmissions
        INVALID KEY
              MOVE 0 TO Wverif_m
        NOT INVALID KEY
              MOVE 1 TO Wverif_m
              DISPLAY "ERREUR ! Identifiant déja attribué !"
        END-READ
        CLOSE Fmissions.

        VERIF_LIEU.
        OPEN INPUT Flieux        
        MOVE Wfm_nomLieu TO fl_nomLieu
        READ Flieux
        INVALID KEY
              MOVE 0 TO Wverif_l
              DISPLAY "Lieu inexistant !"
        NOT INVALID KEY
              MOVE 1 TO Wverif_l
        END-READ
        CLOSE Flieux.

        AJOUT_MISSION.
        PERFORM WITH TEST AFTER UNTIL Waj_m = 0
            DISPLAY ' '
            DISPLAY "Identifiant de la mission ?"
            ACCEPT Wfm_idMission
            PERFORM VERIF_MISSION
            IF Wverif_m = 0 THEN
                MOVE Wfm_idMission TO fm_idMission
                DISPLAY "Lieu de la mission ?"
                ACCEPT Wfm_nomLieu2
                MOVE FUNCTION LOWER-CASE(Wfm_nomLieu2) TO Wfm_nomLieu
                PERFORM VERIF_LIEU
                IF Wverif_l = 1 THEN
                    MOVE Wfm_nomLieu TO fm_nomLieu
                    DISPLAY "Description rapide de la mission ?"
                    ACCEPT fm_description
                    OPEN I-O Fmissions
                    WRITE mTampon END-WRITE
                    CLOSE Fmissions
                    DISPLAY "Mission ajoutée avec succès."
                END-IF
            END-IF
            PERFORM WITH TEST AFTER UNTIL Waj_m = 0 OR Waj_m = 1
                    DISPLAY ' '
                    DISPLAY 'Autres missions à ajouter ? ',
"(0 : Non // 1 : Oui)"
                        ACCEPT Waj_m
            END-PERFORM
        END-PERFORM.
       
        SUPPRIMER_MISSION.
        OPEN I-O Fmissions
        DISPLAY 'Identifiant de la mission à détruire ?'
        PERFORM WITH TEST AFTER UNTIL Wfm_idMissionD > 0
            ACCEPT Wfm_idMissionD
        END-PERFORM
        MOVE Wfm_idMissionD TO fm_idMission
        READ Fmissions
        INVALID KEY
            DISPLAY "Cette mission n'existe pas, impossible à détruire !"
        NOT INVALID KEY
            DELETE Fmissions RECORD END-DELETE
            DISPLAY "Mission n°", Wfm_idMissionD, " détruite." 
            OPEN I-O Fequipes
            MOVE Wfm_idMissionD TO fe_idMission
            START Fequipes, KEY IS = fe_idMission
            INVALID KEY
                DISPLAY " "
            NOT INVALID KEY
                MOVE 0 TO fe_fin
                PERFORM WITH TEST AFTER UNTIL fe_fin = 1
                    READ Fequipes NEXT
                    AT END MOVE 1 TO fe_fin
                    NOT AT END
                        IF Wfm_idMissionD = fe_idMission THEN
                            MOVE 0 TO fe_idMission
                            REWRITE eTampon END-REWRITE
                        END-IF
                    END-READ
                END-PERFORM
            END-START                                   
        END-READ        
        CLOSE Fmissions.
       	
        MODIFIER_MISSION.
        DISPLAY "Identifiant de la mission à modifier ?"
        ACCEPT Wfm_idMission
        OPEN I-O Fmissions        
        MOVE Wfm_idMission TO fm_idMission
        READ Fmissions
        INVALID KEY
            DISPLAY "ERREUR ! Identifiant inconnu !"
        NOT INVALID KEY    
            DISPLAY "Que souhaitez-vous modifier ?"
            DISPLAY "1 : Description // 2 : Lieu"
            MOVE 0 TO Wfmodif_m
            PERFORM WITH TEST AFTER UNTIL
                    Wfmodif_m = 1 OR
                    Wfmodif_m = 2           
              ACCEPT Wfmodif_m
            END-PERFORM
            IF Wfmodif_m = 1 THEN
                DISPLAY "Nouvelle description ?"
                ACCEPT Wfm_description
                MOVE Wfm_description TO fm_description
                REWRITE mTampon END-REWRITE
                DISPLAY "Mission modifiée."
            END-IF
            IF Wfmodif_m = 2 THEN
                DISPLAY "Nouveau lieu ?"
                ACCEPT Wfm_lieu2
                MOVE FUNCTION LOWER-CASE(Wfm_lieu2) TO Wfm_lieu
                OPEN INPUT Flieux        
                MOVE Wfm_lieu TO fl_nomLieu
                READ Flieux
                INVALID KEY
                      DISPLAY "ERREUR ! Lieu inexistant !"
                NOT INVALID KEY
                      REWRITE mTampon END-REWRITE
                      DISPLAY "Mission modifiée."
                END-READ
                CLOSE Flieux
            END-IF
        END-READ
        CLOSE Fmissions.                 

        AFFICHER_MISSION.
        OPEN INPUT Fmissions
        DISPLAY "Identifiant de la mission ?"
        ACCEPT Wid_mission
        MOVE Wid_mission TO fm_idMission
        READ Fmissions
        INVALID KEY
            DISPLAY "Cet identifiant de mission est inexistant."
        NOT INVALID KEY
            DISPLAY "#############"
            DISPLAY "<-- ID de la mission : ", fm_idMission, " -->"
            DISPLAY "Nom du lieu de la mission : ", fm_nomLieu
            DISPLAY "Description de la mission : ", fm_description
        END-READ
        CLOSE Fmissions.

        RECHERCHE_MISSION.
        MOVE 0 TO Wfmr_choix
        DISPLAY "Vous voulez savoir..."
        DISPLAY "1 : les équipes se trouvant sur le lieu de la mission ?"
        DISPLAY "2 : les astronautes se trouvant sur le lieu de la ",
"mission ?"
        PERFORM WITH TEST AFTER UNTIL
                    Wfmr_choix = 1 OR
                    Wfmr_choix = 2              
                ACCEPT Wfmr_choix
        END-PERFORM
        IF Wfmr_choix = 1 THEN
                PERFORM REC_MIS_VOISINS_EQUIPE
        END-IF
        IF Wfmr_choix = 2 THEN
                PERFORM REC_MIS_VOISINS_ASTRONAUTES
        END-IF.

        REC_MIS_VOISINS_EQUIPE.
        DISPLAY " "
        DISPLAY "De quelle mission (identifiant) ?"
        ACCEPT Wfm_idMission
        MOVE Wfm_idMission TO fm_idMission
        OPEN INPUT Fmissions
        READ Fmissions
        INVALID KEY
            DISPLAY "Cette mission n'existe pas."
        NOT INVALID KEY
            MOVE fm_nomLieu TO LieuEquipe
        END-READ
        CLOSE Fmissions
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
            DISPLAY "<-- ID de l'équipe : ", fe_idEquipe, " -->"
            DISPLAY "Nombre d'astronautes : ", fe_nbAstronautes
            DISPLAY "Description de l'équipe : ", fe_description
            DISPLAY "Mission de l'équipe : ", fe_idMission
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

        REC_MIS_VOISINS_ASTRONAUTES.
        DISPLAY " "
        DISPLAY "De quelle mission (identifiant) ?"
        ACCEPT Wfm_idMission
        MOVE Wfm_idMission TO fm_idMission
        OPEN INPUT Fmissions
        READ Fmissions
        INVALID KEY
            DISPLAY "Cette mission n'existe pas."
        NOT INVALID KEY
            MOVE fm_nomLieu TO LieuEquipe
        END-READ
        CLOSE Fmissions
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
          OPEN INPUT Fastronautes
          MOVE fe_idEquipe TO fa_idEquipe
          START Fastronautes, KEY IS = fa_idEquipe
          INVALID KEY
              DISPLAY " "
          NOT INVALID KEY
              MOVE 0 TO Wa_fin
              PERFORM WITH TEST AFTER UNTIL Wa_fin = 1
                  READ Fastronautes NEXT
                  AT END MOVE 1 TO Wa_fin
                  NOT AT END
                      IF fe_idEquipe = fa_idEquipe THEN
                          DISPLAY "#############"
                          DISPLAY "<-- ID de l'astronaute :",
" ", fa_idAstronaute, " -->"
                          DISPLAY "Nom de l'astronaute : ", fa_nom
                          DISPLAY "Prénom de l'astronaute : ", fa_prenom
                       END-IF
                  END-READ
              END-PERFORM
          END-START
          CLOSE Fastronautes
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

        STAT_NB_MISSIONS.
        OPEN INPUT Fmissions
        MOVE 0 TO Wmiss_fin
        MOVE 0 TO WS_nbMissions
        PERFORM WITH TEST AFTER UNTIL Wmiss_fin = 1
            READ Fmissions NEXT
            AT END
                MOVE 1 TO Wmiss_fin
            NOT AT END
                ADD 1 TO WS_nbMissions
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbMissions, " mission(s) dans ",
"les données."
        CLOSE Fmissions.

        COLLECTION_DONNEES_MISSION.
        MOVE 301 TO fm_idMission
        MOVE "venus" TO fm_nomLieu
        MOVE "Exploration de Vénus" TO fm_description
        OPEN I-O Fmissions
            WRITE mTampon END-WRITE
        CLOSE Fmissions

        MOVE 302 TO fm_idMission
        MOVE "pallas" TO fm_nomLieu
        MOVE "Destruction de Pallas" TO fm_description
        OPEN I-O Fmissions
            WRITE mTampon END-WRITE
        CLOSE Fmissions

        DISPLAY "SPACEX 2118 -- Génération de 2 missions effectuées !".
