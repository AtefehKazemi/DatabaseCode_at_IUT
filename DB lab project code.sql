------creation and insertion
create table parking
	(
		parkingID int primary key,
		name varchar(50),
		address varchar(300),
		available int check (available in (0,1)),
		totalFloors int
	)
	
create table floors
	(
		floorID int primary key,
		numberOfFloor int,
		totalSlots int,
		parkingID int,
		foreign key (parkingID) references parking(parkingID)

	)

	
create table parking_slot
	(
		parking_slotID int primary key,
		IsEmpty int check(IsEmpty in (0,1)) default 1,
		price float not null,
		floorID int,
		foreign key (floorID) references floors(floorID)
	)
	
create table customer
	(
		customerID int primary key,
		name varchar(100) Not null,
		carNum char(8) UNIQUE,
		registrationDate datetime,
		phoneNum char(11)
	)

	
create table parking_customer
	(
		parking_customerID int primary key,
		customerID int,
		parkingID int,
		foreign key (parkingID) references parking(parkingID),
		foreign key (customerID) references customer(customerID)
	)

create table payment
	(
		paymentID int primary key,
		paymentDate datetime,
		amount float,
		paymentMethod varchar(6) check(paymentMethod in ('cash','online'))
		
	)
	
create table parking_slot_reservation
	(
		parking_slot_reservationID int primary key,
		customerID int,
		parking_slotID int,
		startDate datetime,
		endDate datetime,
		paymentamount float,
		foreign key (customerID) references customer(customerID),
		foreign key (parking_slotID) references parking_slot(parking_slotID)
	) 

create table reservation_payment
	(
		reservation_payment_id int primary key,
		parking_slot_reservationID int,
		paymentID int,
		foreign key (parking_slot_reservationID) references parking_slot_reservation(parking_slot_reservationID),
		foreign key (paymentID) references payment(paymentID)
	)


/*********************************insertion************************************/

insert into parking values (1,'p1','esfahan',1,5)
insert into parking values (2,'p2','tehran',1,10)
insert into parking values (3,'p3','yazd',0,5)
insert into parking values (4,'p3','Semnan',0,4)



insert into floors values (1,1,3,1);
insert into floors values (2,2,3,1);
insert into floors values (3,3,3,1);
insert into floors values (4,4,3,1);
insert into floors values (5,5,3,1);
insert into floors values (6,1,5,2);
insert into floors values (7,2,5,2);
insert into floors values (8,3,5,2);
insert into floors values (9,4,5,2);
insert into floors values (10,5,5,2);
insert into floors values (11,1,5,2);
insert into floors values (12,2,5,2);
insert into floors values (13,3,5,2);
insert into floors values (14,4,5,2);
insert into floors values (15,5,5,2);

insert into parking_slot values (1,0,23000,1);
insert into parking_slot values (2,0,23000,1);
insert into parking_slot values (3,0,23000,1);
insert into parking_slot values (4,0,23000,2);
insert into parking_slot values (5,0,23000,2);
insert into parking_slot values (6,0,23000,2);
insert into parking_slot values (7,1,23000,3);
insert into parking_slot values (8,0,23000,3);
insert into parking_slot values (9,1,23000,3);
insert into parking_slot values (10,1,23000,4);
insert into parking_slot values (11,1,23000,4);
insert into parking_slot values (12,1,23000,4);
insert into parking_slot values (13,1,23000,5);
insert into parking_slot values (14,1,23000,5);
insert into parking_slot values (15,1,23000,5);

insert into parking_slot values (16,1,60000,6);
insert into parking_slot values (17,0,60000,6);
insert into parking_slot values (18,1,60000,6);
insert into parking_slot values (19,0,60000,6);
insert into parking_slot values (20,0,60000,6);
insert into parking_slot values (21,0,60000,7);
insert into parking_slot values (22,1,60000,7);
insert into parking_slot values (23,0,60000,7);
insert into parking_slot values (24,0,60000,7);
insert into parking_slot values (25,0,60000,7);
insert into parking_slot values (26,0,60000,8);
insert into parking_slot values (27,0,60000,8);
insert into parking_slot values (28,0,60000,8);
insert into parking_slot values (29,0,60000,8);
insert into parking_slot values (30,0,60000,8);
insert into parking_slot values (31,0,60000,9);
insert into parking_slot values (32,0,60000,9);
insert into parking_slot values (33,0,60000,9);
insert into parking_slot values (34,0,60000,9);
insert into parking_slot values (35,0,60000,9);
insert into parking_slot values (36,0,60000,10);
insert into parking_slot values (37,0,60000,10);
insert into parking_slot values (38,0,60000,10);
insert into parking_slot values (39,0,60000,10);
insert into parking_slot values (40,0,60000,10);
insert into parking_slot values (41,0,60000,11);
insert into parking_slot values (42,0,60000,11);
insert into parking_slot values (43,0,60000,11);
insert into parking_slot values (44,0,60000,11);
insert into parking_slot values (45,0,60000,11);
insert into parking_slot values (46,0,60000,12);
insert into parking_slot values (47,1,60000,12);
insert into parking_slot values (48,1,60000,12);
insert into parking_slot values (49,0,60000,12);
insert into parking_slot values (50,1,60000,12);
insert into parking_slot values (51,1,60000,13);
insert into parking_slot values (52,1,60000,13);
insert into parking_slot values (53,1,60000,13);
insert into parking_slot values (54,1,60000,13);
insert into parking_slot values (55,1,60000,13);
insert into parking_slot values (56,1,60000,14);
insert into parking_slot values (57,1,60000,14);
insert into parking_slot values (58,1,60000,14);
insert into parking_slot values (59,1,60000,14);
insert into parking_slot values (60,1,60000,14);
insert into parking_slot values (61,1,60000,15);
insert into parking_slot values (62,1,60000,15);
insert into parking_slot values (63,1,60000,15);
insert into parking_slot values (64,1,60000,15);
insert into parking_slot values (65,1,60000,15);


insert into customer values (1,'ali','12b12313','2022-01-04','09131234567');
insert into customer values (2,'reza','13b45613','2020-02-20','09364532121');
insert into customer values (3,'kazemi','15b78913','1999-12-07','09138765432');
insert into customer values (4,'mohammad','16b43233','2020-05-09','09373456712');
insert into customer values (5,'ahmadi','17b78233','2010-09-10','09130987654');
insert into customer values (6,'moradi','19b45722','2000-11-09','09131234987');

insert into parking_customer values (1,1,1);
insert into parking_customer values (2,1,2);
insert into parking_customer values (3,2,1);
insert into parking_customer values (4,3,2);
insert into parking_customer values (5,4,1);
insert into parking_customer values (6,4,2);
insert into parking_customer values (7,5,1);
insert into parking_customer values (8,6,1);
insert into parking_customer values (9,6,2);

insert into payment values (1,'2022-01-04',120000,'online');
insert into payment values (2,'2022-01-8',120000,'online');
insert into payment values (3,'2020-01-10',23000,'online');
insert into payment values (4,'2022-01-15',60000,'cash');
insert into payment values (5,'2022-01-15',575000,'cash');
insert into payment values (6,'2022-01-18',57500,'cash');
insert into payment values (7,'2021-12-19',23000,'cash');
insert into payment values (8,'1999-12-29',240000,'online');


-- paymentamount of reservations are 0 now and then in a trigger I will update them
insert into parking_slot_reservation values (1,1,16,'2022-01-04','2022-01-08',0);
insert into parking_slot_reservation values (2,1,1,'2020-01-10','2020-01-11',0);
insert into parking_slot_reservation values (3,2,3,'2022-01-15','2022-01-16',0);
insert into parking_slot_reservation values (4,3,22,'2022-01-15','2022-01-20',0);
insert into parking_slot_reservation values (5,6,5,'2021-12-19','2021-12-20',0);
insert into parking_slot_reservation values (6,5,22,'1999-12-29','2000-01-03',0);
insert into parking_slot_reservation values (7,3,20,'2001-10-29','2001-11-01',0);



insert into reservation_payment values (1,1,1);
insert into reservation_payment values (2,1,2);
insert into reservation_payment values (3,2,3);
insert into reservation_payment values (4,3,4);
insert into reservation_payment values (5,4,5);
insert into reservation_payment values (6,4,6);
insert into reservation_payment values (7,5,7);
insert into reservation_payment values (8,6,8);



------Functions:

------1: This function returns information of available parking slots of a specific parking floor in a specific date:
------so input is a parkingID, floorID, startDate and endDate. output is a table containing information of available parking slots:

CREATE FUNCTION available_parking_slots
	( @parking_id int, @floor_id int, @start datetime, @end datetime)
	RETURNS TABLE
	AS
	RETURN
	(
		with table_1 as(
		select s1.parking_slotID
		from parking_slot as s1 inner join floors as f1 on s1.floorID=f1.floorID
			inner join parking as pr1 on f1.parkingID=pr1.parkingID
		where pr1.parkingID = @parking_id and f1.floorID = @floor_id
		except
		select s2.parking_slotID
		from parking_slot s2 join parking_slot_reservation p on s2.parking_slotID = p.parking_slotID
		where p.startDate>@end and p.endDate<@start
		)

		select s1.parking_slotID, s1.floorID, s1.IsEmpty, s1.price
		from parking_slot s1 inner join table_1 s2 on s1.parking_slotID = s2.parking_slotID
	);
	
select * from available_parking_slots(1 , 5 , '2021-12-19' , '2021-12-20');



------2: This function returns all parkings' information with specific name
------ so the input is a parking name:

CREATE FUNCTION parking_name
	( @parking_name varchar(50))
	RETURNS TABLE
	AS
	RETURN
	(
		select parkingID, name, address, available, totalFloors, 0 as TotalEmptySlots
		from parking
		where name =  @parking_name
		union
		select parking.parkingID, name, address, available, totalFloors , count(parking_slotID) as TotalEmptySlots
		from parking join floors on parking.parkingID=floors.parkingID 
		join parking_slot on parking_slot.floorID=floors.floorID
		where IsEmpty=1 and name =  @parking_name
		group by parking.parkingID, name, address, available, totalFloors
		
	);
	
select * from parking_name('p3');



--------3: This function returns parking's number of empty slots
--------Input is a parking id and output is parking's number of empty slots
CREATE FUNCTION parking_TotalEmptySlots
	( @parking_id int)
	RETURNS int
	AS
	begin
	declare @ret int 
	set @ret= (select count(parking_slotID)
		from parking join floors on parking.parkingID=floors.parkingID 
		join parking_slot on parking_slot.floorID=floors.floorID
		where IsEmpty=1 and  parking.parkingID= @parking_id
		)
	return @ret
	end
	
select dbo.parking_TotalEmptySlots(3)

------4: This function returns all parkings' information that a specific customer is registered in 
------ so the input is a customer id:
CREATE FUNCTION parking_list
	( @customer_id int)
	RETURNS TABLE
	AS
	RETURN
	(
		select distinct parking.parkingID, parking.name, parking.address, parking.available, parking.totalFloors, dbo.parking_TotalEmptySlots(parking_customer.parkingID ) as TotalEmptySlots
		from parking_slot_reservation inner join customer on parking_slot_reservation.customerID=customer.customerID
		inner join parking_customer on customer.customerID=parking_customer.customerID 
		inner join parking on parking.parkingID=parking_customer.parkingID 

		where customer.customerID = @customer_id
	);

select * from parking_list(1);



------stored procedures:

------1: This stored procedure returns information of all customers of a specific parking:
------so input is a parkingID and output is a table containing information of its customers:

create procedure parking_customers
@parkingID int
as
begin
select distinct (customer.customerID), customer.name, carNum, registrationDate, phoneNum
from parking_customer inner join customer on parking_customer.customerID=customer.customerID
where parking_customer.parkingID=@parkingID
end


exec parking_customers 1



------2: This stored procedure returns average payment of each parking:
------so it doesnt have any input:

create procedure average_payment
as
begin
select parking.parkingID, parking.name as parking_name, avg(amount) as payment_average
from payment inner join reservation_payment on payment.paymentID = reservation_payment.paymentID
inner join parking_slot_reservation on parking_slot_reservation.parking_slot_reservationID = reservation_payment.parking_slot_reservationID
inner join parking_slot on parking_slot_reservation.parking_slotID = parking_slot.parking_slotID 
inner join floors on parking_slot.floorID = floors.floorID
inner join parking on parking.parkingID=floors.parkingID
group by parking.parkingID, parking.name
end


exec average_payment

------3: This stored procedure returns the last customer of a specific parking slot:
------so it gets a slot id and returns its last customer:

CREATE PROCEDURE last_customerID
@slot_id int, 
@lastCustomerID int output
AS
BEGIN
	SET NOCOUNT ON;
    set @lastCustomerID =(SELECT TOP 1 customerID 
	                     FROM parking_slot_reservation inner join parking_slot on parking_slot_reservation.parking_slotID = parking_slot.parking_slotID
						 and parking_slot.parking_slotID=@slot_id
	                     ORDER BY parking_slot_reservationID DESC )
END
GO


declare @lastCustomerID int
execute last_customerID 22,@lastCustomerID output
select @lastCustomerID


------triggers:

------1: This trigger calcute the price of reservation after each insert:

create trigger paymentamount_reservation
on parking_slot_reservation
after insert
as
begin
update parking_slot_reservation set paymentamount = price * convert(int ,(inserted.endDate - inserted.startDate))
              from parking_slot inner join parking_slot_reservation on parking_slot_reservation.parking_slotID = parking_slot.parking_slotID
			  inner join inserted on  parking_slot_reservation.parking_slot_reservationID = inserted.parking_slot_reservationID
end


------2: This trigger check amount of payment after insert, if Total paid amount is lager than price of reservation ,Alarm message is print:

create trigger check_amount
on payment
after update
as
begin
if (select sum(amount) 
    from payment, reservation_payment
    where  reservation_payment.paymentID = payment.paymentID and
          reservation_payment.parking_slot_reservationID = (select parking_slot_reservationID
                                                from inserted, reservation_payment
												where inserted.paymentID = reservation_payment.paymentID))
    +(select inserted.amount 
    from inserted) > (select paymentamount
                      from parking_slot_reservation, inserted, reservation_payment
					  where reservation_payment.paymentID = inserted.paymentID and
					        reservation_payment.parking_slot_reservationID = parking_slot_reservation.parking_slot_reservationID)

	PRINT N'Alarm! The amount deposited is more than required.'; 
end 


------3: These triggers save changes of payment table:

CREATE TABLE PaymentLogs(
	paymentID int,
	amount int, 
	paymentDate datetime,
	paymentMethod varchar(6),
	change varchar(20))

create trigger payment_insert
on payment
after insert
as
begin
insert into PaymentLogs(paymentID,amount,paymentDate,paymentMethod,change)
select paymentID,amount,paymentDate,paymentMethod,'insert' 
from inserted
end

create trigger payment_delete
on payment
after delete
as
begin
insert into PaymentLogs(paymentID,amount,paymentDate,paymentMethod,change)
select paymentID,amount,paymentDate,paymentMethod,'delete' 
from deleted
end

create trigger payment_update
on payment
after update
as
begin
insert into PaymentLogs(paymentID,amount,paymentDate,paymentMethod,change)
select paymentID,amount,paymentDate,paymentMethod,'update' 
from inserted
end


------views:

-------1: This view shows information about all reservations that have not been paid in full
create view view_reservation as
with table1 as(
select parking_slot_reservation.parking_slot_reservationID, sum(amount) as total_pay
from parking_slot_reservation, payment, reservation_payment
where parking_slot_reservation.parking_slot_reservationID  = reservation_payment.parking_slot_reservationID and
      payment.paymentID = reservation_payment.paymentID
group by parking_slot_reservation.parking_slot_reservationID)

select parking_slot_reservation.parking_slot_reservationID, customerID, parking_slotID, startDate, endDate, paymentamount , total_pay as paidAmount
from parking_slot_reservation join table1 on parking_slot_reservation.parking_slot_reservationID = table1.parking_slot_reservationID
where paymentamount > total_pay
union  
select parking_slot_reservation.parking_slot_reservationID, customerID, parking_slotID, startDate, endDate, paymentamount , 0 as paidAmount
from parking_slot_reservation
where parking_slot_reservationID not in (select parking_slot_reservationID from reservation_payment);


select* from view_reservation

-------2:This view shows the total amount of payment in each parking:
create view parking_total_payment as(
select pr.parkingID, name, address, sum(amount) as sum_payments
from payment p inner join reservation_payment on p.paymentID = reservation_payment.paymentID
	inner join parking_slot_reservation r on r.parking_slot_reservationID=reservation_payment.parking_slot_reservationID
	inner join parking_slot s on r.parking_slotID = s.parking_slotID 
	inner join floors f on s.floorID = f.floorID
	inner join parking pr on pr.parkingID = f.parkingID
group by pr.parkingID, name, address)

select* from parking_total_payment


-------3:This view shows the number of empty slots in each parking floor using rollup
create view empty_slots_num as(
select 
case GROUPING(numberOfFloor)
	when 0 then numberOfFloor
	when 1 then pr.totalFloors
end as numberOfFloor,pr.parkingID,

count(s.parking_slotID) as empty_slots_num
from parking_slot s inner join floors f on s.floorID=f.floorID
	inner join parking pr on f.parkingID=pr.parkingID
where s.IsEmpty=1
group by pr.parkingID, pr.totalFloors, rollup(numberOfFloor))

select* from empty_slots_num


