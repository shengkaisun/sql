-- fake query
select ac.customer_id, ac.color, rc.points
from active_customers ac 
    join reward_customers rc on rc.customer_id = ac.customer_id
;

-- Left join 
select 
    ac.customer_id, ac.color, rc.points
from 
    active_customers ac
        left join reward_customers rc on ac.customer_id = rc.customer_id
;

-- Join lecture temporary table
-- Create a table that has customer_id, active, and phone_number
create temporary table active_customers -- doesn't work in sqlsnacks
select c.*,
    a.phone
from customer c
    left join address a on c.address_id = a.address_id
where c.active = 1
;

/* 
* Customers with at least 30 rentals
* customer_id, num of rentals, last rental date
*/
create temporary table reward_customers
select customer_id, 
    count(distinct rental_id) as num_rentals,
    max(rental_date) as last_rental_date
from rental
group by 1
having num_rentals >= 30;

/*
* Find reward users who are also active users using join
* Return: customer_id, email, first_name
*/
select
    rc.customer_id as customer_id,
    c.email as email,
    c.first_name as first_name
from 
    (select customer_id, 
        count(distinct rental_id) as num_rentals,
        max(rental_date) as last_rental_date
    from rental
    group by 1
    having num_rentals >= 30) as rc
        inner join customer c on rc.customer_id = c.customer_id
;

/*
* Give all reward users a high five
* Find: customer_id, email, phone (for those who are also active users)
*/
select
    rc.customer_id as customer_id,
    c.email as email,
    c.first_name as first_name, 
    a.phone as phone
from 
    (select customer_id, 
        count(distinct rental_id) as num_rentals,
        max(rental_date) as last_rental_date
    from rental
    group by 1
    having num_rentals >= 30) as rc
        inner join customer c on rc.customer_id = c.customer_id
        left join address a on a.address_id = c.address_id
where
    c.active = 1
;