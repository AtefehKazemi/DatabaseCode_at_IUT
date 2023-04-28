EXEC sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
RECONFIGURE;  
GO

/*1*/
EXEC xp_cmdshell 'bcp AdventureWorks2012.Sales.SalesTerritory out "C:\Users\g\Desktop\q1.txt" -T -c -t"|"'


create table SalesTerritoryNew
(
    [TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Group] [nvarchar](50) NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
    PRIMARY KEY ([TerritoryID]),
);

BULK insert [dbo].[SalesTerritoryNew] from "C:\Users\g\Desktop\q1.txt" 
with (FIELDTERMINATOR='|')

select *
from [dbo].[SalesTerritoryNew]

/*2*/
EXEC xp_cmdshell 'bcp "select [Name],[TerritoryID] from [AdventureWorks2012].[Sales].[SalesTerritory]" queryout "C:\Users\g\Desktop\q2.txt" -T -c -t"|"'


/*3*/
EXEC xp_cmdshell 'bcp AdventureWorks2012.[Production].[Location] out "C:\Users\g\Desktop\location.dat" -T -c -t"|"'

/*4*/
create table xmltable2(
 [Name] [dbo].[Name] NOT NULL,
 [ModifiedDate] [xml] NOT NULL,
 [SalesPersonCount] [xml] NULL,
 [SalesPerYear] [xml]
);

insert into xmlTable2 SELECT [Name],[Demographics].query('
declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
for $S in /StoreSurvey
return
<yearopen>
{$S/YearOpened}
</yearopen>'
) as YearOpened, [Demographics].query('
  declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
  for $S in /StoreSurvey
  return
  <EmployeesNumber>
  {$S/NumberEmployees}
</EmployeesNumber>'
)as NumberEmployees, [Demographics].query('
  declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
  for $S in /StoreSurvey
  return
  <SalesPerYear>
  {$S/AnnualSales}
</SalesPerYear>' ) as AnnualSales
from [Sales].[Store]


EXEC xp_cmdshell 'bcp AdventureWorks2012.[dbo].[xmltable2] out "C:\Users\g\Desktop\xmltest.txt" -T -c -t"|"'
