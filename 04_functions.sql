-- left(string, character_count) function
-- Find out how many rentals each month has
select left(r.rental_date, 7), count(r.rental_id)
from rental r
group by 1
order by 2 desc;

-- First and last rental date of each movie
select f.title as title, min(r.rental_date) as first_rental, 
    max(r.rental_date) as last_rental, 
    count(r.rental_id) as rental_count
from film f, rental r, inventory i
where r.inventory_id = i.inventory_id and f.film_id = i.film_id
group by i.film_id
order by 4 desc;

-- Customers who haven't rent a movie in the last month
select c.customer_id as id, c.first_name as first_name, 
    c.last_name as last_name, c.email as email, 
    left(max(r.rental_date), 7) as last_active_mon
from customer c, rental r
where c.customer_id = r.customer_id
    and 5 < '2006-02'
group by 1;