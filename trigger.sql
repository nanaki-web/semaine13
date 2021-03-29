-- Création de la table Erreur
use wazaaimmogroup;
DROP Table IF EXISTS Erreur;
CREATE TABLE Erreur (
    id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    erreur VARCHAR(255) UNIQUE,
    in_id int(10));

-- Insertion de l'erreur qui nous intéresse
INSERT INTO Erreur (erreur) VALUES ('Erreur : Veuillez recontactez votre client');
INSERT INTO Erreur (erreur) VALUES ('Erreur : date_dernier_contact doit être >= à date_debut_reservation.');

-- Création du trigger
DELIMITER |
DROP TRIGGER if EXISTS date_different_contact |
CREATE TRIGGER date_different_contact 
AFTER UPDATE 
ON waz_negocier 
FOR EACH ROW
BEGIN
    DECLARE date_different_contact INT;
    DECLARE id_i INT;
    SET date_different_contact = 14;
    SET  id_i = in_id;
    IF date_dernier_contact - date_debut_transaction >= date_different_contact

      THEN
        INSERT INTO Erreur (erreur,in_id) VALUES ('Erreur : Veuillez recontactez votre client',in_id);
    ELSEIF date__dernier_contact < new.date_debut_transaction 
        -- vérification des dates dans les champs  
        INSERT INTO Erreur (erreur) VALUES ('Erreur : date_dernier_contact doit être >= à date_debut_reservation.');
    END IF;
END |
DELIMITER ;