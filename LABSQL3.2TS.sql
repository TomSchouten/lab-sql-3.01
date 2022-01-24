USE sakila;

--     How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT  title, COUNT(inventory_id) AS number_of_copies
FROM    film
JOIN    inventory USING (film_id)
WHERE   title = 'Hunchback Impossible';

--     List all films whose length is longer than the average of all the films.
SELECT title
FROM   film
WHERE  length > (SELECT avg(length) FROM film);

--     Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name,' ',last_name) AS actor_in_film
FROM sakila.actor 
WHERE actor_id IN (
	SELECT actor_id 
    FROM film_actor 
	WHERE film_id IN
		(SELECT film_id 
        FROM film 
        WHERE title = 'Alone Trip'
		)
	);

--     Identify all movies categorized as family films.
SELECT title
FROM sakila.film
WHERE film_id IN (
	SELECT film_id 
    FROM film_category
	WHERE category_id IN
		(SELECT category_id 
        FROM category
        WHERE name = 'family'
		)
	 );



--     Get name and email from customers from Canada using subqueries. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- I dont understand subqueries, i get other people in my querries
SELECT CONCAT(first_name,' ',last_name) AS customer ,email
FROM customer
WHERE address_id IN (
	SELECT city_id 
    FROM address
	WHERE city_id IN
		(SELECT city_id 
		FROM city
		WHERE country_id = 20
		)
	 );
     
-- Do the same with joins.
SELECT CONCAT(first_name,' ',last_name) AS customer ,email
FROM   customer
JOIN   address USING(address_id)
JOIN   city USING(city_id)
JOIN   country USING(country_id)
WHERE  country = 'Canada';


--     Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT title
FROM film
Where actor_id IN (
	SELECT first_name, last_name
    FROM actor
    WHERE actor_id = (
        SELECT   actor_id
		FROM     film_actor
        GROUP BY actor_id
		ORDER BY COUNT(film_id) DESC LIMIT 1));
-- Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery' AGAIN


--     Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT title
FROM   film
WHERE inventory_id IN(
	SELECT inventory_id
	FROM   inventory
    JOIN   rental USING(inventory_id)
    WHERE  customer_id IN(
		SELECT   SUM(amount), customer_id
		FROM     payment
		ORDER BY customer_id DESC
		LIMIT    1));

-- Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery' AGAIN 
-- I DONT UNDERSTAND SUBQUERIES, AND I DONT SEE WHY ITS MORE CONVENIENT THEN JOINING TABLES.

--     Customers who spent more than the average payments.


