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
select c.customer_id as id, 
    concat(c.first_name, " ", c.last_name) as name, 
    c.email as email, 
    left(max(r.rental_date), 7) as last_active_mon
from customer c, rental r
where c.customer_id = r.customer_id
    and 5 < '2006-02'
group by 1;

-- Revenue by month
select left(p.payment_date, 7) as month, 
    sum(p.amount) as revenue, 
    count(p.rental_id) as rental_count 
from payment p
group by 1
order by 1;

-- Distinc keyword
-- How many distinct renters per month
select left(r.rental_date, 7) as month, 
    count(r.rental_id) as rental_count,
    count(distinct r.customer_id) as unique_customers,
    count(r.rental_id) / count(distinct r.customer_id) as avg_rentals_per_renter
from rental r
group by 1;

-- Num of unique films rented each month
select left(r.rental_date, 7) as month,
    count(r.rental_id) as rental_count,
    count(distinct i.film_id) as unique_films,
    count(r.rental_id) /  count(distinct i.film_id) as avg_rentals_per_film
from rental r, inventory i
where r.inventory_id = i.inventory_id
group by 1;

-- IN() function
-- Num of rentals in Comedy, Sports, and Family category
select left(r.rental_date, 7) as month,
    c.name as category, 
    count(r.rental_id) as rental_count
from rental r, inventory i, film_category fc, category c
where r.inventory_id = i.inventory_id
    and i.film_id = fc.film_id
    and fc.category_id = c.category_id
    and c.name in ("Comedy", "Sports", "Family")
group by 1, fc.category_id
order by 1 desc;

-- Comparison operators (>, =)
-- >, <, >=, <=, =, not equal to: <>, !=
select c.name as category, 
    count(r.rental_id) as rental_count
from rental r, inventory i, film_category fc, category c
where r.inventory_id = i.inventory_id
    and i.film_id = fc.film_id
    and fc.category_id = c.category_id
    and c.name != "Comedy"
group by 1;

-- Customers who have rented at least 3 times
-- Using function with having clause
select c.customer_id as id,
    concat(c.first_name, " ", c.last_name) as name, 
    count(r.rental_id) as rental_count
from customer c, rental r 
where c.customer_id = r.customer_id
group by 1
having count(r.rental_id) > 3;

-- Revenue for store 1 from films rated as R and PG-13
select i.store_id as store_id,
    f.rating as rating, 
    sum(p.amount) as total_revenue
from payment p, rental r, inventory i, film f
where p.rental_id = r.rental_id
    and r.inventory_id = i.inventory_id
    and i.film_id = f.film_id
    and i.store_id = 1
    and f.rating in ("R", "PG-13")
group by 2
order by 3 desc;

-- Limit date range
select i.store_id as store_id,
    f.rating as rating, 
    sum(p.amount) as total_revenue
from payment p, rental r, inventory i, film f
where p.rental_id = r.rental_id
    and r.inventory_id = i.inventory_id
    and i.film_id = f.film_id
    and i.store_id = 1
    and f.rating in ("R", "PG-13")
    and p.payment_date BETWEEN "2005-06-08" and "2005-07-09"
group by 2
order by 3 desc;