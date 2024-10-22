/*
	Afficher le nombre total de locations pour chaque film en utilisant la clause SELECT avec une sous-requête
*/
SELECT 
    f.title, 
    f.description,
    f.release_year,
    (
		SELECT
			COUNT(rental_id)
		FROM
			rental r
			INNER JOIN public.inventory i ON i.inventory_id = r.inventory_id
		WHERE
			i.film_id = f.film_id 
			AND EXTRACT(YEAR FROM CAST(r.rental_date AS DATE)) = '2005'
	) AS total_rentals
FROM film f
ORDER BY total_rentals DESC;


/*
	Afficher le nombre total de locations pour chaque film en utilisant la clause FROM avec une sous-requête
*/

SELECT 
  f.title, 
	f.description,
	f.release_year,
  rental_information.total_rentals
FROM
	(
	    SELECT
        I.film_id,
        COUNT(r.rental_id) AS total_rentals
	    FROM
        rental r
        INNER JOIN public.inventory i ON i.inventory_id = r.inventory_id
	    WHERE
			  EXTRACT(YEAR FROM CAST(r.rental_date AS DATE)) = '2005'
	    GROUP BY
			  i.film_id
	) AS rental_information
	JOIN film f ON f.film_id = rental_information.film_id
ORDER BY
	rental_information.total_rentals DESC;

/*
	Afficher uniquement les films qui ont été loués au moins 50 fois en 2005
*/
SELECT
	f.title,
	f.description,
	f.release_year
FROM
	film f
WHERE
	f.film_id IN (
	    SELECT
			i.film_id
		FROM
			rental r
			INNER JOIN public.inventory i ON i.inventory_id = r.inventory_id
		WHERE
			EXTRACT(YEAR FROM CAST(r.rental_date AS DATE)) = '2005'
		GROUP BY
			film_id
		HAVING
			COUNT (rental_id) >= 30
	);