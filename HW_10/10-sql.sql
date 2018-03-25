USE sakila;

-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT CONCAT(first_name, ' ' , last_name)
AS actor_name
FROM actor;

-- 2a.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

-- 2c.
SELECT actor_id, first_name, last_name, last_update
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- 2d.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.

-- 3b.

-- 3c.

-- 4a.
SELECT last_name
FROM actor

