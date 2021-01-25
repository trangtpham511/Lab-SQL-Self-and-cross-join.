/*1. List number of films per `category`.
2. Display the first and last names, as well as the address, of each staff member.
3. Display the total amount rung up by each staff member in August of 2005.
4. List each film and the number of actors who are listed for that film.
5. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
*/
-- 1
select count(f.film_id), fc.category_id, c.name from film f
join film_category fc 
on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by fc.category_id
order by category_id;
-- 2
select s.staff_id, s.first_name, s.last_name, a.address from staff s
join address a
on s.address_id = a.address_id;

-- 3
select
	count(l.amount) as 'total_payment', s.staff_id, s.first_name, s.last_name from payment as l
join staff as s
on l.staff_id = s.staff_id
where DATE_FORMAT(payment_date, "%M %Y")='August 2005'
group by staff_id;
-- 4
select a.film_id, count(a.actor_id) as no_of_actors, f.title from film f
join film_actor a
on a.film_id = f.film_id
group by film_id
order by film_id;
-- 5
select c.customer_id, c.first_name , c.last_name, sum(p.amount) as total_amount from customer c
left join payment p
on c.customer_id = p.customer_id
group by p.customer_id
order by c.last_name;