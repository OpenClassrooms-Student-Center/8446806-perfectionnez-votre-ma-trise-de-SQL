/*
  Création de la vue matérialisée
*/
CREATE MATERIALIZED VIEW current_rentals_mat AS 
SELECT 
	c.customer_id,
	c.first_name, 
	c.last_name, 
	r.rental_date, 
	f.title
FROM
	customer c 
	JOIN rental r ON c.customer_id = r.customer_id
	JOIN inventory i ON i.inventory_id = r.inventory_id
	JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NULL

/*
  Insertion de la nouvelle location pour vérifier la non présence dans current_rentals_mat
*/
INSERT INTO public.rental(
  rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update, during_business_hours)
  VALUES (999997, NOW(), 4466, 207, null, 1, NOW(), true);

/*
  Vérification de la non présence de la nouvelle location
*/
SELECT * FROM current_rentals_mat WHERE EXTRACT(YEAR FROM rental_date) = '2024'

/*
  Rafraichissement de la vue
*/ 
REFRESH MATERIALIZED VIEW current_rentals_mat;

/*
  Vérification de la  présence de la nouvelle location
*/ 
SELECT * FROM current_rentals_mat WHERE EXTRACT(YEAR FROM rental_date) = '2024'

/*
  Suppression de l'insertion pour nettoyage
*/
DELETE FROM public.rental WHERE rental_id = 999997

/*
  Suppression de la vue matérialisée
*/ 
DROP MATERIALIZED VIEW current_rentals_mat