#MID COURSE PROJECT
#1
SELECT 
    First_name, Last_name, Email, Store_id
FROM
    staff ;
    
#2
SELECT 
    COUNT(inventory_id) AS Inventory_count, Store_id
FROM
    inventory
GROUP BY store_id;

#3
SELECT 
    COUNT(customer_id) AS Num_of_customers, Store_id, case when active = 1 then "active" end as Current_status
FROM
    customer where active = 1
GROUP BY store_id;

#4
SELECT 
    COUNT(DISTINCT (email)) AS No_of_customer_emails
FROM
    customer;
    
#5a
SELECT 
    inv.Store_id, COUNT(DISTINCT (fm.title)) AS Film_title_count
FROM
    inventory inv
        LEFT JOIN
    film fm ON fm.film_id = inv.film_id
GROUP BY store_id;



#5b
select count(name) AS Num_of_movie_categories from category;

#6
select max(replacement_cost) as Highest_movie_replacement_cost, min(replacement_cost) as Lowest_movie_replacement_cost, AVG(replacement_cost) from film;

#7
select avg(amount) as Average_Process_Amount, max(amount) as Max_Processed_Amount from payment;

#8
select cus.Customer_id , count(ren.customer_id) as Num_of_rentals from customer cus left join rental ren on cus.customer_id
= ren.customer_id group by cus.customer_id order by Num_of_rentals desc;
