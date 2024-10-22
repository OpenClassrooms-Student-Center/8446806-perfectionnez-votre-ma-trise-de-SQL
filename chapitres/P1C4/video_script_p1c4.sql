/*
  Création des tables temporaires
*/

-- Créer la table customer_demo en tant que copie de la table public.customer
CREATE TABLE public.customer_demo
AS
SELECT  *
FROM  public.customer;

ALTER TABLE IF EXISTS public.customer_demo
ADD CONSTRAINT customer_demo_pkey PRIMARY KEY (customer_id);

-- Vérifier la table customer_demo
SELECT * FROM public.customer_demo;

-- Créer la table film_demo en tant que copie de la table public.film
CREATE TABLE public.film_demo
AS
SELECT  *
FROM  public.film;

ALTER TABLE IF EXISTS public.film_demo
ADD CONSTRAINT film_demo_pkey PRIMARY KEY (film_id);

-- Vérifier la table film_demo
SELECT * FROM public.film_demo;

-- Création de la table rental_demo, avec ON DELETE CASCADE sur customer_id
CREATE TABLE rental_demo (
	rental_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customer_demo(customer_id) ON DELETE CASCADE,
	film_id INT REFERENCES film_demo(film_id),
	rental_date DATE NOT NULL
 );

-- Copier les informations de rental dans rental_demo
INSERT INTO rental_demo(rental_id, customer_id, film_id, rental_date)
SELECT
	DISTINCT r.rental_id, r.customer_id, i.film_id, r.rental_date
FROM
	rental r
	INNER JOIN public.inventory i ON i.inventory_id = r.inventory_id;

-- Vérifier que la copie a fonctionné
SELECT * FROM rental_demo;


/*
	Vérifier la contrainte ON DELETE CASCADE
*/
-- Vérifier que des transactions pour le client ayant pour id 44 existent
SELECT * FROM rental_demo WHERE customer_id = 44;

-- Vérification du client 44
SELECT * FROM customer_demo WHERE customer_id = 44;
-- Supprimer le client 44
DELETE FROM customer_demo WHERE customer_id = 44;

-- Vérifier que les transactions du client ont bien été supprimées
SELECT * FROM rental_demo WHERE customer_id = 44;


-- DROP OLD CONSTRAINT
ALTER TABLE public.rental_demo
  DROP CONSTRAINT rental_demo_film_id_fkey RESTRICT;


/*
	Vérifier la contrainte ON DELETE SET NULL
*/
ALTER TABLE rental_demo
ADD CONSTRAINT fk_film_demo
	FOREIGN KEY (film_id)
		REFERENCES film_demo(film_id)
			ON DELETE SET NULL;

/*
	Vérifier la contrainte ON DELETE CASCADE
*/
-- Vérifier que des transactions pour le client ayant pour id 53 existent
SELECT * FROM rental WHERE customer_id = 53 ORDER BY film_id;

-- Vérification du client 53
SELECT * FROM film_demo WHERE film_id = 15;
-- Supprimer le client 53
DELETE FROM film_demo WHERE film_id = 15;

-- Vérifier que les transactions du client ont bien été supprimées
SELECT * FROM rental_demo WHERE customer_id = 53 ORDER BY film_id;

/*
  Nettoyage et suppression des tables temporaires
*/
DROP TABLE rental_demo;
DROP TABLE film_demo;
DROP TABLE customer_demo;