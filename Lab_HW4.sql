/*2*/
select CASE GROUPING([Sales].[SalesTerritory].[Name])
			WHEN 0 THEN [Sales].[SalesTerritory].[Name]
			WHEN 1 THEN'All Territory'
			END as TerritoryName,
		CASE GROUPING([Sales].[SalesTerritory].[Group])
			WHEN 0 THEN [Sales].[SalesTerritory].[Group]
			WHEN 1 THEN'All Regions'
			END as Region,
	sum([Sales].[SalesOrderHeader].[SubTotal]) as SalesTotal,count([Sales].[SalesOrderHeader].[SalesOrderID]) as SalesCount
from [Sales].[SalesOrderHeader] join [Sales].[SalesTerritory] on ([Sales].[SalesTerritory].[TerritoryID] = [Sales].[SalesOrderHeader].[TerritoryID])
group by rollup ([Sales].[SalesTerritory].[Group],[Sales].[SalesTerritory].[Name])


/*3*/
select case grouping([Production].[ProductSubcategory].[Name])
				when 0 then [Production].[ProductSubcategory].[Name]
				when 1 then 'All Subcategories'
				end as SubQueries,
		case grouping([Production].[ProductCategory].[Name])
			when 0 then [Production].[ProductCategory].[Name]
			when 1 then 'All categories'
			end as Category,
sum([Sales].[SalesOrderHeader].[SubTotal]) as SalesTotal,count([Sales].[SalesOrderHeader].[SalesOrderID]) as SalesCount
from [Production].[ProductCategory] join [Production].[ProductSubcategory] 
		on ([Production].[ProductSubcategory].[ProductCategoryID]=[Production].[ProductCategory].[ProductCategoryID]) 
		join [Production].[Product] on ([Production].[Product].[ProductSubcategoryID] = [Production].[ProductCategory].[ProductCategoryID])
		join [Sales].[SalesOrderDetail] on ([Sales].[SalesOrderDetail].[ProductID]=[Production].[Product].[ProductID])
		join [Sales].[SalesOrderHeader] on ([Sales].[SalesOrderHeader].[SalesOrderID]=[Sales].[SalesOrderDetail].[SalesOrderID])
group by rollup ([Production].[ProductCategory].[Name],[Production].[ProductSubcategory].[Name])

