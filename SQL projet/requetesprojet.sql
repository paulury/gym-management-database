USE salle_sport;

-- 1 : REQUÊTES AVEC SOUS-REQUÊTES

-- Requête 1 :
-- Afficher les membres qui n'ont jamais réservé de cours
SELECT nom, prenom, email
FROM Membre
WHERE id_membre NOT IN (
    SELECT id_membre
    FROM Reservation
);

-- Requête 2 :
-- Afficher les cours dont la capacité est supérieure
-- à la capacité moyenne des cours
SELECT nom_cours, capacite_max
FROM Cours
WHERE capacite_max > (
    SELECT AVG(capacite_max)
    FROM Cours
);

-- 2 : REQUÊTE ENSEMBLISTE

-- Requête 3 :
-- Lister les membres et les coachs sans doublons
SELECT nom, prenom
FROM Membre
UNION
SELECT nom, prenom
FROM Coach;

-- 3 : JOINTURES SQL1 (SYNTAXE ANCIENNE)

-- Requête 4 :
-- Afficher les réservations avec le membre et le cours
SELECT M.nom, M.prenom, C.nom_cours, R.date_reservation
FROM Membre M, Cours C, Reservation R
WHERE M.id_membre = R.id_membre
AND C.id_cours = R.id_cours;

-- Requête 5 :
-- Afficher les cours avec leur salle
SELECT C.nom_cours, S.nom_salle, S.localisation
FROM Cours C, Salle S
WHERE C.id_salle = S.id_salle;

-- 4 : JOINTURES SQL2 (JOIN ... ON)

-- Requête 6 :
-- Afficher les membres avec leurs adhésions
SELECT m.nom, m.prenom, a.date_debut, a.statut
FROM Membre m
INNER JOIN Adhesion a ON m.id_membre = a.id_membre;

-- Requête 7 :
-- Afficher les cours avec le coach associé
SELECT c.nom_cours, co.nom, co.specialite
FROM Cours c
INNER JOIN Coach co ON c.id_coach = co.id_coach;

-- 5 : LEFT JOIN / RIGHT JOIN

-- Requête 8 (LEFT JOIN) :
-- Afficher tous les membres même sans réservation
SELECT m.nom, m.prenom, r.id_reservation
FROM Membre m
LEFT JOIN Reservation r ON m.id_membre = r.id_membre;

-- Requête 9 (RIGHT JOIN) :
-- Afficher toutes les adhésions même sans membre
SELECT a.id_adhesion, a.statut, m.nom
FROM Membre m
RIGHT JOIN Adhesion a ON m.id_membre = a.id_membre;

-- 6 : FONCTIONS D’AGRÉGATION

-- Requête 10 :
-- Compter le nombre total de cours
SELECT COUNT(*) AS nombre_cours
FROM Cours;

-- Requête 11 :
-- Calculer la capacité moyenne des salles
SELECT AVG(capacite) AS capacite_moyenne
FROM Salle;

-- Requête 12 :
-- Calculer le nombre total de réservations
SELECT SUM(1) AS total_reservations
FROM Reservation;

-- Requête 13 :
-- Trouver la date de début la plus ancienne
SELECT MIN(date_debut) AS premiere_adhesion
FROM Adhesion;

-- Requête 14 :
-- Trouver la plus grande capacité de salle
SELECT MAX(capacite) AS capacite_max_salle
FROM Salle;

-- Requête 15 :
-- Compter le nombre de coachs distincts
SELECT COUNT(DISTINCT id_coach) AS nombre_coachs
FROM Cours;
