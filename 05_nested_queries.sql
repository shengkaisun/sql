-- Customers who rented 20+ times
select customer_id, 
    count(rental_id)
from rental r 
group by 1
having count(rental_id) > 20
order by 2 desc;

-- Nested query
-- Revenue for customers who have 20 or more rentals 
select 
    rental_per_customer.num_rentals as num_rentals,
    count(distinct p.customer_id) as num_customers,
    sum(p.amount) as total_revenue
from
    (select customer_id, 
        count(distinct rental_id) as num_rentals
    from rental 
    group by 1) as rental_per_customer, 
    payment p
where 
    rental_per_customer.customer_id = p.customer_id
    and rental_per_customer.num_rentals >= 20 
group by 
    1;