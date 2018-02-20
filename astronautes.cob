        VERIF_ASTRONAUTE.
        OPEN INPUT Fastronautes        
        MOVE Wfa_idAstro TO fa_idAstro
        READ Fastronautes
        INVALID KEY
              MOVE 0 TO Wverif_a
        NOT INVALID KEY
              MOVE 1 TO Wverif_a
              DISPLAY "ERREUR ! Identifiant déja attribué !"
        END-READ
        CLOSE Fastronautes.         

        AJOUT_ASTRONAUTE.
        PERFORM WITH TEST AFTER UNTIL Waj_a = 0
              DISPLAY ' '
              DISPLAY "Identifiant de l'astronaute ?"
              ACCEPT Wfa_idAstro              
              PERFORM VERIF_ASTRONAUTE
              IF Wverif_a = 0 THEN
                    MOVE Wfa_idAstro TO fa_idAstro
                    DISPLAY "Nom de l'astronaute ?"
                    ACCEPT fa_nom
                    DISPLAY "Prénom de l'astronaute ?"
                    ACCEPT fa_prenom
                    DISPLAY "Pays de l'astronaute ?"
                    ACCEPT fa_pays
                    DISPLAY "Rôle de l'astronaute ?"
                    DISPLAY "(énumération des rôles)"
                    PERFORM WITH TEST AFTER UNTIL Wfa_role2 = "a" OR
                                                  Wfa_role2 = "b" OR
                                                  Wfa_role2 = "c" OR
                                                  Wfa_role2 = "d"
                        ACCEPT Wfa_role
                        MOVE FUNCTION LOWER-CASE(Wfa_role) TO Wfa_role2
                    END-PERFORM
                    MOVE Wfa_role2 TO fa_role
                    DISPLAY "Pays de l'astronaute ?"
                    ACCEPT fa_pays
                    OPEN I-O Fastronautes            
                    WRITE astroTampon END-WRITE
                    CLOSE Fastronautes              
              END-IF
              PERFORM WITH TEST AFTER UNTIL Waj_a = 0 OR Waj_a = 1
                    DISPLAY ' '
                    DISPLAY 'Autres astronautes à ajouter ? (0 ou 1)'
                        ACCEPT Waj_a
              END-PERFORM
        END-PERFORM.
