CREATE DATABASE salle_sport;
USE salle_sport;

CREATE TABLE Membre (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    adresse VARCHAR(100),
    telephone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_inscription DATE DEFAULT (CURRENT_DATE),
    statut ENUM('En attente', 'Validé', 'Suspendu') DEFAULT 'En attente',
    CHECK (CHAR_LENGTH(telephone) >= 8)
);


CREATE TABLE Coach (
    id_coach INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    specialite VARCHAR(50),
    telephone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);


CREATE TABLE Salle (
    id_salle INT AUTO_INCREMENT PRIMARY KEY,
    nom_salle VARCHAR(50) NOT NULL,
    capacite INT CHECK (capacite BETWEEN 5 AND 100),
    localisation VARCHAR(100)
);


CREATE TABLE Cours (
    id_cours INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(50) NOT NULL,
    horaire DATETIME NOT NULL,
    capacite_max INT CHECK (capacite_max BETWEEN 5 AND 50),
    id_coach INT,
    id_salle INT,
    FOREIGN KEY (id_coach) REFERENCES Coach(id_coach),
    FOREIGN KEY (id_salle) REFERENCES Salle(id_salle)
);


CREATE TABLE Adhesion (
    id_adhesion INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    statut ENUM('Active', 'Expirée', 'Suspendue') DEFAULT 'Active',
    FOREIGN KEY (id_membre) REFERENCES Membre(id_membre),
    CHECK (date_fin > date_debut)
);


CREATE TABLE Reservation (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT NOT NULL,
    id_cours INT NOT NULL,
    date_reservation DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_membre) REFERENCES Membre(id_membre),
    FOREIGN KEY (id_cours) REFERENCES Cours(id_cours),
    CONSTRAINT unique_reservation UNIQUE (id_membre, id_cours)
);


CREATE TABLE Administrateur (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    role ENUM('SuperAdmin', 'Employe') DEFAULT 'Employe',
    email VARCHAR(100) UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL
);


CREATE TABLE Utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(50) UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    type_compte ENUM('membre', 'coach', 'admin')
);

-- =====================
-- PEUPLEMENT ORIGINAL ET UNIQUE
-- =====================

-- COACHS
INSERT INTO Coach (nom, prenom, specialite, telephone, email)
VALUES
('Benali', 'Sofia', 'Pilates', '0698456711', 'sofia.benali@fitcenter.com'),
('Moreau', 'Nicolas', 'CrossFit', '0674231988', 'nicolas.moreau@fitcenter.com'),
('Kone', 'Sarah', 'Zumba', '0655123499', 'sarah.kone@fitcenter.com'),
('Andreani', 'Marc', 'Boxe', '0667421185', 'marc.andreani@fitcenter.com');

-- SALLES
INSERT INTO Salle (nom_salle, capacite, localisation)
VALUES
('Studio Énergie', 35, 'Bâtiment A - Rez-de-chaussée'),
('Salle Horizon', 25, 'Bâtiment B - 1er étage'),
('Espace Performance', 45, 'Bâtiment C - Sous-sol'),
('Zone Zen', 15, 'Bâtiment A - 2e étage');

-- MEMBRES
INSERT INTO Membre (nom, prenom, adresse, telephone, email, statut)
VALUES
('Lemoine', 'Clara', '42 avenue des Peupliers', '0619473821', 'clara.lemoine@mail.com', 'Validé'),
('Garcia', 'Ethan', '8 rue du Moulin Vert', '0628954736', 'ethan.garcia@mail.com', 'Validé'),
('Chevalier', 'Noa', '15 boulevard Gambetta', '0634718295', 'noa.chevalier@mail.com', 'En attente'),
('Bernard', 'Inès', '7 allée du Parc', '0645892710', 'ines.bernard@mail.com', 'Suspendu'),
('Ali', 'Rayan', '3 rue des Sports', '0652184739', 'rayan.ali@mail.com', 'Validé');

-- COURS
INSERT INTO Cours (nom_cours, horaire, capacite_max, id_coach, id_salle)
VALUES
('Pilates matin', '2025-11-10 08:30:00', 20, 1, 4),
('CrossFit avancé', '2025-11-10 18:00:00', 15, 2, 3),
('Zumba fiesta', '2025-11-11 17:00:00', 25, 3, 2),
('Boxe cardio', '2025-11-12 19:30:00', 12, 4, 1),
('Stretching relax', '2025-11-13 09:00:00', 18, 1, 4);

-- ADHÉSIONS
INSERT INTO Adhesion (id_membre, date_debut, date_fin, statut)
VALUES
(1, '2025-02-01', '2026-01-31', 'Active'),
(2, '2025-03-15', '2026-03-14', 'Active'),
(3, '2025-05-01', '2025-11-01', 'Expirée'),
(4, '2025-01-01', '2025-12-31', 'Suspendue'),
(5, '2025-07-01', '2026-06-30', 'Active');

-- RÉSERVATIONS
INSERT INTO Reservation (id_membre, id_cours)
VALUES
(1, 1),
(1, 5),
(2, 2),
(2, 4),
(3, 3),
(5, 1),
(5, 2),
(5, 3);

-- ADMINISTRATEURS
INSERT INTO Administrateur (nom, role, email, mot_de_passe)
VALUES
('Lambert', 'SuperAdmin', 'admin.general@fitcenter.com', 'SuperSecure123!'),
('Rossi', 'Employe', 'gestion.rossi@fitcenter.com', 'Gestion@2025');

-- UTILISATEURS
INSERT INTO Utilisateur (nom_utilisateur, mot_de_passe, type_compte)
VALUES
('clara_l', 'claraPwd2025', 'membre'),
('ethan_g', 'ethan2025!', 'membre'),
('sarah_k', 'zumbaPower', 'coach'),
('marc_a', 'boxingKing', 'coach'),
('admin_l', 'rootAdmin!', 'admin'),
('rossi_g', 'gestionSimple', 'admin');
