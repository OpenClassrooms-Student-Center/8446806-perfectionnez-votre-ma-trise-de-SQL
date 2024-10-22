WITH total_rentals_per_customer AS (
    SELECT customer_id, COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
total_payments_per_customer AS (
    SELECT customer_id, SUM(amount) AS total_payments
    FROM payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, tr.total_rentals, tp.total_payments
FROM customer c
JOIN total_rentals_per_customer tr ON c.customer_id = tr.customer_id
JOIN total_payments_per_customer tp ON c.customer_id = tp.customer_id
WHERE tr.total_rentals > 10 AND tp.total_payments > 100;

/*
Explication :
- total_rentals_per_customer : Cette CTE calcule le nombre total de locations par client.
- total_payments_per_customer : Cette CTE calcule le montant total des paiements par client.
- La requête principale utilise ces deux CTEs pour afficher les clients ayant plus de 10 locations et plus de 100 € de paiements.
*/