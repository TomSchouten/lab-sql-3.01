USE sakila;

DELETE FROM sakila.staff
picture; 

SET SQL_SAFE_UPDATES = 0; -- disable safe mode

ALTER table sakila.staff
DROP COLUMN picture;

SET SQL_SAFE_UPDATES = 1; -- enable safe mode

INSERT INTO sakila.staff (first_name, last_name)
VALUES (TAMMY, SANDERS);

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- customer_id is 130

select inventory_id, film_id from sakila.inventory 
JOIN sakila.film USING (film_id)
WHERE title = 'Academy Dinosaur'; -- inv_id is 1 trough 8 and film_id is 1

select staff_id from sakila.staff
where first_name = 'Mike';  -- Staff_id is 1

INSERT INTO sakila.rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (CURRENT_TIMESTAMP(),1,130,1);

SELECT *
FROM rental
WHERE inventory_id = 1;

