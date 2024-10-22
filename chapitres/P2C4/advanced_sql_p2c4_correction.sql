/*
  1 - Créer une vue des locations par client entre le 1er mars et le 1er septembre 2005 :
*/
CREATE VIEW rental_analysis AS
SELECT
  c.customer_id,
  concat_ws(' ', c.first_name, c.last_name) as full_name,
  TO_CHAR(r.rental_date, 'Month')  AS rental_month,
  COUNT(r.rental_id) AS films_rented
FROM
  rental r
  INNER JOIN customer c ON c.customer_id = r.customer_id
WHERE
  r.rental_date BETWEEN '2005-03-01' AND '2005-09-01'
GROUP BY
  c.customer_id, full_name, rental_month;
  
/*
  2 - Attribuer un classement aux clients selon leurs films loués :
*/
SELECT
	full_name,
	rental_named_month,
	films_rented,
	RANK() OVER (ORDER BY films_rented DESC) AS rental_rank,
	DENSE_RANK() OVER (ORDER BY films_rented DESC) AS dense_rental_rank
FROM rental_analysis
ORDER BY dense_rental_rank;

/*
  3 - Comparer le nombre de films loués d'un mois sur l'autre avec LAG :
*/
SELECT
	customer_id,
	rental_month,
	rental_named_month,
	films_rented,
	LAG(films_rented, 1) OVER (PARTITION BY customer_id ORDER BY rental_month) AS previous_month_rentals
FROM rental_analysis
ORDER BY customer_id, rental_month;

/*
  Suppression de la vue rental_analysis pour nettoyage
*/
DROP VIEW rental_analysis