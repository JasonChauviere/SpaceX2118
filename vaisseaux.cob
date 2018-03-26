       AJOUT_VAISSEAU.
       OPEN INPUT Fvaisseaux
       DISPLAY "Nom vaisseau?"
       ACCEPT Wfv_nomVaisseau
       DISPLAY "Quel type?"
       MOVE 4 TO opt
       PERFORM WITH TEST AFTER UNTIL Wopt=1 OR Wopt = 2 OR Wopt = 3
       	PERFORM WITH TEST AFTER UNTIL Wopt<4
         		DISPLAY ' 1) Galère '
         		DISPLAY ' 2) Frigate '
         		DISPLAY ' 3) Dreadnought '
       
         	      ACCEPT Wopt
         		EVALUATE Wopt
          		 WHEN 1 PERFORM MOVE 1 TO Wfv_typeVaisseau
              	 WHEN 2 PERFORM MOVE 2 TO Wfv_typeVaisseau
          		 WHEN 3 PERFORM MOVE 3 TO Wfv_typeVaisseau
          		END-EVALUATE
       	END-PERFORM
       END-PERFORM
       
       MOVE Wfv_nomVaisseau TO fv_nomVaisseau
       MOVE Wfv_typeVaisseau TO fv_typeVaisseau	
       READ Fvaisseaux
       INVALID KEY 
       	MOVE 0 TO Wverif_a
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       	DISPLAY "ERREUR ! Vaisseau déjà attribué !"
       END-READ
       CLOSE Fvaisseaux
       
       IF Wverif_a = 0 THEN
       	IF fv_typeVaisseau = 1 THEN
       		MOVE 5 TO fv_capacite
       	ELSE IF fv_typeVaisseau = 2 THEN
       		MOVE 15 TO fv_capacite
       	ELSE IF fv_typeVaisseau = 3 THEN
       		MOVE 30 TO fv_capacite
       	END-IF
       	
       	
       	OPEN INPUT Flieux
       	DISPLAY "Base du vaisseau ?"
       	ACCEPT Wfv_nomLieu
       	MOVE Wfv_nomLieu TO fl_nomLieu
       	READ Flieux
       	INVALID KEY
       		MOVE 0 to Wverif_a2
       		DISPLAY "ERREUR ! Lieu inexistant !"
       	NOT INVALID KEY
       		MOVE 1 to Wverif_a2
       	END-READ
       	CLOSE Flieux
       	
       	IF Wverif_a2 = 1 THEN
       		OPEN I-O Fvaisseaux
       		WRITE vTampon END-WRITE
       		DISPLAY "Vaisseau ajouté !"
       		CLOSE Fvaisseaux
       	END-IF
       END-IF.
       
       SUPPRIMER_VAISSEAU.
       OPEN INPUT Fvaisseaux
       DISPLAY "Nom vaisseau?"
       ACCEPT Wfv_nomVaisseau
       DISPLAY "Quel type?"
       MOVE 4 TO opt
       PERFORM WITH TEST AFTER UNTIL Wopt=1 OR Wopt = 2 OR Wopt = 3
        	 PERFORM WITH TEST AFTER UNTIL Wopt<4
         		DISPLAY ' 1) Galère '
         		DISPLAY ' 2) Frigate '
         		DISPLAY ' 3) Dreadnought '
       
         	      ACCEPT Wopt
         		EVALUATE Wopt
          		 WHEN 1 PERFORM MOVE 1 TO Wfv_typeVaisseau
              	 WHEN 2 PERFORM MOVE 2 TO Wfv_typeVaisseau
          		 WHEN 3 PERFORM MOVE 3 TO Wfv_typeVaisseau
          		END-EVALUATE
             END-PERFORM
       END-PERFORM
       
        MOVE Wfv_nomVaisseau TO fv_nomVaisseau
        MOVE Wfv_typeVaisseau TO fv_typeVaisseau	
        READ Fvaisseaux
        INVALID KEY 
        	MOVE 0 TO Wverif_a
        	DISPLAY "ERREUR ! Vaisseau n'existe pas !"
        NOT INVALID KEY
       	MOVE 1 TO Wverif_a       	
        END-READ
        CLOSE Fvaisseaux
       
        IF Wverif_a = 1 THEN
        	OPEN I-O Fvaisseaux
        	
        	READ Fvaisseaux KEY IS fv_cle
        	INVALID KEY
        		DISPLAY "ERREUR ! Vaisseau n'existe pas !"
        	NOT INVALID KEY
        		DELETE Fvaisseaux RECORD
        		DISPLAY "Vaisseau supprimé !"
        	END-READ
        	CLOSE Fvaisseaux
        END-IF.
       
       CHANGER-LIEU.
       OPEN INPUT Fvaisseaux
     	 DISPLAY "Nom vaisseau?"
       ACCEPT Wfv_nomVaisseau
       DISPLAY "Quel type?"
       MOVE 4 TO opt
       PERFORM WITH TEST AFTER UNTIL Wopt=1 OR Wopt = 2 OR Wopt = 3
       	 PERFORM WITH TEST AFTER UNTIL Wopt<4
         		DISPLAY ' 1) Galère '
         		DISPLAY ' 2) Frigate '
         		DISPLAY ' 3) Dreadnought '
       
         	      ACCEPT Wopt
         		EVALUATE Wopt
          		 WHEN 1 PERFORM MOVE 1 TO Wfv_typeVaisseau
              	 WHEN 2 PERFORM MOVE 2 TO Wfv_typeVaisseau
          		 WHEN 3 PERFORM MOVE 3 TO Wfv_typeVaisseau
          		END-EVALUATE
             END-PERFORM
       END-PERFORM
       
       MOVE Wfv_nomVaisseau TO fv_nomVaisseau
       MOVE Wfv_typeVaisseau TO fv_typeVaisseau	
       READ Fvaisseaux
       INVALID KEY 
        	MOVE 0 TO Wverif_a
        	DISPLAY "ERREUR ! Vaisseau n'existe pas !"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a       	
       END-READ
       CLOSE Fvaisseaux
       
       IF Wverif_a = 1 THEN
       	OPEN INPUT Flieux
       	DISPLAY "Nouvelle base du vaisseau ?"
       	ACCEPT Wfv_nomLieu
       	MOVE Wfv_nomLieu TO fl_nomLieu
       	READ Flieux
       	INVALID KEY
       		MOVE 0 to Wverif_a2
       		DISPLAY "ERREUR ! Lieu inexistant !"
       	NOT INVALID KEY
       		MOVE 1 to Wverif_a2
       	END-READ
       	CLOSE Flieux
		
	      IF Wverif_a2 = 1 THEN
	      	OPEN I-O Fvaisseaux
	      	READ Fvaisseaux KEY IS fv_cle
        		INVALID KEY
        			DISPLAY "ERREUR ! Vaisseau n'existe pas !"
        		NOT INVALID KEY
        			REWRITE Fvaisseaux 
        			DISPLAY "Lieu changé !"
        		END-READ
        		CLOSE Fvaisseaux
        	END-IF       
       END-IF. 
       
       
       
