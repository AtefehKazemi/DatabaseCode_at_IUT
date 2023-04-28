/****q3-a******/
CREATE VIEW "StuInsView" 
AS (SELECT id,name,
(CASE WHEN dept_name LIKE '%Eng%' THEN 'Engineer' ELSE 'Scientist' END) as DeptType,
'STU' as PersonType 
FROM student )
UNION
(SELECT id,name,
(CASE WHEN dept_name LIKE '%Eng%' THEN 'Engineer' ELSE 'Scientist' END) as
DeptType,
'INS' as PersonType FROM instructor);

/*****q3-b*******/
(SELECT v."name" ,v.PersonType, (ins.salary / d.budget * 100) as calc_number
from "StuInsView" as v JOIN instructor as ins ON ins.id = v.id
JOIN department as d ON d.dept_name = ins.dept_name
WHERE v.PersonType = 'INS')
UNION
(SELECT v."name" , v.PersonType,( d.budget / (SELECT COUNT(*) FROM student WHERE dept_name = stu.dept_name)) as calc_number
from "StuInsView" as v JOIN student as stu ON stu.id = v.id
JOIN department as d ON d.dept_name = stu.dept_name
WHERE v.PersonType = 'STU')

/******q4-a********/
CREATE FUNCTION film_length() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   if new.length>=50 then insert into film(film_id,title,description,release_year,language_id,rental_rate,length,
										  replacement_cost,rating,last_updat,special_features,fulltext)
										  values (new.film_id,new.title,new.description,new.release_year,new.language_id,
										  new.rental_rate,new.length,new.replacement_cost,new.rating,new.last_updat,
												  new.special_features,new.fulltext);	
   else
	rollback;
   end if;

   RETURN NEW;
END;
$$


CREATE TRIGGER insert_to_film
BEFORE INSERT
on film
FOR EACH ROW
EXECUTE PROCEDURE film_length();

/********q4-b*********/
alter table payment
add column pay_type varchar(12)

CREATE FUNCTION pay_type_function4() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
   if new.pay_type in ('credit_card','cash','online') then insert into payment(payment_id,customer_id,staff_id,rental_id,amount,payment_date,pay_type)
										  values (new.payment_id,new.customer_id,new.staff_id,new.rental_id,new.amount,new.payment_date,new.pay_type);	
  
   else
	rollback;
    end if;
   RETURN NEW;
END;
$$

CREATE TRIGGER insert_to_payment
BEFORE INSERT
on payment
FOR EACH ROW
EXECUTE PROCEDURE pay_type_function4();

insert into payment(payment_id,customer_id,staff_id,rental_id,amount,payment_date,pay_type)
	values (2001,1,1,1,222,'2007-02-15 22:25:46.996577','bbb');	

/*************q5*************/
INSERT INTO public.department(dept_name,building,budget)VALUES
		('medical','Pasteur',700000),('dental','Pasteur',800000)


UPDATE public.department SET budget= case
	when dept_name='dental' then 800000+(700000*0.01)
	when dept_name = 'medical' then 700000-(700000*0.01)
	end;
commit;

/*------OR-------*/

CREATE PROCEDURE update_budget()
LANGUAGE plpgsql AS
$$
DECLARE medical_budget int;
BEGIN
SELECT budget INTO medical_budget
FROM department
WHERE dept_name='medical' ;
UPDATE department SET budget=budget+(medical_budget*(0.01))
WHERE dept_name='dental';
UPDATE department SET budget = budget-(medical_budget*(0.01))
WHERE dept_name='medical';
COMMIT;
END;
$$;

call  update_budget()

select dept_name,building,budget
from department
where dept_name='medical' or dept_name='dental'



/************q6*****************/
CREATE FUNCTION _Func_Q6(actorID int)
RETURNS TABLE (filmID int,filmTitle VARCHAR(255), rentNum bigint) 
LANGUAGE plpgsql AS
$$
BEGIN
RETURN QUERY SELECT film.film_id as filmID,title as filmTitle, count(rental_id) as rentNum
from actor join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id = inventory.inventory_id
where actor.actor_id=actorID
group by film.film_id,title;
end;
$$;
					   
select * from _Func_Q6(1)					   

/************q7****************/
CREATE PROCEDURE update_films(film1 VARCHAR(255), film2 VARCHAR(255))
LANGUAGE plpgsql AS
$$
DECLARE film1_replacement_cost numeric(5,2);
DECLARE film2_replacement_cost numeric(5,2);
BEGIN
SELECT replacement_cost INTO film1_replacement_cost
FROM film
WHERE title = film1;
SELECT replacement_cost INTO film2_replacement_cost
FROM film
WHERE title = film2;
UPDATE film SET replacement_cost = film2_replacement_cost+(film1_replacement_cost*0.05)
WHERE title = film2;
UPDATE film SET replacement_cost = film1_replacement_cost-(film1_replacement_cost*0.05)
WHERE title = film1;
COMMIT;
END;
$$;

call update_films ('Analyze Hoosiers','Angels Life')

select title, replacement_cost
from film
where title = 'Analyze Hoosiers' or title = 'Angels Life'

/***********q8************/
alter table public.customer
add column Count_Check int default 0

CREATE OR REPLACE FUNCTION _func_Q8()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
DECLARE Tcount int;
BEGIN

select Count_Check into Tcount
from customer
where customer_id=NEW.customer_id;

if Tcount <2 then
update customer
set Count_Check=Count_Check+1
where customer_id=NEW.customer_id;
ELSIF Tcount = 2 THEN

with find_rental_id as(
select rental_id from rental
where customer_id= new.customer_id
order by rental_date desc
limit 1 offset 1)

update rental set return_date=return_date+INTERVAl '7' DAY
where rental_id=(select rental_id from find_rental_id) and customer_id=new.customer_id;


update customer
set Count_Check=0
where customer_id=NEW.customer_id;
end if;
RETURN NEW;
END;
$$

CREATE TRIGGER RentTrigger
AFTER INSERT
ON rental
FOR EACH ROW
WHEN (pg_trigger_depth() < 1)
EXECUTE PROCEDURE _func_Q8();

drop trigger RentTrigger on rental



/*----------*/
insert into rental(rental_date,inventory_id,customer_id, return_date, staff_id)
values( NOW(), 4, 1,NOW()+INTERVAl '1 WEEK', 1);

insert into rental(rental_date,inventory_id,customer_id, return_date, staff_id)
values( NOW(), 3, 1,NOW()+INTERVAl '1 WEEK', 1);

insert into rental(rental_date,inventory_id,customer_id, return_date, staff_id)
values( NOW(), 2, 1,NOW()+INTERVAl '1 WEEK', 1);


select * from rental
where customer_id=1


select * from customer
where customer_id=1




/**********q9************/
select f.title as film_name , f.rating as film_rating,
rank() over (order by sum(amount) desc) as rank_in_all,
rank() over (partition by f.rating order by sum(amount) desc) as rank_in_rating,
sum(amount) as sum_amount,
(case
when (ntile(4) over (order by sum(amount) desc)) = 1 then 'YES'
else 'NO'
end) as is_in_first_quartile
from payment as p join rental as r on r.rental_id = p.rental_id
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY f.title

/***************q10**************/
select extract(month from payment_date) as monthNum,f.rating,
sum(amount) as sum_amount,
lag(sum(amount),1) over (partition by f.rating order by
extract(month from payment_date)) preMonth_sales,
lead(sum(amount),1) over (partition by f.rating order by
extract(month from payment_date)) nextMonth_sales
from payment as p join rental as r on r.rental_id = p.rental_id
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id
GROUP BY monthNum,f.rating
ORDER BY monthNum;