       AJOUT_EQUIPE.
               OPEN I-O Fequipes

               DISPLAY "id equipe"
               PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                   ACCEPT fe_idEquipe
               END-PERFORM

               READ Fequipes  KEY IS fe_idEquipe
                   INVALID KEY
                        DISPLAY "description equipe"
                        ACCEPT fe_description
                        MOVE 0 TO fe_nbAstronautes
                        MOVE 0 TO fe_idMission
                        WRITE eTampon
                           INVALID KEY
                                DISPLAY "erreur"
                          NOT INVALID KEY
                                DISPLAY "ajout reussi"
                            END-WRITE
                    NOT INVALID KEY
                    DISPLAY "identifiant existant"
               END-READ
               CLOSE Fequipes.


               MODIFIER_EQUIPE.

               OPEN I-O Fequipes

               DISPLAY "id equipe"
               PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                   ACCEPT fe_idEquipe
               END-PERFORM

               READ Fequipes , KEY IS  fe_idEquipe
                INVALID KEY
                    DISPLAY "equipe existe pas"
                NOT INVALID KEY
                        DISPLAY 'description '
                        ACCEPT fe_description
                        REWRITE eTampon
                            INVALID KEY
                                DISPLAY "erreur"
                            NOT INVALID KEY
                                DISPLAY "modification efefctue"
                        END-REWRITE
               END-READ

               CLOSE Fequipes.

               SUPPRIMER_EQUIPE.

               OPEN I-O Fequipes

               DISPLAY "id equipe"
               PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                   ACCEPT fe_idEquipe
               END-PERFORM

               READ Fequipes  KEY IS fe_idEquipe
                   INVALID KEY
                       DISPLAY "identifiant existe pas"
                   NOT INVALID KEY
                       DELETE Fequipes  RECORD
               END-READ

               CLOSE Fequipes.


               AFFICHER_MEMBRE_EQUIPE.

            MOVE 0 TO Wfin
            OPEN INPUT Fequipes
            OPEN INPUT Fastronautes


            DISPLAY "id equipe"
            PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                ACCEPT fe_idEquipe
            END-PERFORM

            READ Fequipes  KEY IS fe_idEquipe
                INVALID KEY
                     DISPLAY "identifiant existe pas"
                NOT INVALID KEY
                    MOVE fe_idEquipe  TO fa_idEquipe
                    START Fastronautes , KEY IS = fa_idEquipe
                        INVALID KEY
                            DISPLAY "erreur"
                        NOT INVALID KEY
                            PERFORM WITH TEST AFTER UNTIL Wfin = 1
                               OR fa_idEquipe <> fe_idEquipe
                                READ Fastronautes
                                    AT END
                                        MOVE 1 TO WFin
                                    NOT AT END
                                        DISPLAY "nom " fa_nom
                                        DISPLAY "prenom " fa_prenom
                                        DISPLAY "role " fa_role
                                        DISPLAY "pays " fa_pays
                                END-READ
                            END-PERFORM
                    END-START

            END-READ

            CLOSE Fequipes
            CLOSE Fastronautes.


           RECHERCHE_VAISSEAU_EQUIPE.

            MOVE  0 TO Wfin
            MOVE ' ' TO WnomVaisseau

            OPEN INPUT Fequipes
            OPEN INPUT Fmissions
            OPEN INPUT Fvaisseaux

            DISPLAY "id equipe"
            PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                ACCEPT fe_idEquipe
            END-PERFORM


            READ Fequipes  KEY IS fe_idEquipe
                INVALID KEY
                     DISPLAY "identifiant existe pas"
                NOT INVALID KEY
                    MOVE fe_nbAstronautes TO WnbEquipe
                    MOVE fe_idMission TO fm_idMission
                    READ Fmissions , KEY IS fm_idMission
                        INVALID KEY
                            DISPLAY "erreur"
                        NOT INVALID KEY
                            MOVE fm_nomLieu TO fv_nomLieu
                            START Fvaisseaux  KEY IS = fv_nomLieu
                                INVALID KEY
                                    DISPLAY "erreur"
                                NOT INVALID KEY
                                    PERFORM WITH TEST AFTER UNTIL Wfin = 1
                                       OR fv_nomLieu <> fm_nomLieu
                                        READ Fvaisseaux
                                            AT END
                                                MOVE 1 TO Wfin
                                            NOT AT END
                                                IF WnbEquipe < fv_capacite THEN
                                                    MOVE fv_capacite
                                                       TO WnbEquipe
                                                    MOVE fv_nomVaisseau
                                                       TO WnomVaisseau
                                                END-IF
                                        END-READ
                                    END-PERFORM

                                END-START
                    END-READ
            END-READ

            DISPLAY "le vaisseau " fv_nomVaisseau

            CLOSE Fequipes
            CLOSE Fmissions
            CLOSE Fvaisseaux.

            RECHERCHE_LIEU_EQUIPE.

            OPEN INPUT Fequipes
            OPEN INPUT Fmissions

            DISPLAY "id equipe"
            PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                ACCEPT fe_idEquipe
            END-PERFORM

            READ Fequipes  KEY IS fe_idEquipe
                INVALID KEY
                     DISPLAY "identifiant existe pas"
                NOT INVALID KEY
                    MOVE fe_idMission TO fm_idMission
                    READ Fmissions
                        INVALID KEY
                            DISPLAY "erreur"
                        NOT INVALID KEY
                            DISPLAY "le lieu de la mission  : "
                               fm_nomLieu
                    END-READ
            END-READ

            CLOSE Fequipes
            close Fmissions.


           RECHERCHE_MISSION_EQUIPE.

            OPEN INPUT Fequipes
            OPEN INPUT Fmissions

            DISPLAY "id equipe"
            PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                ACCEPT fe_idEquipe
            END-PERFORM

            READ Fequipes  KEY IS fe_idEquipe
                INVALID KEY
                     DISPLAY "identifiant existe pas"
                NOT INVALID KEY
                    MOVE fe_idMission TO fm_idMission
                    READ Fmissions  , KEY IS fm_idMission
                        INVALID KEY
                            DISPLAY "erreur"
                        NOT INVALID KEY
                            DISPLAY "identidiant mission " fm_idMission
                    END-READ
            END-READ

            CLOSE Fequipes
            CLOSE Fmissions.


        RECHERCHE_VOISIN_EQUIPE.

            OPEN INPUT Fequipes
            OPEN INPUT Fmissions

            DISPLAY "id equipe"
            PERFORM WITH TEST AFTER UNTIL fe_idEquipe > 0
                ACCEPT fe_idEquipe
            END-PERFORM

            READ Fequipes  KEY IS fe_idEquipe
                INVALID KEY
                     DISPLAY "identifiant existe pas"
                NOT INVALID KEY
                    MOVE fe_idMission TO fm_idMission
                    READ Fmissions  , KEY IS fm_idMission
                        INVALID KEY
                            DISPLAY "erreur"
                        NOT INVALID KEY
                            MOVE fm_nomLieu TO WnomLieu
                    END-READ
            END-READ

            CLOSE Fequipes

            OPEN INPUT Fequipes
            PERFORM WITH TEST AFTER UNTIL Wfin = 1
                READ Fequipes
                    AT END
                        MOVE 1 TO Wfin
                    NOT AT END
                        MOVE fe_idMission TO fm_idMission
                        READ Fmissions , KEY IS  fm_idMission
                            INVALID KEY
                                DISPLAY "erreur"
                            NOT INVALID KEY
                                IF fm_nomLieu = WnomLieu THEN
                                    DISPLAY "identidiant : "
                                           fm_idMission
                                    DISPLAY "description : "
                                           fm_description
                                END-IF
                        END-READ
                END-READ
            END-PERFORM
            CLOSE Fequipes
            CLOSE Fmissions.
