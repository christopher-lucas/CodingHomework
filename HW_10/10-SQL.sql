USE sakila;

-- 1a
SELECT first_name, last_name FROM actor;

-- 1b
SELECT CONCAT(first_name, ' ' , last_name) AS actor_name FROM actor;

-- 2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- 2b
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%gen%';

-- 2c
SELECT actor_id, first_name, last_name, last_update
FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;

-- 2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor ADD middle_name VARCHAR(45) AFTER first_name;

-- 3b
ALTER TABLE actor MODIFY middle_name  BLOB(100000000);

-- 3c
ALTER TABLE actor DROP COLUMN middle_name;

-- 4a
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name
HAVING COUNT(last_name) >= 2;

-- 4c
UPDATE actor SET first_name = 'Groucho' where last_name = 'Williams';

-- 4d
UPDATE actor SET first_name =  CASE  WHEN first_name = 'HARPO' 
 THEN 'GROUCHO'  ELSE 'MUCHO GROUCHO'  END  WHERE actor_id = 172;

-- 6a
SELECT staff.first_name, staff.last_name, address.address, address.address2
FROM staff, address;

-- 6b
SELECT staff.first_name, staff.last_name, payment.amount, payment.payment_date
FROM staff, payment WHERE payment_date LIKE '2005-08%'  GROUP BY last_name;

-- 6c
SELECT film.title, COUNT(film_actor.actor_id) AS 'actor_count'  
FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id 
GROUP BY actor_id ORDER BY actor_id;

-- 6d
SELECT film.film_id, film.title,inventory.film_id SUM(film.title)
FROM film,inventory WHERE film.title='Hunchback Impossible';

-- 6e
SELECT customer.last_name, customer.first_name, SUM(payment.amount)
FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id ORDER BY last_name;

-- 7a
SELECT title FROM film WHERE language_id in
	(
    SELECT language_id FROM language WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%"
);

-- 7b
SELECT last_name, first_name FROM actor WHERE actor_id in
	(
    SELECT actor_id FROM film_actor
	WHERE film_id in 
		(
        SELECT film_id FROM film
		WHERE title = "Alone Trip"
        )
        );
        
-- 7c
SELECT country, last_name, first_name, email FROM country
LEFT JOIN customer ON country.country_id = customer.customer_id WHERE country = 'Canada';

-- 7d
SELECT title, category FROM film_list WHERE category = 'Family';

-- 7e
SELECT inventory.film_id, film.title, COUNT(rental.inventory_id) FROM inventory INNER JOIN rental
ON inventory.inventory_id = r.inventory_id INNER JOIN film_text ON inventory.film_id = film_text.film_id
GROUP BY rental.inventory_id ORDER BY COUNT(rental.inventory_id) DESC;

-- 7f
SELECT store.store_id, SUM(amount) FROM store INNER JOIN staff
ON store.store_id = staff.store_id INNER JOIN payment p ON p.staff_id = staff.staff_id
GROUP BY store.store_id ORDER BY SUM(amount);

-- 7g
SELECT store.store_id, city, country FROM store INNER JOIN customer ON store.store_id = customer.store_id
INNER JOIN staff ON store.store_id = staff.store_id INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id INNER JOIN country ON city.country_id = country.country_id;

-- 7h
SELECT category.name, SUM(payment.amount) FROM category INNER JOIN film_category
INNER JOIN inventory ON inventory.film_id = film_category.film_id INNER JOIN rental
ON rental.inventory_id = inventory.inventory_id INNER JOIN payment GROUP BY category.name;

-- 8a
CREATE VIEW top_genres AS SELECT name, SUM(p.amount) FROM category c INNER JOIN film_category fc 
INNER JOIN inventory i ON i.film_id = fc.film_id INNER JOIN rental r ON r.inventory_id = i.inventory_id INNER JOIN payment p
GROUP BY name;

-- 8b
SELECT * FROM top_genres;

-- 8c
DROP VIEW top_genres;
