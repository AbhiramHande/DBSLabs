-- Ex.1. Write the following queries in SQL, using the sakila schema.
-- Q 1.a. Retrieve a list of film titles along with the names of the actors in each film.
USE sakila;

SELECT film.title, CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name
FROM film JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY film.title, actor_name;

-- Q 1.b. Find the total amount paid by each customer.
SELECT customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
    SUM(payment.amount) AS total_amount_paid
FROM customer JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer_name
ORDER BY total_amount_paid DESC;

-- Q 1.c. Identify films that were not rented out in January 2005.
SELECT DISTINCT film.title FROM film LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date IS NULL OR (rental.rental_date NOT BETWEEN '2005-01-01' AND '2005-01-31');

-- Q 1.d. Calculate the total revenue of each store.
SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id ORDER BY total_revenue DESC;

-- Q 1.e. List all customers who have rented a film in the last 30 days.
--        (Hint: You can use ‘INTERVAL x DAY’ to specify an interval in MySQL.)
SELECT DISTINCT customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name
FROM customer JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.rental_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY customer_name;

-- Ex.2. Fill-in-the-Blanks:
-- Q 2.a. The ________ statement is used to remove a table schema and its data from the database. (DELETE)
-- Q 2.b. In SQL, ________ is a constraint that ensures all values in a column are different. (UNIQUE)
-- Q 2.c. The ________ statement is used to add, delete, or modify columns in an existing table. (UPDATE / ALTER)
-- Q 2.d. To remove duplicates from the result set, you should use the ________ keyword with your SELECT statement. (DISTINCT)
-- Q 2.e. A ________ key is a field in one table that uniquely identifies a row of another table or the same table. (PRIMARY)