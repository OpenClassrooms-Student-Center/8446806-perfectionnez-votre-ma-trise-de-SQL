/*
  Vue pour l’équipe marketing
*/
CREATE VIEW marketing_customers AS
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  cty.city
  cou.country
FROM
  customer c;
  JOIN address a 	ON c.address_id = a.address_id
  JOIN city	cty	ON cty.city_id = a.city_id;
  JOIN country	cou	ON cou.country_id = a.country_id;

/*
  Vue pour l’équipe service client
*/
CREATE VIEW customer_rentals
AS
SELECT
  c.first_name,
  c.last_name,
  f.title
FROM
  customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN film f ON r.film_id = f.film_id
WHERE
  r.return_date IS NOT NULL  -- Exclure les films en cours
  AND r.rental_date >= CURRENT_DATE - INTERVAL '6 months';  -- Loués il y a moins de 6 mois


/*
  Création et rafraîchissement d’une vue matérialisée
*/
CREATE MATERIALIZED VIEW customer_rentals_mat
AS
SELECT
  c.first_name,
  c.last_name,
  f.title
FROM
  customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN film f ON r.film_id = f.film_id
WHERE
  r.return_date IS NULL;

-- Pour rafraîchir cette vue matérialisée après l’ajout de nouvelles locations dans la table rental, utilisez la commande suivante :
REFRESH MATERIALIZED VIEW customer_rentals_mat;