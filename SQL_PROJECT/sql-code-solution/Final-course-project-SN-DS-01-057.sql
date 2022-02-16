#FINAL COURSE PROJECT
#1
select store.Store_id, staff.First_name,staff.Last_name,address.Address as Street_Address,address.District,city.City,country.Country from store join staff on store.manager_staff_id = staff.staff_id 
join address on staff.address_id = address.address_id join city on address.city_id = city.city_id 
join country on city.country_id = country.country_id;

#2
select inventory.Store_id,inventory.inventory_id,film.Title, film.Rating,film.Rental_rate,film.Replacement_cost
from inventory left join film on film.film_id = inventory.film_id group by inventory.inventory_id;

#3
select inventory.Store_id, film.Title,count(film.title) as Total_item_number,film.Rating from inventory left join film on film.film_id = inventory.film_id
group by film.title, store_id;


#4

select inventory.Store_id,count((inventory.film_id)) as Number_of_films,category.name as Category, 
round(avg(film.replacement_cost),2) as Average_replacement_cost ,sum(film.replacement_cost) 
as Total_replacement_cost from inventory join film on inventory.film_id = film.film_id join film_category on 
film.film_id = film_category.film_id join category on film_category.category_id = category.category_id
group by inventory.store_id,category.name ;

#5
select First_name, Last_name,Store_id,address.Address as Street_Address,city.City,country.Country,case when active = 1 then 'active' else 'not active'end as Current_status 
from customer join address on customer.address_id = address.address_id join city
 on address.city_id = city.city_id join country on city.country_id = country.country_id where active =1;
 

#6
select customer.first_name,customer.last_name ,count(payment.customer_id) as Total_lifetime_rentals, sum(payment.amount) as Sum_of_payment
from customer left join payment on customer.customer_id = payment.customer_id group by payment.customer_id order by sum(payment.amount) desc;

#7
select investor.First_name,investor.Last_name,case when investor.investor_id = 1 
then 'Investor' else 'Investor' end as Company_role,investor.Company_name
from investor
union all select advisor.first_name,advisor.last_name, 'Advisor' as Company_role ,'None' as Company_name
 from advisor;
 
 SET GLOBAL log_bin_trust_function_creators = 1;
  #8a
delimiter $$
 create function num_of_3awards_actors() returns int begin declare num int; select count(actor_id) from 
 actor_award where 
 actor_id is not null and (awards like '%Emmy%' and awards like '%Oscar%' and awards like '%Tony%') into num;
 return num ;
 end$$
delimiter ;

 select film.title,round((count(actor_award.actor_id)/num_of_3awards_actors()*100),2) as 
 Percentage_of_actors_with_3_awards, actor_award.awards from  
 actor_award join film_actor on film_actor.actor_id = actor_award.actor_id join film on 
 film.film_id = film_actor.film_id 
 where awards like '%Emmy%' and awards like '%Oscar%' and awards like '%Tony%'group by title;



 
  
#8b
 delimiter $$
 create function num_of_2awards_actors() returns int begin declare num int; select count(actor_id) from actor_award where actor_id is not null and
  ((awards like '%Emmy%' and awards like '%Oscar%' and awards not like '%Tony%')or
 (awards like '%Tony%' and awards like '%Oscar%' and awards not like '%Emmy%') or 
 (awards like '%Emmy%' and awards like '%Tony%'and awards not like '%Oscar%')) into num;
 return num ;
 end$$
delimiter ;

select film.Title,round((count(actor_award.actor_id)/num_of_2awards_actors()*100),2) as
 Percentage_of_actors_with_2_awards,actor_award.Awards from  
 actor_award join film_actor on film_actor.actor_id = actor_award.actor_id join film on 
 film.film_id = film_actor.film_id 
 where (awards like '%Emmy%' and awards like '%Oscar%' and awards not like '%Tony%')or
 (awards like '%Tony%' and awards like '%Oscar%' and awards not like '%Emmy%') or
 (awards like '%Emmy%' and awards like '%Tony%'and awards not like '%Oscar%')group by title;
 
 
 #8c
 delimiter $$
 create function num_of_1award_actors() returns int begin declare num int; select count(actor_id) from actor_award 
 where 
 actor_id is not null and ((awards like '%Emmy%' and awards not like '%Oscar%' and awards not like '%Tony%')or
 (awards like '%Tony%' and awards not like '%Oscar%' and awards not like '%Emmy%') or (awards like '%Oscar%' 
 and awards not like '%Tony%'and awards not like '%Emmy%')) into num;
 return num ;
 end$$
delimiter ;

select film.Title,round((count(actor_award.actor_id)/num_of_1award_actors()*100),2) as 
Percentage_of_actors_with_1_award,actor_award.Awards
 from actor_award join film_actor on film_actor.actor_id = actor_award.actor_id join film on
 film.film_id = film_actor.film_id 
 where (awards like '%Emmy%' and awards not like '%Oscar%' and awards not like '%Tony%')or
 (awards like '%Tony%' and awards not like '%Oscar%' and awards not like '%Emmy%') or (awards like '%Oscar%' and 
 awards not like '%Tony%'and awards not like '%Emmy%')group by title;
 
 

