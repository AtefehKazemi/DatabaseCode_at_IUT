/*1*/
create login HW3
with password = '123'

create server role role1;
grant create any  database
to role1

grant alter any  database
to role1

grant connect any  database
to role1

alter server role role1
add member HW3

use AdventureWorks2012
go
CREATE TABLE hw3_TABLE (
id char(4) primary key,
name varchar(10)
)

insert into hw3_TABLE (id,name) values ('1111','a1')
insert into hw3_TABLE (id,name) values ('2222','a2')

select * from hw3_TABLE


/*2*/
use AdventureWorks2012
go
create role role22;
alter role db_securityadmin
add member role22

grant select
to role22






