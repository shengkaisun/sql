-- Customer ID, name, address 
select customer_id, first_name, last_name, address.address
from customer, address 
where customer.address_id = address.address_id;

-- Film name, category, and language
select f.title as name, fc.category_id as category_id, c.name as cateogry, l.name as lanauge
from film f, film_category fc, language l, category c
where f.film_id = fc.film_id and f.language_id = l.language_id and 
    c.category_id = fc.category_id;

-- For each film, how many times it has been rented out
select f.title as title, count(r.rental_id) as rental_count
from film f, rental r, inventory i
where r.inventory_id = i.inventory_id and i.film_id = f.film_id 
group by i.film_id
order by 2 desc;

-- Revenue per film title
select f.title as title, count(r.rental_id) as rental_count, 
    f.rental_rate as rental_rate,
    count(r.rental_id) * f.rental_rate as est_rev,
    sum(p.amount) as total_payment
from payment p, rental r, inventory i, film f
where p.rental_id = r.rental_id 
    and r.inventory_id = i.inventory_id
    and f.film_id = i.film_id
group by f.film_id
order by 2 desc;

-- What customer has paid the most money
select c.customer_id as id, c.first_name as first_name, c.last_name as last_name,
    sum(p.amount) as total_payment, count(p.rental_id) as rental_count
from payment p, customer c
where p.customer_id = c.customer_id
group by 1
order by 4 desc;

-- Which store has brought the most revenue in the past?
select i.store_id as store_id, sum(p.amount) as revenue
from inventory i, payment p, rental r
where i.inventory_id = r.inventory_id
    and p.rental_id = r.rental_id
group by 1
order by 2 desc;
