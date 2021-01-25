/*1. Write a query to display for each store its store ID, city, and country.
2. Write a query to display how much business, in dollars, each store brought in.
3. What is the average running time of films by category?
4. Which film categories are longest?
5. Display the most frequently rented movies in descending order.
6. List the top five genres in gross revenue in descending order.
7. Is "Academy Dinosaur" available for rent from Store 1? */
use sakila;
-- 1 
select s.store_id, c.city, ctr.country from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country ctr on c.country_id = ctr.country_id;
-- 2
select c.store_id, sum(p.amount) as revenue from customer c
join payment p on c.customer_id = p.customer_id
group by c.store_id;
-- 3
use sakila;
select ca.name as category, round(avg(f.length),2) as average_length from film f
join film_category fc on f.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
group by fc.category_id;
-- 4 
select ca.name as category, round(avg(f.length),2) as average_length from film f
join film_category fc on f.film_id = fc.film_id
join category ca on fc.category_id = ca.category_id
group by fc.category_id
order by name desc
limit 1;
-- 5
select f.title, count(r.rental_id) as rental_frequency from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
group by f.film_id
order by rental_frequency desc;
-- 6
SELECT 
    SUM(p.amount) AS revenue, c.name AS category
FROM
    payment p
        JOIN
    rental r ON p.rental_id = r.rental_id
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    film_category fc ON i.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 5;
-- 7
use sakila;
select f.title, r.inventory_id, r.rental_date , r.return_date from rental r 
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
where f.title = 'ACADEMY DINOSAUR' and i.store_id ='1'
order by r.rental_date desc;  
#as the movie with inventory_id 1,2,3,4 has all been returned, they would be available for rent

