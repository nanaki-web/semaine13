-- Création de la table Erreur
use wazaaimmogroup;
DROP Table IF EXISTS Erreur;
CREATE TABLE Erreur 
(
    id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    erreur VARCHAR(255) UNIQUE
);
-- Insertion de l'erreur qui nous intéresse
INSERT INTO Erreur (erreur) VALUES ('Erreur : date_dernier_contact doit être >= à date_debut_reservation.');
INSERT INTO Erreur (erreur) VALUES ('Erreur : date_transaction_fin doit être >= à date_debut_transaction.');
INSERT INTO Erreur (erreur) VALUES ('Erreur : est_conclu doit valoir TRUE (1) ou FALSE (2).');
-- Création du trigger
DELIMITER |
DROP TRIGGER if EXISTS date_contact |
CREATE TRIGGER date_contact 
AFTER UPDATE 
ON waz_negocier 
FOR EACH ROW
BEGIN

    IF new.date_dernier_contact < old.date_debut_transaction 
        THEN
        -- vérification des dates dans les champs  
            INSERT INTO Erreur (erreur) VALUES ('Erreur : date_dernier_contact doit être >= à date_debut_transaction.');
    ELSEIF new.date_transaction_fin < old.date_debut_transaction
        THEN
            INSERT INTO Erreur (erreur) VALUES ('Erreur : date_transaction_fin doit être >= à date_debut_transaction.');
    ELSEIF new.est_conclu != TRUE -- ni true
    AND new.est_conclu != FALSE -- ni false
        THEN
            INSERT INTO Erreur (erreur) VALUES ('Erreur : est_conclu doit valoir TRUE (1) ou FALSE (2).');
    END IF;
END |
DELIMITER ;