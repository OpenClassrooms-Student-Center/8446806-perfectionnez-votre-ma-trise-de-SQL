/*
  1 - Importez les données du fichier CSV dans une nouvelle table film_new_acquisition.
*/
CREATE TABLE film_new_acquisition (
    film_id integer NOT NULL,
    title varchar(255) NOT NULL,
    description text,
    release_year integer,
    language_id smallint NOT NULL,
    rental_duration smallint NOT NULL,
    rental_rate numeric(4,2) NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) NOT NULL,
    rating varchar(10),
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    special_features text[],
    fulltext tsvector
);

-- Import du fichier CSV
COPY film_new_acquisition(film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, fulltext)
FROM '/path/to/your/new_film_archive_corrected.csv'
DELIMITER ','
CSV HEADER;

/*
  2 - Trouvez les films en commun entre les trois tables film, film_archive, et film_new_acquisition
*/
SELECT title FROM film f
INTERSECT
SELECT title FROM film_archive fa
INTERSECT
SELECT title FROM film_new_acquisition fna;

/*
  3 - Combinez toutes les données des trois tables en une seule, sans duplication (utilisation de UNION)
*/
SELECT title, release_year, rental_duration, rental_rate
FROM film
UNION
SELECT title, release_year, rental_duration, rental_rate
FROM film_archive
UNION
SELECT title, release_year, rental_duration, rental_rate
FROM film_new_acquisition;

/*
  4 -  Recherchez les films présents dans deux ensembles mais pas dans le troisième
  (exemple : films présents dans film et film_archive, mais pas dans film_new_acquisition)
*/
SELECT title
FROM film f
INTERSECT
SELECT title
FROM film_archive fa
EXCEPT
SELECT title
FROM film_new_acquisition fna;