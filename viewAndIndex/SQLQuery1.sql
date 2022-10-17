create view vwProductAndProductSales
as
select s.Name,s.Description,p.QuantitySold,p.UnitPrice from tblProducts s inner join tblProductSales p on s.Id = p.ProductId 
;
select * from vwProductAndProductSales ;

select sum(UnitPrice) from vwProductAndProductSales group by UnitPrice  having sum(UnitPrice)>1200 
--it will give the info about the view
sp_helptext 'vwProductAndProductSales'
--getting view info using OBJECT_DEFINATION()
SELECT OBJECT_DEFINITION(OBJECT_ID('vwProductAndProductSales')) view_info;
--for refreashing view
exec sp_refreshview vwProductAndProductSales

--creating view with schema binding
create view vwProductWithSchemaBin
WITH SCHEMABINDING
as 
--it will bind the given column
select Name,Description from dbo.tblProducts 
--when we try to dop the column it will show error as with have been included the column by schema binding
alter table dbo.tblProducts drop column Name

create view vwDemo
as
select * from dbo.Demo

select * from vwDemo

delete  from vwDemo where userId =123

update vwDemo set userAddress = 5 where userId = 124
--it will rename the view 
EXEC sp_rename 
    @objname = 'vwDemo',
    @newname = 'vwMyDemo';
--it will give list of all views in database
SELECT OBJECT_SCHEMA_NAME(v.object_id) schema_name,v.name FROM sys.views as v;
--it will give the all the view which is start from x
SELECT  OBJECT_SCHEMA_NAME(o.object_id) schema_name, o.name FROM sys.objects as o WHERE o.type = 'x';