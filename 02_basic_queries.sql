-- Get rental rate > $0.99 from titles 
SELECT title, rental_rate
FROM film
WHERE rental_rate > .99
;


select first_name, last_name, email, store_id
from customer
where store_id = 1;

-- Count function
select count(title) 
from film
where rental_rate = .99;

-- Group by category
select count(title), rental_rate
from film
group by rental_rate;

select count(title), rental_rate
from film
group by 2; -- 2 means group by the 2nd column 

-- which rating has the most films 
select count(film_id), rating 
from film
group by rating;

-- Which rating is most prevalent in each price (use only 1 query)?
select rental_rate, count(film_id), rating
from film
group by rental_rate, rating
order by 1, 2 desc;

