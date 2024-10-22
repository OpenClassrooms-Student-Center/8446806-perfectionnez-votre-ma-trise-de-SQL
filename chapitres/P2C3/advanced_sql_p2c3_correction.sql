/*
  1 & 2 - Création de la procédure stockée validate_email_format
*/

CREATE PROCEDURE validate_email_format(p_email VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Vérifie si l'email respecte le format standard
    IF p_email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$' THEN
        RAISE EXCEPTION 'L''adresse email % est invalide.', p_email;
    END IF;
END;
$$;

-- Cette procédure utilise l'opérateur PostgreSQL ~* pour vérifier que l'email correspond à une expression régulière (regex) qui définit le format attendu.


/*
  3 - Création du trigger pour automatiser la validation avant chaque insertion dans customer
*/
CREATE TRIGGER validate_email_format_trigger
BEFORE INSERT ON customer
FOR EACH ROW
EXECUTE PROCEDURE validate_email_format(NEW.email);


/*
  4 - Test de la procédure stockée et du trigger en insérant un nouveau client (format incorrect)
*/
-- format incorrect
INSERT INTO customer (first_name, last_name, email) 
VALUES ('Camille', 'Thomas', 'camille.thomas_sakilacustomer.org');

-- format correct
INSERT INTO customer (first_name, last_name, email) 
VALUES ('Camille', 'Thomas', 'camille.thomas@sakilacustomer.org');