-- Customer ID, name, address 
select customer_id, first_name, last_name, address.address
from customer, address 
where customer.address_id = address.address_id;

-- Film name, category, and language
select f.title as name, fc.category_id as category_id, c.name as cateogry, l.name as lanauge
from film f, film_category fc, language l, category c
where f.film_id = fc.film_id and f.language_id = l.language_id and 
    c.category_id = fc.category_id;