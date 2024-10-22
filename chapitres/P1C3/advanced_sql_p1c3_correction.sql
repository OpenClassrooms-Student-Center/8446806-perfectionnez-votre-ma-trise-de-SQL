-- Dates
/*
    Ajoutez une nouvelle colonne dans la table rental pour indiquer si une location 
    a été effectuée durant les heures d'ouverture de DVD Rental (de 9h à 18h)
*/
ALTER TABLE rental ADD COLUMN during_business_hours BOOLEAN;

/*
    Utilisez la fonction EXTRACT ou DATE_TRUNC pour vérifier l'heure de la location et insérer une valeur booléenne (TRUE/FALSE).
*/
UPDATE rental
SET during_business_hours = (EXTRACT(HOUR FROM rental_date) >= 9 AND EXTRACT(HOUR FROM rental_date) < 18);

-- Tableaux
/*
    Ajoutez une colonne de type tableau dans la table customer pour enregistrer les différents modes 
    de contact utilisés par chaque client (par exemple, {Email, SMS, Téléphone}).
*/
ALTER TABLE customer
ADD COLUMN contact_methods VARCHAR[];

/*
    Insérez plusieurs modes de contact pour certains clients.
*/
UPDATE customer
SET contact_methods = ARRAY['Email', 'SMS', 'Téléphone']
WHERE customer_id = 1;

UPDATE customer
SET contact_methods = ARRAY['Email', 'Téléphone']
WHERE customer_id = 2;

/*
    Effectuez une requête pour rechercher les clients qui ont "SMS" comme mode de contact préféré.
*/
SELECT customer_id, contact_methods
FROM customer
WHERE 'SMS' = ANY(contact_methods);