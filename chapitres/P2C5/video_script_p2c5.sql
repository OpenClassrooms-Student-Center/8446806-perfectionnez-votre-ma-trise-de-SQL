/*
  Télécharger le fichier csv
*/
-- Vous devez télécharger le fichier csv fourni en local sur votre machine.


/*
  Créer la table film_archive dans PostgreSQL 
*/
CREATE TABLE film_archive (
	film_id integer NOT NULL DEFAULT nextval('film_film_id_seq'::regclass), 
	title character varying(255) NOT NULL, 
	description text, 
	release_year integer, 
	language_id smallint NOT NULL, 
	rental_duration smallint NOT NULL, 
	rental_rate numeric(4,2) NOT NULL, 
	length smallint, 
	replacement_cost numeric(5,2) NOT NULL, 
	rating character varying(5), 
	last_update timestamp without time zone NOT NULL DEFAULT now(), 
	special_features text[] DEFAULT '{}', 
	fulltext tsvector NOT NULL 
);

/*
  Charger les donnes du fichier csv via l'interface graphique pgAdmin
*/
-- cf. vidéo

-- Il est également possible d'utiliser pgsql pour charger les données (à la place de pgAdmin)
COPY film_archive(film_id, title)
FROM '/chemin/vers/film_archive.csv' 
DELIMITER ',' 
CSV HEADER;


/*
  Vérifiez les données importées
*/
SELECT * FROM film_archive;