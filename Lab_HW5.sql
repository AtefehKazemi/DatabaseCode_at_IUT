/*1*/
select [Name], [Europe], [North America], [Pacific]
FROM
(	SELECT [Production].[Product].[Name], [Sales].[SalesTerritory].[Group],[Sales].[SalesOrderDetail].ProductID
	from [Sales].[SalesOrderHeader] join [Sales].[SalesTerritory] on [Sales].[SalesOrderHeader].TerritoryID = [Sales].[SalesTerritory].TerritoryID
  join [Sales].[SalesOrderDetail] on [Sales].[SalesOrderHeader].SalesOrderID=[Sales].[SalesOrderDetail].SalesOrderID 
  join [Production].[Product] on [Production].[Product].ProductID=[Sales].[SalesOrderDetail].ProductID) a
  PIVOT
  (
	count(ProductID)
	for [Group] in
	([Europe], [North America], [Pacific])
  ) as s




/*2*/
select PersonType, M,F
from(
select Person.BusinessEntityID,PersonType,Gender
from Person.Person join HumanResources.Employee on (Person.BusinessEntityID=Employee.BusinessEntityID) ) a
pivot
(
	COUNT(BusinessEntityID)
	for [Gender] in
	([M],[F])
) AS S


/*3*/
select distinct [Name]
from [Production].[Product]
where len([Name])<15 and left([Name],2) like 'e_'


/*4*/
create function q4 (@givendate varchar(10))
returns varchar(100)
as
begin
declare @year varchar(4), @month varchar(2), @day varchar(2), @ret varchar(100);
if (patindex('[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]',@givendate)=0)
  set @ret='wrong form for date';
else
begin
set @year = substring(@givendate,1,charindex('/',@givendate)-1);
set @month = substring(@givendate,charindex('/',@givendate)+1,charindex('/',right(@givendate,5))-1);
set @day = right(@givendate,2);
set @ret= @day+
case @month
when '01' then 'Farvardin'
when '02' then 'Ordibehesht'
when '03' then 'Khordad'
when '04' then 'Tir'
when '05' then 'Mordad'
when '06' then 'Shahrivar'
when '07' then 'Mehr'
when '08' then 'Aban'
when '09' then 'Azar'
when '10' then 'Dey'
when '11' then 'Bahman'
when '12' then 'Esfand'
end;
SET @ret= @ret+@year;

end;
return @ret;
end;
go

select [dbo].[q4]('13949/12/12')


/*5*/
create function func_q5(@givenyear int, @givenmonth int, @prodname varchar(100))
returns table
as
return
(
	select distinct [Person].[CountryRegion].[Name]
	from [Person].[CountryRegion] join [Sales].[SalesTerritory] on [Person].[CountryRegion].CountryRegionCode = [Sales].[SalesTerritory].CountryRegionCode
	join [Sales].[SalesOrderHeader] on [Sales].[SalesOrderHeader].TerritoryID = [Sales].[SalesTerritory].TerritoryID
	join [Sales].[SalesOrderDetail] on [Sales].[SalesOrderDetail].SalesOrderID = [Sales].[SalesOrderHeader].SalesOrderID
	join [Production].[Product] on [Production].[Product].ProductID=[Sales].[SalesOrderDetail].ProductID
	where [Production].[Product].Name = @prodname and year([Sales].[SalesOrderHeader].ShipDate)= @givenyear
		and @givenmonth=month([Sales].[SalesOrderHeader].ShipDate) 
);
go



select *
from func_q5(2005,7,'Sport-100 Helmet, Red')

