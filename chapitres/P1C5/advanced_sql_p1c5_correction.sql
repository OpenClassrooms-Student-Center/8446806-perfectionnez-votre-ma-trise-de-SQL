/*
    Rodolphe souhaite s'assurer que les numéros de téléphone des clients contiennent entre 0 et 12 chiffres. 
    Ajoutez une contrainte CHECK sur la colonne phone pour garantir cette règle. 
*/
ALTER TABLE address
ADD CONSTRAINT phone_check
CHECK (phone ~ '^[0-9]{0,12}$');

-- Explication : 
-- ^[0-9]{0,12}$ : Cette expression régulière permet de valider que la colonne phone contient uniquement des chiffres, avec une longueur comprise entre 0 et 12 chiffres.

/*
    Ajoutez une contrainte d'unicité : Pour éviter les doublons, ajoutez une contrainte d'unicité sur la colonne email,
     afin que chaque client ait une adresse email unique dans la base de données.
*/
ALTER TABLE customer
ADD CONSTRAINT unique_email
UNIQUE (email);

-- Explication : 
-- Cette contrainte unique_email empêche les doublons dans la colonne email, en veillant à ce que chaque adresse email soit unique dans la base de données.