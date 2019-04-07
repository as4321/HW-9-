
-- 1a --
SELECT first_name, last_name 
FROM sakila.actor;

-- 1b 
SELECT concat(first_name, '  ', last_name) as actor_name
FROM sakila.actor;

-- 2a .--
SELECT first_name, last_name , actor_id
FROM sakila.actor
WHERE first_name = 'Joe';

-- 2b .--
SELECT first_name, last_name , actor_id
FROM sakila.actor
WHERE last_name LIKE '%gen%';

-- 2c .--
SELECT last_name, first_name, actor_id
FROM actor
WHERE last_name LIKE '%li%';

-- 2d .--
SELECT country, country_id 
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh','China');

-- 3a --
ALTER TABLE actor 
ADD description BLOB;

-- 3b --
ALTER TABLE actor 
DROP COLUMN description;

-- 4a --
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b --
SELECT COUNT(last_name) AS count_last_name
FROM actor
Group by last_name
HAVING count_last_name >2;

-- 4c --
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

-- 4d --
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

-- 5a --
SHOW CREATE TABLE address;

-- 6a --
SELECT staff.first_name, staff.last_name, address.address 
FROM address
INNER JOIN staff ON 
staff.address_id= address.address_id;

-- 6b --
SELECT staff.first_name, 
staff.last_name, 
SUM(payment.amount) as 'total_aug2005'
FROM payment
INNER JOIN staff ON 
staff.staff_id= payment.staff_id
WHERE MONTH(payment.payment_date) = 08 AND YEAR(payment.payment_date) = 2005
GROUP BY staff.staff_id;

-- 6c --
SELECT film.title, COUNT(film_actor.actor_id) as 'actor_count'
FROM film_actor
INNER JOIN film ON 
film.film_id=film_actor.film_id
GROUP BY title; 

-- 6d --
Select film.title, COUNT(film.title)as 'film_count'
from film
INNER JOIN inventory ON 
inventory.film_id=film.film_id
WHERE title = 'Hunchback Impossible'
GROUP BY title;

-- 7a-- 
SELECT title 
from film 
where title like 'k%' OR title like 'q%' AND language_id IN 
( 
	Select language_id
	FROM language 
    Where name = 'English'
);
    
-- 7b--
SELECT first_name, last_name 
FROM actor 
Where actor_id IN
(
	SELECT actor_id
    FROM film_actor
    Where film_id = 
    (
	Select film_id
        From film 
        Where title = 'Alone Trip'
	)
);

-- 7c  
SELECT customer.email, customer.first_name, customer.last_name
FROM customer
INNER JOIN  address ON 
customer.address_id=address.address_id
INNER JOIN  city ON 
address.city_id=city.city_id
INNER JOIN  country ON 
city.country_id=country.country_id
WHERE country.country = 'Canada';

-- 7d --
SELECT title 
FROM film 
Where film_id IN
(
	SELECT film_id
    FROM film_category
    Where category_id = 
    (
	Select category_id
        From category 
        Where name = 'Family'
	)
);

-- 7e --
SELECT film.title, COUNT(film.title) 
FROM film 
INNER JOIN inventory ON 
film.film_id=inventory.film_id
INNER JOIN rental ON 
inventory.inventory_id=rental.inventory_id
GROUP BY film.title 
ORDER BY COUNT(film.title) DESC;

	
-- 7f--
SELECT store.store_id, SUM(payment.amount) AS total_bus
FROM payment 
INNER JOIN rental ON 
payment.rental_id= rental.rental_id
INNER JOIN inventory ON 
inventory.inventory_id=rental.inventory_id
INNER JOIN store ON 
store.store_id= inventory.store_id
GROUP BY store.store_id;

-- 7g--
SELECT store.store_id, city.city, country.country
from store 
Inner join address ON 
store.address_id= address.address_id
INNER JOIN city ON 
address.city_id= city.city_id
INNER JOIN country ON 
city.country_id= country.country_id;

-- 7h --
SELECT category.name, SUM(payment.amount) AS total_money
from payment 
INNER JOIN rental ON 
payment.rental_id= rental.rental_id
INNER JOIN inventory ON 
rental.inventory_id= inventory.inventory_id 
INNER JOIN film_category ON 
inventory.film_id= film_category.film_id
INNER JOIN category ON 
film_category.category_id= category.category_id
GROUP BY category.name
ORDER BY total_money DESC
LIMIT 5; 

-- 8a -- 
CREATE VIEW exec_view AS
SELECT category.name, SUM(payment.amount) AS total_money
from payment 
INNER JOIN rental ON 
payment.rental_id= rental.rental_id
INNER JOIN inventory ON 
rental.inventory_id= inventory.inventory_id 
INNER JOIN film_category ON 
inventory.film_id= film_category.film_id
INNER JOIN category ON 
film_category.category_id= category.category_id
GROUP BY category.name
ORDER BY total_money DESC
LIMIT 5; 

--  8b--
SELECT * 
FROM exec_view; 

--  8c--
DROP VIEW IF EXISTS exec_view;  


