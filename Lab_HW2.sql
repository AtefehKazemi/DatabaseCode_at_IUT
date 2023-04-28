/*1*/
select sales.SalesOrderHeader.*
from sales.SalesOrderHeader join sales.SalesTerritory   
       on sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID
where sales.SalesTerritory.name = 'France'and sales.SalesOrderHeader.TotalDue>100000 and
sales.SalesOrderHeader.TotalDue<500000
union all
select sales.SalesOrderHeader.*
from sales.SalesOrderHeader join sales.SalesTerritory   
       on sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID
where sales.SalesTerritory.[Group] = 'North America' and sales.SalesOrderHeader.TotalDue>100000 and
sales.SalesOrderHeader.TotalDue<500000



/*2*/

select sales.SalesOrderHeader.SalesOrderID, 
		sales.SalesOrderHeader.CustomerID,
		sales.SalesOrderHeader.TotalDue,
		sales.SalesOrderHeader.OrderDate,
		sales.SalesTerritory.Name
from sales.SalesOrderHeader join sales.SalesTerritory   
       on sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID

/*3*/
select sales.SalesOrderHeader.* into NAmerica_Sales
from sales.SalesOrderHeader join sales.SalesTerritory   
       on sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID
where sales.SalesTerritory.[Group] = 'North America' and sales.SalesOrderHeader.TotalDue>100000 and
sales.SalesOrderHeader.TotalDue<500000


alter table NAmerica_Sales
add q3 char(4) check(q3 in ('low','mid','high'))

select *
from NAmerica_Sales

update NAmerica_Sales
set q3 = case
			when TotalDue > (select avg(TotalDue)from NAmerica_Sales)
			     then 'high'
            when TotalDue = (select avg(TotalDue)from NAmerica_Sales)
			     then 'mid'
			else 'low'
			end 


/*4*/
with q4 (bid,maxr,c) as (
SELECT BusinessEntityID,max(rate), ntile(4) over (order by max(Rate) asc) as c
FROM HumanResources.EmployeePayHistory
GROUP BY BusinessEntityID) 
select bid, case c
					when 1 then maxr+2/10*maxr
					when 2 then maxr+15/100*maxr
					when 3 then maxr+5/100*maxr
					else maxr
					end as new_salary,
			 case 
			        when maxr<29 then 3
					when maxr<50 and maxr>29 then 2
					else 1
					end as [level]
from q4
