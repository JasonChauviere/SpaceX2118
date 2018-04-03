IDENTIFICATION DIVISION.
PROGRAM-ID. SpaceX2118.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.

SELECT Fastronautes ASSIGN TO "astronautes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fa_stat
        RECORD KEY fa_idAstronaute
        ALTERNATE RECORD KEY fa_pays WITH DUPLICATES
        ALTERNATE RECORD KEY fa_role WITH DUPLICATES
        ALTERNATE RECORD KEY fa_idEquipe WITH DUPLICATES.

SELECT Fequipes ASSIGN TO "equipes.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fe_stat
        RECORD KEY fe_idEquipe
        ALTERNATE RECORD KEY fe_idMission WITH DUPLICATES.

SELECT Fmissions ASSIGN TO "missions.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fm_stat
        RECORD KEY fm_idMission
        ALTERNATE RECORD KEY fm_nomLieu WITH DUPLICATES.

SELECT Flieux ASSIGN TO "lieux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fl_stat
        RECORD KEY fl_nomLieu
        ALTERNATE RECORD KEY fl_typeLieu WITH DUPLICATES.

SELECT Fvaisseaux ASSIGN TO "vaisseaux.dat"
        ORGANIZATION indexed
        ACCESS IS dynamic
        FILE STATUS IS fv_stat
        RECORD KEY fv_nomVaisseau
        ALTERNATE RECORD KEY fv_nomLieu WITH DUPLICATES
        ALTERNATE RECORD KEY fv_typeVaisseau WITH DUPLICATES.

DATA DIVISION.
FILE SECTION.

        FD Fastronautes.
        01 aTampon.
                02 fa_idAstronaute PIC 9(5).
                02 fa_nom PIC A(30).
                02 fa_prenom PIC A(30).
                02 fa_role PIC 9.
                02 fa_pays PIC A(30).
                02 fa_idEquipe PIC 9(5).

        FD Fequipes.
        01 eTampon.
                02 fe_idEquipe PIC 9(5).
                02 fe_nbAstronautes PIC 9(5).
                02 fe_description PIC X(50).
                02 fe_idMission PIC 9(5).

        FD Fmissions.
        01 mTampon.
                02 fm_idMission PIC 9(5).
                02 fm_nomLieu PIC X(30).
                02 fm_description PIC X(30).

        FD Flieux.
        01 lTampon.
                02 fl_nomLieu PIC X(30).
                02 fl_typeLieu PIC 9.
                02 fl_habitable PIC 9.

        FD Fvaisseaux.
        01 vTampon.
                02 fv_nomVaisseau PIC X(30).
                02 fv_typeVaisseau PIC 9.
                02 fv_capacite PIC 9(2).
                02 fv_nomLieu PIC X(30).

WORKING-STORAGE SECTION.

        77 choix PIC 9(2).
        77 choixA PIC 9(2).
        77 choixE PIC 9(2).
        77 choixM PIC 9(2).
        77 choixV PIC 9(2).
        77 choixL PIC 9(2).
        77 choixS PIC 9(2).
        77 fa_stat PIC 9(2).
        77 fe_stat PIC 9(2).
        77 fm_stat PIC 9(2).
        77 fv_stat PIC 9(2).
        77 fl_stat PIC 9(2).
        77 stoppy PIC 9.
        77 fa_idAstronaute2 PIC 9(5).
        77 fa_nom2 PIC A(30).
        77 fa_prenom2 PIC A(30).
        77 fa_pays2 PIC A(30).
        77 Wfa_idAstronaute PIC 9(5).
        77 Wverif_a PIC 9.
        77 Wechec PIC 9.
        77 Wfa_idEquipe PIC 9(5).
        77 Wfa_role2 PIC 9.
        77 Wfin PIC 9.
        77 Waj_a PIC 9.
        77 Wfa_pays PIC A(30).
        77 Wfm_idEquipe PIC 9(5).
        77 Wverif_e PIC 9.
        77 Wfmodif PIC 9.
        77 Wfm_nom PIC A(30).
        77 Wfm_prenom PIC A(30).
        77 Wfm_pays2 PIC A(30).
        77 Wfm_pays PIC A(30).
        77 WidEquipePerd PIC 9(5).
        77 Wid_astro PIC 9(5).
        77 Wfa_roleECR PIC X(30).
        77 Wfar_choix PIC 9.
        77 Wfar_role PIC 9.
        77 Wastro_fin PIC 9.
        77 Wfar_pays PIC A(30).
        77 Weq_fin PIC 9.
        77 Wmi_fin PIC 9.
        77 Was_fin PIC 9.
        77 Wfe_idEquipe PIC 9(5).
        77 Wfm_description PIC X(75).
        77 Wfm_idMission PIC 9(5).
        77 Waj_e PIC 9.
        77 Wverif_cdt PIC 9.
        77 Wfar_pays2 PIC A(30).
        77 Wfar_nomLieu PIC X(30).
        77 Wfar_nomLieu2 PIC X(30).
        77 Wmission PIC 9.
        77 Wfar_idEquipe PIC 9(5).
        77 Wfe_idCdt PIC 9(5).
        77 Wid_equipe PIC 9(5).
        77 Wverif_m PIC 9.
        77 Wverif_l PIC 9.
        77 Waj_m PIC 9.
        77 Wfm_nomLieu PIC X(30).
        77 Wfm_nomLieu2 PIC X(30).
        77 Wfm_idMissionD PIC 9(5).
        77 fe_fin PIC 9.
        77 Wfmodif_m PIC 9.
        77 Wfv_nomVaisseau PIC X(30).
        77 Wfv_typeV PIC 9.
        77 Wverif_v PIC 9.
        77 Wfv_nomLieu PIC X(30).
        77 Waj_v PIC 9.
        77 Wfv_nomVaisseau2 PIC X(30).
        77 Wfl_nomLieu PIC X(30).
        77 Wfl_nomLieu2 PIC X(30).
        77 Wfl_typeLieuECR PIC X(30).
        77 Wfl_habitableECR PIC X(30).
        77 Wl_NOTALLOW PIC 9.
        77 Waj_l PIC 9.
        77 Wfm_lieu PIC X(30).
        77 Wfm_lieu2 PIC X(30).
        77 Wid_mission PIC 9(5).
        77 Wfv_nomLieu2 PIC X(30).
        77 Wfmodif_v PIC 9.
        77 Wl_typeL PIC 9.
        77 Wl_hab PIC 9.
        77 Wm_fin PIC 9.
        77 fm_fin PIC 9.
        77 Wfmodif_l PIC 9.
        77 Wfv_typeVM PIC 9(2).
        77 fv_capacite2 PIC 9(2).
        77 LieuEquipe PIC X(30).
        77 Wfer_choix PIC 9.
        77 Wfmr_choix PIC 9.
        77 Wa_fin PIC 9.
        77 We_fin PIC 9.
        77 WS_nbAstronautes PIC 9(3).
        77 WS_nbEquipes PIC 9(3).
        77 WS_nbMissions PIC 9(3).
        77 WS_nbVaisseaux PIC 9(3).
        77 WS_nbLieux PIC 9(3).
        77 Wmiss_fin PIC 9.
        77 Wvaiss_fin PIC 9.
        77 Wlieu_fin PIC 9.
        77 WS_nbAstrochomeurs PIC 9(3).
        77 WS_nbLieuxHab PIC 9(3).
        77 Ws_nbLieuxEto PIC 9(3).
        77 Ws_nbLieuxPla PIC 9(3).
        77 Ws_nbLieuxAst PIC 9(3).
        77 Ws_nbLieuxTN PIC 9(3).
        77 WS_nbVaisseaux1 PIC 9(3).
        77 WS_nbVaisseaux2 PIC 9(3).
        77 WS_nbVaisseaux3 PIC 9(3).

PROCEDURE DIVISION.

        OPEN I-O Fastronautes
        IF fa_stat=35 THEN
                OPEN OUTPUT Fastronautes
        END-IF
        CLOSE Fastronautes

        OPEN I-O Fequipes
        IF fe_stat=35 THEN
                OPEN OUTPUT Fequipes
        END-IF
        CLOSE Fequipes
       
        OPEN I-O Fmissions
        IF fm_stat=35 THEN
                OPEN OUTPUT Fmissions
        END-IF
        CLOSE Fmissions

        OPEN I-O Fvaisseaux
        IF fv_stat=35 THEN
                OPEN OUTPUT Fvaisseaux
        END-IF
        CLOSE Fvaisseaux

        OPEN I-O Flieux
        IF fl_stat=35 THEN
                OPEN OUTPUT Flieux
        END-IF
        CLOSE Flieux
        
        PERFORM WITH TEST AFTER UNTIL choix = 0 
        PERFORM WITH TEST AFTER UNTIL choix < 8
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '                SPACEX 2118                '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le programme : 0                  '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' ASTRONAUTES : 1                           '
        DISPLAY ' ÉQUIPES : 2                               '
        DISPLAY ' MISSIONS : 3                              '
        DISPLAY ' VAISSEAUX : 4                             '
        DISPLAY ' LIEUX : 5                                 '
        DISPLAY ' STATISTIQUES : 6                          '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' SPACEX 2118 - IMPORTER LA SUPER-BASE : 7  '
        DISPLAY '       (disponible une seule fois)         '
        DISPLAY '  ---------------------------------------  '        
        DISPLAY ' '
        ACCEPT choix
        EVALUATE choix
        WHEN 1 PERFORM MENU_ASTRONAUTES
        WHEN 2 PERFORM MENU_EQUIPES
        WHEN 3 PERFORM MENU_MISSIONS
        WHEN 4 PERFORM MENU_VAISSEAUX
        WHEN 5 PERFORM MENU_LIEUX
        WHEN 6 PERFORM MENU_STAT
        WHEN 7 PERFORM SUPER_IMPORT
        END-EVALUATE
        END-PERFORM
        END-PERFORM
        STOP RUN.

        MENU_ASTRONAUTES.
        PERFORM WITH TEST AFTER UNTIL choixA = 0 
        PERFORM WITH TEST AFTER UNTIL choixA < 6
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '          SPACEX 2118 - ASTRONAUTES        '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le menu : 0                       '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter un astronaute : 1                 '
        DISPLAY ' Modifier un astronaute : 2                '
        DISPLAY ' Supprimer un astronaute : 3               '
        DISPLAY ' Afficher un astronaute : 4                '
        DISPLAY ' Rechercher un ou des astronaute(s) : 5    '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' '
        ACCEPT choixA
        EVALUATE choixA
        WHEN 1 PERFORM AJOUT_ASTRONAUTE
        WHEN 2 PERFORM MODIFIER_ASTRONAUTE
        WHEN 3 PERFORM SUPPRIMER_ASTRONAUTE
        WHEN 4 PERFORM AFFICHER_ASTRONAUTE
        WHEN 5 PERFORM RECHERCHE_ASTRONAUTE
        END-EVALUATE
        END-PERFORM
        END-PERFORM.

        MENU_EQUIPES.
        PERFORM WITH TEST AFTER UNTIL choixE = 0 
        PERFORM WITH TEST AFTER UNTIL choixE < 6
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '            SPACEX 2118 - EQUIPES          '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le menu : 0                       '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter une équipe : 1                    '
        DISPLAY ' Modifier une équipe : 2                   '
        DISPLAY ' Supprimer une équipe : 3                  '
        DISPLAY ' Afficher une équipe : 4                   '
        DISPLAY ' Rechercher une ou des équipe(s) : 5       '
        DISPLAY '  ---------------------------------------  ' 
        DISPLAY ' '
        ACCEPT choixE
        EVALUATE choixE
        WHEN 1 PERFORM AJOUT_EQUIPE
        WHEN 2 PERFORM MODIFIER_EQUIPE
        WHEN 3 PERFORM SUPPRIMER_EQUIPE
        WHEN 4 PERFORM AFFICHER_EQUIPE
        WHEN 5 PERFORM RECHERCHE_EQUIPE
        END-EVALUATE
        END-PERFORM
        END-PERFORM.

        MENU_MISSIONS.
        PERFORM WITH TEST AFTER UNTIL choixM = 0 
        PERFORM WITH TEST AFTER UNTIL choixM < 6
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '           SPACEX 2118 - MISSIONS          '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le menu : 0                       '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter une mission : 1                   '
        DISPLAY ' Modifier une mission : 2                  '
        DISPLAY ' Supprimer une mission : 3                 '
        DISPLAY ' Afficher une mission : 4                  '
        DISPLAY ' Rechercher une ou des mission(s) : 5      '
        DISPLAY '  ---------------------------------------  ' 
        DISPLAY ' '
        ACCEPT choixM
        EVALUATE choixM
        WHEN 1 PERFORM AJOUT_MISSION
        WHEN 2 PERFORM MODIFIER_MISSION
        WHEN 3 PERFORM SUPPRIMER_MISSION
        WHEN 4 PERFORM AFFICHER_MISSION
        WHEN 5 PERFORM RECHERCHE_MISSION
        END-EVALUATE
        END-PERFORM
        END-PERFORM.

        MENU_VAISSEAUX.
        PERFORM WITH TEST AFTER UNTIL choixV = 0 
        PERFORM WITH TEST AFTER UNTIL choixV < 5
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '           SPACEX 2118 - VAISSEAUX         '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le menu : 0                       '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter un vaisseau : 1                   '
        DISPLAY ' Modifier un vaisseau : 2                  '
        DISPLAY ' Supprimer un vaisseau : 3                 '
        DISPLAY ' Afficher un vaisseau : 4                  '
        DISPLAY '  ---------------------------------------  '       
        DISPLAY ' '
        ACCEPT choixV
        EVALUATE choixV
        WHEN 1 PERFORM AJOUT_VAISSEAU
        WHEN 2 PERFORM MODIFIER_VAISSEAU
        WHEN 3 PERFORM SUPPRIMER_VAISSEAU
        WHEN 4 PERFORM AFFICHER_VAISSEAU
        END-EVALUATE
        END-PERFORM
        END-PERFORM.

        MENU_LIEUX.
        PERFORM WITH TEST AFTER UNTIL choixL = 0 
        PERFORM WITH TEST AFTER UNTIL choixL < 6
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '            SPACEX 2118 - LIEUX            '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Quitter le menu : 0                       '
        DISPLAY '  ---------------------------------------  '
        DISPLAY ' Ajouter un lieu : 1                       '
        DISPLAY ' Modifier un lieu : 2                      '
        DISPLAY ' Supprimer un lieu : 3                     '
        DISPLAY ' Afficher un lieu : 4                      '
        DISPLAY '  ---------------------------------------  '  
        DISPLAY ' '
        ACCEPT choixL
        EVALUATE choixL
        WHEN 1 PERFORM AJOUT_LIEU
        WHEN 2 PERFORM MODIFIER_LIEU
        WHEN 3 PERFORM SUPPRIMER_LIEU
        WHEN 4 PERFORM AFFICHER_LIEU
        END-EVALUATE
        END-PERFORM
        END-PERFORM.

        MENU_STAT.
        DISPLAY ' '
        DISPLAY '  ---------------------------------------  '
        DISPLAY '         SPACEX 2118 - STATISTIQUES        '
        DISPLAY '  ---------------------------------------  '
        PERFORM STAT_NB_ASTRONAUTES
        PERFORM STAT_NB_ASTROCHOMEURS
        PERFORM STAT_NB_EQUIPES
        PERFORM STAT_NB_MISSIONS
        PERFORM STAT_NB_VAISSEAUX
        PERFORM STAT_NB_VAISSEAUX_1
        PERFORM STAT_NB_VAISSEAUX_2
        PERFORM STAT_NB_VAISSEAUX_3
        PERFORM STAT_NB_LIEUX
        PERFORM STAT_NB_LIEUX_HAB
        PERFORM STAT_NB_ETOILES
        PERFORM STAT_NB_PLANETES
        PERFORM STAT_NB_ASTEROIDES
        PERFORM STAT_NB_TROUS_NOIRS.  

        SUPER_IMPORT.
        IF stoppy = 0 THEN
        PERFORM COLLECTION_DONNEES_ASTRO
        PERFORM COLLECTION_DONNEES_EQUIPE
        PERFORM COLLECTION_DONNEES_MISSION
        PERFORM COLLECTION_DONNEES_VAISSEAU
        PERFORM COLLECTION_DONNEES_LIEU
        MOVE 1 TO stoppy
        END-IF.

COPY astronautes.
COPY equipes.
COPY missions.
COPY vaisseaux.
COPY lieux.
