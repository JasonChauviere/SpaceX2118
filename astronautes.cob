        VERIF_ASTRONAUTE.
        OPEN INPUT Fastronautes        
        MOVE Wfa_idAstronaute TO fa_idAstronaute
        READ Fastronautes
        INVALID KEY
              MOVE 0 TO Wverif_a
        NOT INVALID KEY
              MOVE 1 TO Wverif_a
              DISPLAY "ERREUR ! Identifiant déja attribué !"
        END-READ
        CLOSE Fastronautes.

        VERIF_EQUIPEA.
        MOVE 0 TO Wechec
        IF Wfa_idEquipe > 0 AND Wfa_role2 = 1 THEN
            DISPLAY "Un commandant ne peut pas être associé à une",
" équipe de cette manière."
            MOVE 1 TO Wechec
        END-IF
        IF Wfa_idEquipe > 0 AND Wechec = 0 THEN
            OPEN INPUT Fequipes
            MOVE Wfa_idEquipe TO fe_idEquipe
            READ Fequipes
            INVALID KEY
                DISPLAY "Équipe inexistante"
                MOVE 1 TO Wechec
            NOT INVALID KEY
                OPEN INPUT Fastronautes
                MOVE Wfa_idEquipe TO fa_idEquipe
                START Fastronautes, KEY IS = fa_idEquipe
                INVALID KEY
                    DISPLAY " "
                NOT INVALID KEY
                    MOVE 0 TO Wfin
                    PERFORM WITH TEST AFTER UNTIL Wfin = 1
                        READ Fastronautes NEXT
                        AT END MOVE 1 TO Wfin
                        NOT AT END
                            IF fa_idEquipe = Wfa_idEquipe THEN
                                IF Wfa_role2 = 2 OR Wfa_role2 = 3 THEN
                                        IF Wfa_role2 = fa_role THEN
                                            DISPLAY "Ce rôle unique",
" est déjà présent dans cette équipe !!!"
                                            MOVE 1 TO Wechec
                                        END-IF
                                END-IF
                            END-IF
                        END-READ
                    END-PERFORM
                END-START
                CLOSE Fastronautes
            END-READ
            CLOSE Fequipes
        END-IF.       

        AJOUT_ASTRONAUTE.
        PERFORM WITH TEST AFTER UNTIL Waj_a = 0
              DISPLAY ' '
              DISPLAY "Identifiant de l'astronaute ?"
              ACCEPT Wfa_idAstronaute              
              PERFORM VERIF_ASTRONAUTE
              IF Wverif_a = 0 THEN
                    MOVE Wfa_idAstronaute TO fa_idAstronaute2
                    DISPLAY "Nom de l'astronaute ?"
                    ACCEPT fa_nom2
                    DISPLAY "Prénom de l'astronaute ?"
                    ACCEPT fa_prenom2
                    DISPLAY "Rôle de l'astronaute ?"
                    DISPLAY "1 : Commandant"
                    DISPLAY "2 : Chef Scientifique"
                    DISPLAY "3 : Chef de Sécurité"
                    DISPLAY "4 : Ingénieur"
                    DISPLAY "5 : Infirmier"
                    DISPLAY "6 : Community Manager"
                    DISPLAY "7 : Navigateur"
                    DISPLAY "8 : Officier de Sécurité"
                    DISPLAY "9 : Scientifique"                    
                    PERFORM WITH TEST AFTER UNTIL
                                    Wfa_role2 < 10 AND Wfa_role2 > 0
                        ACCEPT Wfa_role2
                    END-PERFORM
                    DISPLAY "Pays de l'astronaute ?"
                    ACCEPT Wfa_pays
                    MOVE FUNCTION LOWER-CASE(Wfa_pays) TO fa_pays2
                    DISPLAY "Équipe de l'astronaute (identifiant) ? ",
"Si aucune équipe alors, tapez 0."
                    ACCEPT Wfa_idEquipe
                    PERFORM VERIF_EQUIPEA
                    IF Wechec = 0 THEN
                        MOVE fa_idAstronaute2 TO fa_idAstronaute
                        MOVE fa_nom2 TO fa_nom
                        MOVE fa_prenom2 TO fa_prenom
                        MOVE Wfa_role2 TO fa_role
                        MOVE fa_pays2 TO fa_pays
                        MOVE Wfa_idEquipe TO fa_idEquipe
                        OPEN I-O Fastronautes       
                        WRITE aTampon END-WRITE
                        CLOSE Fastronautes
                        DISPLAY "Astronaute ajouté avec succès."
                        IF fa_idEquipe > 0 THEN
                            OPEN I-O Fequipes
                            MOVE fa_idEquipe TO fe_idEquipe
                            READ Fequipes
                            INVALID KEY
                                DISPLAY "Impossible"
                            NOT INVALID KEY
                                ADD 1 TO fe_nbAstronautes
                                REWRITE eTampon END-REWRITE
                            END-READ
                            CLOSE Fequipes
                        END-IF
                    END-IF              
              END-IF
              PERFORM WITH TEST AFTER UNTIL Waj_a = 0 OR Waj_a = 1
                    DISPLAY ' '
                    DISPLAY 'Autres astronautes à ajouter ? ',
"(0 : Non // 1 : Oui)"
                        ACCEPT Waj_a
              END-PERFORM
        END-PERFORM.

        SUPPRIMER_ASTRONAUTE.
        OPEN I-O Fastronautes
        DISPLAY "Identifiant de l'astronaute à détruire ?"
        ACCEPT Wfa_idAstronaute
        MOVE Wfa_idAstronaute TO fa_idAstronaute
        READ Fastronautes
        INVALID KEY
            DISPLAY "Cet astronaute n'existe pas, impossible à détruire",
" !"
        NOT INVALID KEY
            IF fa_idEquipe > 0 THEN
                IF fa_role = 1 THEN
                   DISPLAY "Cet astronaute est un Commandant d'équipe."
                   DISPLAY "Impossible de le supprimer."            
                ELSE
                   OPEN I-O Fequipes
                   MOVE fa_idEquipe TO fe_idEquipe
                   READ Fequipes
                   INVALID KEY
                       DISPLAY "Impossible"
                   NOT INVALID KEY                        
                       SUBTRACT 1 FROM fe_nbAstronautes
                       REWRITE eTampon END-REWRITE
                   END-READ
                   DELETE Fastronautes RECORD END-DELETE
                   DISPLAY "Astronaute n°", Wfa_idAstronaute, " détruit."
                   CLOSE Fequipes
            ELSE
                IF fa_idequipe = 0 THEN
                DELETE Fastronautes RECORD END-DELETE
                DISPLAY "Astronaute n°", Wfa_idAstronaute, " détruit."
                END-IF
            END-IF            
        END-READ    
        CLOSE Fastronautes.

        VERIF_EQUIPE2.
        OPEN INPUT Fequipes        
        MOVE Wfm_idEquipe TO fe_idEquipe
        READ Fequipes
        INVALID KEY
              MOVE 1 TO Wverif_e
              DISPLAY "Équipe inexistante."
        NOT INVALID KEY
              MOVE 0 TO Wverif_e
        END-READ
        CLOSE Fequipes.

        MODIFIER_ASTRONAUTE.
        DISPLAY "Identifiant de l'astronaute à modifier ?"
        ACCEPT Wfa_idAstronaute
        OPEN I-O Fastronautes        
        MOVE Wfa_idAstronaute TO fa_idAstronaute
        READ Fastronautes
        INVALID KEY
            DISPLAY "ERREUR ! Identifiant inconnu !"
        NOT INVALID KEY
            DISPLAY "Que souhaitez-vous modifier ?"
            DISPLAY "1 : Nom // 2 : Prénom // 3 : Pays // 4 : Équipe"
            MOVE 0 TO Wfmodif
            PERFORM WITH TEST AFTER UNTIL
                    Wfmodif = 1 OR
                    Wfmodif = 2 OR
                    Wfmodif = 3 OR
                    Wfmodif = 4             
              ACCEPT Wfmodif
            END-PERFORM
            IF Wfmodif = 1 THEN
                DISPLAY "Nouveau nom ?"
                ACCEPT Wfm_nom
                MOVE Wfm_nom TO fa_nom
                REWRITE aTampon END-REWRITE
                DISPLAY "Astronaute modifié."
                CLOSE Fastronautes
            END-IF  
            IF Wfmodif = 2 THEN
                DISPLAY "Nouveau prénom ?"
                ACCEPT Wfm_prenom
                MOVE Wfm_prenom TO fa_prenom
                REWRITE aTampon END-REWRITE
                DISPLAY "Astronaute modifié."
                CLOSE Fastronautes
            END-IF            
            IF Wfmodif = 3 THEN
                DISPLAY "Nouveau pays ?"
                ACCEPT Wfm_pays2
                MOVE FUNCTION LOWER-CASE(Wfm_pays2) TO Wfm_pays
                MOVE Wfm_pays TO fa_pays
                REWRITE aTampon END-REWRITE
                DISPLAY "Astronaute modifié."
                CLOSE Fastronautes
            END-IF
            IF Wfmodif = 4 THEN
                IF fa_role = 1 AND fa_idEquipe > 0 THEN
                    DISPLAY "Cet astronaute est un Commandant d'équipe."
                    DISPLAY "Impossible de le changer d'équipe."
                END-IF
                IF fa_role = 2 AND fa_idEquipe > 0 THEN
                    DISPLAY "Cet astronaute est Chef Scientifique ",
"d'une équipe."
                    DISPLAY "Impossible de le changer d'équipe."
                END-IF
                IF fa_role = 3 AND fa_idEquipe > 0 THEN 
                    DISPLAY "Cet astronaute est Chef de Sécurité ",
"d'une équipe."
                    DISPLAY "Impossible de le changer d'équipe."
                END-IF
            IF fa_role > 3 OR fa_idEquipe = 0 THEN
                DISPLAY "Identifiant de sa nouvelle équipe ?"
                PERFORM WITH TEST AFTER UNTIL Wfm_idEquipe > 0
                    ACCEPT Wfm_idEquipe
                END-PERFORM
                PERFORM VERIF_EQUIPE2
                IF Wverif_e = 0 THEN
                    MOVE fa_idEquipe TO WidEquipePerd
                    MOVE Wfm_idEquipe TO fa_idEquipe
                    REWRITE aTampon END-REWRITE
                    DISPLAY "Astronaute modifié."
                    CLOSE Fastronautes

                    OPEN I-O Fequipes
                    MOVE Wfm_idEquipe TO fe_idEquipe
                    READ Fequipes
                    INVALID KEY
                        DISPLAY " "
                    NOT INVALID KEY
                        ADD 1 TO fe_nbAstronautes
                        REWRITE eTampon END-REWRITE
                    END-READ
                    CLOSE Fequipes

                    OPEN I-O Fequipes
                    MOVE WidEquipePerd TO fe_idEquipe
                    READ Fequipes
                    INVALID KEY
                        DISPLAY " "
                    NOT INVALID KEY
                        SUBTRACT 1 FROM fe_nbAstronautes
                        REWRITE eTampon END-REWRITE
                    END-READ
                    CLOSE Fequipes
                END-IF
            END-IF
            END-IF
        END-READ.

        AFFICHER_ASTRONAUTE.
        DISPLAY "Identifiant de l'astronaute ?"
        ACCEPT Wid_astro
        OPEN INPUT Fastronautes        
        MOVE Wid_astro TO fa_idAstronaute
        READ Fastronautes
        INVALID KEY
            DISPLAY "Cet identifiant d'astronaute est inexistant."
        NOT INVALID KEY
            DISPLAY "#############"
            DISPLAY "<-- ID de l'astronaute : ", fa_idAstronaute, " -->"
            DISPLAY "Nom de l'astronaute : ", fa_nom
            DISPLAY "Prénom de l'astronaute : ", fa_prenom
            IF fa_role = 1 THEN
                MOVE "Commandant" TO Wfa_roleECR
            END-IF
            IF fa_role = 2 THEN
                MOVE "Chef Scientifique" TO Wfa_roleECR
            END-IF
            IF fa_role = 3 THEN
                MOVE "Chef de Sécurité" TO Wfa_roleECR
            END-IF
            IF fa_role = 4 THEN
                MOVE "Ingénieur" TO Wfa_roleECR
            END-IF
            IF fa_role = 5 THEN
                MOVE "Infirmier" TO Wfa_roleECR
            END-IF
            IF fa_role = 6 THEN
                MOVE "Community Manager" TO Wfa_roleECR
            END-IF
            IF fa_role = 7 THEN
                MOVE "Navigateur" TO Wfa_roleECR
            END-IF
            IF fa_role = 8 THEN
                MOVE "Officier de Sécurité" TO Wfa_roleECR
            END-IF
            IF fa_role = 9 THEN
                MOVE "Scientifique" TO Wfa_roleECR
            END-IF
            DISPLAY "Rôle de l'astronaute : ", Wfa_roleECR
            DISPLAY "Pays de l'astronaute : ", fa_pays
            DISPLAY "Équipe de l'astronaute : ", fa_idEquipe
            DISPLAY "#############"
        END-READ
        CLOSE Fastronautes.        

        RECHERCHE_ASTRONAUTE.
        MOVE 0 TO Wfar_choix
        DISPLAY "Vous voulez effectuer une recherche par ?"
        DISPLAY "1 : par rôle"
        DISPLAY "2 : par pays"
        DISPLAY "3 : par lieu"
        DISPLAY "4 : par équipe"
        PERFORM WITH TEST AFTER UNTIL
                    Wfar_choix = 1 OR
                    Wfar_choix = 2 OR
                    Wfar_choix = 3 OR
                    Wfar_choix = 4                
                ACCEPT Wfar_choix
        END-PERFORM
        IF Wfar_choix = 1 THEN
                PERFORM RECHERCHE_ASTRONAUTE_ROLE
        END-IF
        IF Wfar_choix = 2 THEN
                PERFORM RECHERCHE_ASTRONAUTE_PAYS
        END-IF
        IF Wfar_choix = 3 THEN
                PERFORM RECHERCHE_ASTRONAUTE_LIEU
        END-IF
        IF Wfar_choix = 4 THEN
                PERFORM RECHERCHE_ASTRONAUTE_EQUIPE
        END-IF.

        RECHERCHE_ASTRONAUTE_ROLE.
        DISPLAY "De quel rôle voulez-vous la liste des astronautes ?"
        DISPLAY "1 : Commandant"
        DISPLAY "2 : Chef Scientifique"
        DISPLAY "3 : Chef de Sécurité"
        DISPLAY "4 : Ingénieur"
        DISPLAY "5 : Infirmier"
        DISPLAY "6 : Community Manager"
        DISPLAY "7 : Navigateur"
        DISPLAY "8 : Officier de Sécurité"
        DISPLAY "9 : Scientifique"                    
        PERFORM WITH TEST AFTER UNTIL Wfar_role < 10 AND Wfar_role > 0
            ACCEPT Wfar_role
        END-PERFORM
        OPEN INPUT Fastronautes
        MOVE Wfar_role TO fa_role
        START Fastronautes, KEY IS = fa_role
        INVALID KEY
            DISPLAY "Aucun astronaute ne possède ce rôle !"
        NOT INVALID KEY
            MOVE 0 TO Wastro_fin
            PERFORM WITH TEST AFTER UNTIL Wastro_fin = 1
                READ Fastronautes NEXT
                AT END MOVE 1 TO Wastro_fin
                NOT AT END
                    IF fa_role = Wfar_role THEN
                        DISPLAY "#############"
                        DISPLAY "<-- ID de l'astronaute :",
" ", fa_idAstronaute, " -->"
                        DISPLAY "Nom de l'astronaute : ", fa_nom
                        DISPLAY "Prénom de l'astronaute : ", fa_prenom
                    END-IF
                END-READ
            END-PERFORM
        END-START
        CLOSE Fastronautes.

        RECHERCHE_ASTRONAUTE_PAYS.
        DISPLAY "De quel pays voulez-vous la liste des astronautes ?"
        ACCEPT Wfar_pays
        MOVE FUNCTION LOWER-CASE(Wfar_pays) TO Wfar_pays2
        OPEN INPUT Fastronautes
        MOVE Wfar_pays2 TO fa_pays
        START Fastronautes, KEY IS = fa_pays
        INVALID KEY
            DISPLAY "Aucun astronaute n'est originaire de ce pays !"
        NOT INVALID KEY
            MOVE 0 TO Wastro_fin
            PERFORM WITH TEST AFTER UNTIL Wastro_fin = 1
                READ Fastronautes NEXT
                AT END MOVE 1 TO Wastro_fin
                NOT AT END
                    IF fa_pays = Wfar_pays2 THEN
                        DISPLAY "#############"
                        DISPLAY "<-- ID de l'astronaute :",
" ", fa_idAstronaute, " -->"
                        DISPLAY "Nom de l'astronaute : ", fa_nom
                        DISPLAY "Prénom de l'astronaute : ", fa_prenom
                    END-IF
                END-READ
            END-PERFORM
        END-START
        CLOSE Fastronautes.

        RECHERCHE_ASTRONAUTE_LIEU.
        DISPLAY "De quel lieu voulez-vous retrouver les astronautes ?"
        ACCEPT Wfar_nomLieu2
        MOVE FUNCTION LOWER-CASE(Wfar_nomLieu2) TO Wfar_nomLieu
        MOVE Wfar_nomLieu TO fl_nomLieu
        OPEN INPUT Flieux
        READ Flieux
        INVALID KEY
            DISPLAY "Ce lieu n'existe pas."
        NOT INVALID KEY
            OPEN INPUT Fmissions
            MOVE fl_nomLieu TO fm_nomLieu
            START Fmissions, KEY IS = fm_nomLieu
            INVALID KEY
                DISPLAY "Aucune mission n'est assignée à ce lieu."
            NOT INVALID KEY
                MOVE 0 TO Weq_fin
                PERFORM WITH TEST AFTER UNTIL Weq_fin = 0
                    READ Fmissions NEXT
                    AT END
                        MOVE 1 TO Weq_fin
                    NOT AT END
                        IF fl_nomLieu = fm_nomLieu THEN                
                            OPEN INPUT Fequipes
                            MOVE fm_idMission TO fe_idMission
                            START Fequipes, KEY IS = fe_idMission
                            INVALID KEY
                                DISPLAY "Aucun résultat."
                            NOT INVALID KEY
                                MOVE 0 TO Wmi_fin
                                PERFORM WITH TEST AFTER UNTIL Wmi_fin = 0
                                    READ Fequipes NEXT
                                    AT END
                                        MOVE 1 TO Wmi_fin
                                    NOT AT END
         IF fm_idMission = fe_idMission THEN
            OPEN INPUT Fastronautes
            MOVE fe_idEquipe TO fa_idEquipe
            START Fastronautes, KEY IS = fa_idEquipe
            INVALID KEY
                DISPLAY "Aucun résultat."
            NOT INVALID KEY
                MOVE 0 TO Was_fin
                PERFORM WITH TEST AFTER UNTIL Was_fin = 0
                    READ Fastronautes NEXT
                    AT END
                        MOVE 1 TO Was_fin
                    NOT AT END
                        IF fa_idEquipe = fe_idEquipe THEN
                            DISPLAY "#############"
                            DISPLAY "<-- ID de l'astronaute :",
" ", fa_idAstronaute, " -->"
                            DISPLAY "Nom de l'astronaute : ", fa_nom
                           DISPLAY "Prénom de l'astronaute : ", fa_prenom
                        END-IF
                    END-READ
                END-PERFORM
            END-START
        END-IF
                                    END-READ
                                END-PERFORM
                            END-START
                        END-IF
                    END-READ
                END-PERFORM
            END-START
        END-READ
        CLOSE Fastronautes
        CLOSE Fequipes
        CLOSE Fmissions
        CLOSE Flieux. 

        RECHERCHE_ASTRONAUTE_EQUIPE.
        DISPLAY "De quelle équipe voulez-vous la liste des astronautes ?"
        ACCEPT Wfar_idEquipe
        OPEN INPUT Fastronautes
        MOVE Wfar_idEquipe TO fa_idEquipe
        START Fastronautes, KEY IS = fa_idEquipe
        INVALID KEY
            DISPLAY "Aucun astronaute n'est membre de cette équipe !"
        NOT INVALID KEY
            MOVE 0 TO Wastro_fin
            PERFORM WITH TEST AFTER UNTIL Wastro_fin = 1
                READ Fastronautes NEXT
                AT END MOVE 1 TO Wastro_fin
                NOT AT END
                    IF fa_idEquipe = Wfar_idEquipe THEN
                        DISPLAY "#############"
                        DISPLAY "<-- ID de l'astronaute :",
" ", fa_idAstronaute, " -->"
                        DISPLAY "Nom de l'astronaute : ", fa_nom
                        DISPLAY "Prénom de l'astronaute : ", fa_prenom
                    END-IF
                END-READ
            END-PERFORM
        END-START
        CLOSE Fastronautes.

        STAT_NB_ASTRONAUTES.
        OPEN INPUT Fastronautes
        MOVE 0 TO Wastro_fin
        MOVE 0 TO WS_nbAstronautes
        PERFORM WITH TEST AFTER UNTIL Wastro_fin = 1
            READ Fastronautes NEXT
            AT END
                MOVE 1 TO Wastro_fin
            NOT AT END
                ADD 1 TO WS_nbAstronautes
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbAstronautes, " astronaute(s) dans ",
"les données."
        CLOSE Fastronautes.

        STAT_NB_ASTROCHOMEURS.
        OPEN INPUT Fastronautes
        MOVE 0 TO Wastro_fin
        MOVE 0 TO WS_nbAstrochomeurs
        PERFORM WITH TEST AFTER UNTIL Wastro_fin = 1
            READ Fastronautes NEXT
            AT END
                MOVE 1 TO Wastro_fin
            NOT AT END
                IF fa_idEquipe = 0 THEN
                    ADD 1 TO WS_nbAstrochomeurs
                END-IF
            END-READ
        END-PERFORM
        DISPLAY "Il y a ", WS_nbAstrochomeurs, " astro-chômeur(s) dans ",
"les données."
        CLOSE Fastronautes.

        COLLECTION_DONNEES_ASTRO.
        MOVE 101 TO fa_idAstronaute
        MOVE "CHAUVIERE" TO fa_nom
        MOVE "Jason" TO fa_prenom
        MOVE 1 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 102 TO fa_idAstronaute
        MOVE "KARAMI" TO fa_nom
        MOVE "Yassine" TO fa_prenom
        MOVE 1 TO fa_role
        MOVE "maroc" TO fa_pays
        MOVE 61 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 103 TO fa_idAstronaute
        MOVE "NYUNTING" TO fa_nom
        MOVE "Noël" TO fa_prenom
        MOVE 1 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 104 TO fa_idAstronaute
        MOVE "GAILLON" TO fa_nom
        MOVE "Dominique" TO fa_prenom
        MOVE 2 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 105 TO fa_idAstronaute
        MOVE "MOTARD" TO fa_nom
        MOVE "Bastien" TO fa_prenom
        MOVE 3 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 106 TO fa_idAstronaute
        MOVE "DAGUISE" TO fa_nom
        MOVE "Solange" TO fa_prenom
        MOVE 4 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 107 TO fa_idAstronaute
        MOVE "JEGOUSSE" TO fa_nom
        MOVE "Camille" TO fa_prenom
        MOVE 5 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 108 TO fa_idAstronaute
        MOVE "MARKAROV" TO fa_nom
        MOVE "Souro" TO fa_prenom
        MOVE 6 TO fa_role
        MOVE "azerbaïdjan" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 109 TO fa_idAstronaute
        MOVE "CHAUVIERE" TO fa_nom
        MOVE "Nicolas" TO fa_prenom
        MOVE 7 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 110 TO fa_idAstronaute
        MOVE "RONGIER" TO fa_nom
        MOVE "Valentin" TO fa_prenom
        MOVE 8 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 111 TO fa_idAstronaute
        MOVE "CARLOS" TO fa_nom
        MOVE "Diego" TO fa_prenom
        MOVE 9 TO fa_role
        MOVE "brésil" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 112 TO fa_idAstronaute
        MOVE "TATARUSANU" TO fa_nom
        MOVE "Ciprian" TO fa_prenom
        MOVE 2 TO fa_role
        MOVE "roumanie" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 113 TO fa_idAstronaute
        MOVE "THOMASSON" TO fa_nom
        MOVE "Adrien" TO fa_prenom
        MOVE 3 TO fa_role
        MOVE "croatie" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 114 TO fa_idAstronaute
        MOVE "SALA" TO fa_nom
        MOVE "Emiliano" TO fa_prenom
        MOVE 4 TO fa_role
        MOVE "argentine" TO fa_pays
        MOVE 201 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 115 TO fa_idAstronaute
        MOVE "ALIAGAS" TO fa_nom
        MOVE "Nikos" TO fa_prenom
        MOVE 5 TO fa_role
        MOVE "grèce" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 116 TO fa_idAstronaute
        MOVE "SUAUDEAU" TO fa_nom
        MOVE "Christophe" TO fa_prenom
        MOVE 6 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 117 TO fa_idAstronaute
        MOVE "FERTIN" TO fa_nom
        MOVE "Guillaume" TO fa_prenom
        MOVE 7 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 0 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 118 TO fa_idAstronaute
        MOVE "MBAPPE" TO fa_nom
        MOVE "Kylian" TO fa_prenom
        MOVE 8 TO fa_role
        MOVE "france" TO fa_pays
        MOVE 61 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        MOVE 119 TO fa_idAstronaute
        MOVE "CAVANI" TO fa_nom
        MOVE "Edinson" TO fa_prenom
        MOVE 9 TO fa_role
        MOVE "uruguay" TO fa_pays
        MOVE 61 TO fa_idEquipe
        OPEN I-O Fastronautes
            WRITE aTampon END-WRITE
        CLOSE Fastronautes

        DISPLAY "SPACEX 2118 -- Génération de 19 astronautes ",
"effectués !".
