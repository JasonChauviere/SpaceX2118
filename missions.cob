       AJOUT_MISSION.
       OPEN INPUT Fmissions

       
       OPEN INPUT Flieux
      	DISPLAY 'Lieu de la mission ?'
       	ACCEPT Wfm_nomLieu
       	MOVE Wfm_nomLieu TO fm_nomLieu
       	READ Flieux
       	INVALID KEY
       		MOVE 0 to Wverif_a2
       		DISPLAY "ERREUR ! Lieu inexistant !"
       	NOT INVALID KEY
       		MOVE 1 to Wverif_a2
       	END-READ
       CLOSE Flieux 
       
       IF Wverif_a2 = 1 THEN
       
	       DISPLAY 'Description ?'
	       ACCEPT Wfm_description
       
	       MOVE 0 TO fin
	       MOVE 0 TO Wfm_idMax
       
	       PERFORM WITH TEST AFTER UNTIL fin = 1
	       	READ Fmissions NEXT
	       	AT END 
	       		MOVE 1 TO fin
	       		IF Wfm_idMax = 0 THEN
	       			MOVE 1 TO Wfm_idMax
	       		ELSE
	       			ADD 1 TO Wfm_idMax
	       		END-IF 
	       	NOT AT END
	       		ADD 1 TO Wfm_idMax
	       	END-READ       
	       END-PERFORM
       
	       CLOSE Fmissions
	       MOVE Wfm_idMax TO fm_idMission
	       MOVE Wfm_nomLieu TO fm_nomLieu
	       MOVE Wfm_description TO fm_description
       
	       OPEN OUTPUT Fmissions 
	       	WRITE mTampon
	       	END-WRITE
	       	DISPLAY 'Mission ajoutée'
	       CLOSE Fmissions
       END-IF.
       
       SUPPRIMER_MISSION.
       OPEN INPUT Fmissions
       DISPLAY 'Identifiant de la mission ?'
       ACCEPT Wfm_idMax
       MOVE Wfm_idMax TO fm_idMission
       READ Fmissions
       INVALID KEY
       	MOVE 0 TO Wverif_a
       	DISPLAY "ERREUR ! Mission n'existe pas !"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       END-READ
       CLOSE Fmissions
       
       IF Wverif_a = 1 THEN
       	OPEN I-O Fmissions
       	READ Fmissions KEY IS fm_idMission
       	INVALID KEY
       		DISPLAY "ERREUR ! Mission n'existe pas !"
       	NOT INVALID KEY
       		DELETE Fmissions RECORD
       		DISPLAY "Missions supprimée !"
       	END-READ
       	CLOSE Fmissions
       END-IF.
       	
       MODIFIER_MISSION.
       OPEN INPUT Fmissions
       DISPLAY 'Identifiant de la mission ?'
       ACCEPT Wfm_idMax
       MOVE Wfm_idMax TO fm_idMission
       READ Fmission KEY IS fm_idMission
       INVALID KEY
       	MOVE 0 TO Wverif_a
       	DISPLAY "ERREUR ! La mission n'existe pas"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       END-READ
       CLOSE Fmissions
       
       IF Wverif_a = 1 THEN
    	
	      DISPLAY 'Que voulez vous modifier?'
	      MOVE 4 TO Wopt
	      PERFORM WITH TEST AFTER UNTIL Wopt=1 OR Wopt = 2 OR Wopt = 3
	      	PERFORM WITH TEST AFTER UNTIL Wopt<4
	      		DISPLAY ' 1) Lieu '
	         		DISPLAY ' 2) Description '
	         		DISPLAY ' 3) Les Deux '
       
	         	      ACCEPT Wopt
	      	END-PERFORM
	      END-PERFORM
       
	      IF Wopt = 1 THEN
	      	OPEN INPUT Flieux
      		DISPLAY 'Lieu de la mission ?'
       		ACCEPT Wfm_nomLieu
       		MOVE Wfm_nomLieu TO fl_nomLieu
       		READ Flieux
       		INVALID KEY
       			MOVE 0 to Wverif_a2
       			DISPLAY "ERREUR ! Lieu inexistant !"
       		NOT INVALID KEY
       			MOVE 1 to Wverif_a2
       			MOVE Wfm_nomLieu TO fm_nomLieu 
       		END-READ
       		CLOSE Flieux 
	      	
	      ELSE IF Wopt = 2 THEN
	       	DISPLAY "Nouvelle description ?"
	       	ACCEPT Wfm_description
	       	MOVE Wfm_description TO fm_description
	       	MOVE 1 to Wverif_a2
	      ELSE

	      	OPEN INPUT Flieux
      		DISPLAY 'Lieu de la mission ?'
       		ACCEPT Wfm_nomLieu
       		MOVE Wfm_nomLieu TO fl_nomLieu
       		READ Flieux
       		INVALID KEY
       			MOVE 0 to Wverif_a2
       			DISPLAY "ERREUR ! Lieu inexistant !"
       		NOT INVALID KEY
       			MOVE 1 to Wverif_a2
       			MOVE Wfm_nomLieu TO fm_nomLieu
       		END-READ
       		CLOSE Flieux 
	      	
	      	DISPLAY "Nouvelle description ?"
	       	ACCEPT Wfm_description
	      END-IF
	      
	      IF Wverif_a2 = 1 THEN
	      	OPEN I-O Fmissions
	      	READ Fmissions KEY IS fm_idMission
	      	INVALID KEY
	      		DISPLAY "ERREUR ! La mission n'existe pas !"
	      	NOT INVALID KEY
	      		REWRITE Fmissions
	      		DISPLAY "Mission modifiée !" 
	      	END-READ
	      	CLOSE Fmissions
	      END-IF	      
       END-IF.  
       
       RECHERCHE_VAISSEAU.
       MOVE 0 TO compteurEquipe
       MOVE 600 TO shipSize
       DISPLAY 'Identifiant de la mission ?'
       ACCEPT Wfm_idMax
       OPEN INPUT Fmissions
       MOVE Wfm_idMax TO fm_idMission
       READ Fmissions 
       INVALID KEY 
       	MOVE 0 TO Wverif_a
       	DISPLAY "ERREUR ! La mission n'existe pas !"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       	MOVE fm_nomLieu TO Wfm_nomLieu
       END-READ
       CLOSE Fmissions
       
       IF Wverif_a = 1 THEN
       	OPEN INPUT Fequipes
       	MOVE Wfm_idMax TO fe_idMission
       	START Fequipes
       	INVALID KEY
       		DISPLAY "ERREUR ! Mission n'existe pas !"
       	NOT INVALID KEY
       		PERFORM WITH TEST AFTER UNTIL Wverif_a = 0
       		READ Fequipes NEXT
       		AT END
       			MOVE 0 TO Wverif_a
       		NOT AT END
       			ADD 1 TO compteurEquipe
       		END-READ
       	END-START       	
       	CLOSE Fequipes
       	
       	OPEN INPUT Fvaisseaux
       	MOVE Wfm_nomLieu TO fv_nomLieu
       	START Fvaisseaux
       	INVALID KEY
       		DISPLAY "ERREUR ! Lieu n'existe pas !"
       	NOT INVALID KEY
       		PERFORM WITH TEST AFTER UNTIL Wverif_a = 1
       		READ Fvaisseaux NEXT
       		AT END
       			MOVE 1 TO Wverif_a
       		NOT AT END
       			IF shipSize >= fv_capacite THEN
       				IF fv_capacite >= compteurEquipe THEN
       				MOVE fv_capacite TO shipSize
       				MOVE fv_nomVaisseau TO Wfv_nomVaisseau
       				MOVE fv_typeVaisseau TO Wfv_typeVaisseau
       				END-IF
       			END-IF       		
       		END-READ
       	END-START       	
       	CLOSE Fvaisseaux
       	DISPLAY "Le nom du vaisseau est : ", Wfv_nomVaisseau
       	DISPLAY "Type : ", Wfv_typeVaisseau
       	DISPLAY "Lieu : ", Wfm_nomLieu
       	DISPLAY "Capacité : ", shipSize       	
       END-IF.
       
       RECHERCHE_VOISINS.
       DISPLAY 'Identifiant de la mission ?'
       ACCEPT Wfm_idMax
       OPEN INPUT Fmissions
       MOVE Wfm_idMax TO fm_idMission
       READ Fmissions 
       INVALID KEY 
       	MOVE 0 TO Wverif_a
       	DISPLAY "ERREUR ! La mission n'existe pas !"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       	MOVE fm_nomLieu TO Wfm_nomLieu
       END-READ
       CLOSE Fmissions
       
       IF Wverif_a = 1 THEN
	      OPEN INPUT Fequipes
       	MOVE Wfm_idMax TO fe_idMission
       	START Fequipes
       	INVALID KEY
       		DISPLAY "ERREUR ! Mission n'existe pas !"
       	NOT INVALID KEY
       		PERFORM WITH TEST AFTER UNTIL Wverif_a = 0
       		READ Fequipes NEXT
       		AT END
       			MOVE 0 TO Wverif_a
       		NOT AT END
       			DISPLAY "Id Equipe : ", fe_idEquipe
       			DISPLAY "Description : ", fe_description
       		END-READ
       	END-START       	
       	CLOSE Fequipes       
       END-IF.
       
       RECHERCHE_ASTRONAUTES.
       DISPLAY 'Identifiant de la mission ?'
       ACCEPT Wfm_idMax
       OPEN INPUT Fmissions
       MOVE Wfm_idMax TO fm_idMission
       READ Fmissions 
       INVALID KEY 
       	MOVE 0 TO Wverif_a
       	DISPLAY "ERREUR ! La mission n'existe pas !"
       NOT INVALID KEY
       	MOVE 1 TO Wverif_a
       	MOVE fm_nomLieu TO Wfm_nomLieu
       END-READ
       CLOSE Fmissions     
       
       IF Wverif_a = 1 THEN
	      OPEN INPUT Fequipes
       	MOVE Wfm_idMax TO fe_idMission
       	START Fequipes
       	INVALID KEY
       		DISPLAY "ERREUR ! Mission n'existe pas !"
       	NOT INVALID KEY
       		PERFORM WITH TEST AFTER UNTIL Wverif_a = 0
       		READ Fequipes NEXT
       		AT END
       			MOVE 0 TO Wverif_a
       		NOT AT END
       			IF Wfm_idMax = fe_idMission THEN
       				MOVE 0 TO Wverif_a
       				MOVE fe_idEquipe TO wfe_idEquipe
       			END-IF
       		END-READ
       	END-START       	
       	CLOSE Fequipes
       	
       	OPEN INPUT Fastronautes
       	MOVE Wfe_idEquipe TO fa_idEquipe
       	START Fastronautes
       	INVALID KEY
       		DISPLAY "ERREUR ! Equipe n'existe pas !"
       	NOT INVALID KEY
       		PERFORM WITH TEST AFTER UNTIL Wverif_a = 1
       		READ Fastronautes NEXT
       		AT END
       			MOVE 1 TO Wverif_a
       		NOT AT END
       			DISPLAY "Id Astronaute : ", fa_idAstronaute
       			DISPLAY "Nom : ", fa_nom
       			DISPLAY "Prenom : ", fa_prenom
       		END-READ
       	END-START       	
       	CLOSE Fastronautes    
       END-IF.
       
