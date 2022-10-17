--function
CREATE FUNCTION AddDigit(@num1 int , @num2 int)
RETURNS int
as
begin 
Declare @result int
Set @result = @num1 + @num2
RETURN @result
end
--for calling it write schema name , if try without writing schema name it will try to find out in built function
select dbo.AddDigit(678,45)
select dbo.AddDigit('678',45)
/*
multi valued table function
it can contain BEGIN-END block
In a multi-statement table valued function the return value is declared as a table variable and includes
the full structure of the table to be return 
*/
create function GetAllStudents(@RollNo int)
RETURNS @Marksheet Table (studentName varchar(20),RollNo int,Eng int,Math int,sci int,Average Decimal(4,2))

as 
begin
DECLARE @Percentage decimal (4,2);
DECLARE @studentName varchar(30);
SELECT @studentName = student_name from student where RollNo=@RollNo
select @Percentage = ((Eng+Math+Science)/3) from student_marks where RollNo =@RollNo

insert into @Marksheet (studentName,RollNo,Eng,Math,Sci,Average)
select @studentName,RollNo,Eng,Math,Science,@Percentage from student_marks where RollNo=@RollNo

RETURN 
END

--Aggregate function
SELECT CAST(ROUND(AVG(list_price),2) AS DEC(10,3)) avg_product_price
FROM production.products;
 --STDEV it will give the returns the statistical standard deviation of all values provided in the expression based on a sample of the data population.
 SELECT CAST(ROUND(STDEV(list_price),2) as DEC(10,2)) stdev_list_price
FROM production.products;
--ROW_NUMBER function assigns sequential integer for each row
--ROW_NUMBER function must have an over clause 
SELECT ROW_NUMBER() OVER (order by first_name) as row_num,
   first_name, 
   last_name, 
   city
FROM sales.customers;
/*The PARTITION BY clause divides the result set into partitions (another term for groups of rows).
The ROW_NUMBER() function is applied to each partition separately and reinitialized the row number for each partition. */
SELECT first_name,last_name, city,
   ROW_NUMBER() OVER (PARTITION BY city ORDER BY first_name) row_num
FROM sales.customers
ORDER BY 
   row_num

/*
The RANK() function is a window function that assigns a rank to each row within a partition of a result set.
*/
CREATE TABLE sales.rank_demo (
	v VARCHAR(10)
);
INSERT INTO sales.rank_demo(v)
VALUES('A'),('B'),('B'),('C'),('C'),('D'),('E');

SELECT v FROM sales.rank_demo;
--here  b is at two  place so it will give same rank to both the row
select v, RANK() OVER (ORDER BY V) rank_name
from sales.rank_demo
--here rank will fix as per price list
SELECT product_id,product_name,list_price,
	RANK () OVER (ORDER BY list_price DESC) price_rank 
FROM production.products;
/*the PARTITION BY clause divides the products into partitions by brand Id.
the ORDER BY clause sorts products in each partition by list prices.
the outer query returns the products whose rank values are less than or equal to three.
*/
SELECT * FROM (SELECT product_id,product_name,brand_id,list_price,RANK () OVER ( PARTITION BY brand_id
	ORDER BY list_price DESC) price_rank 
	FROM production.products) t
WHERE price_rank <= 3;

/* 
NTILE() function  divide result in number of bucket/group it will try to divide rows in eqal group
for this order by clause is required 
*/
CREATE TABLE sales.ntile_demo (
	v INT NOT NULL
);
	
INSERT INTO sales.ntile_demo(v) 
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
	
	
SELECT * FROM sales.ntile_demo;
--here result will devide in three bucket numberinf 1,2,3
SELECT 
	v, 
	NTILE (3) OVER (
		ORDER BY v
	) buckets
FROM 
	sales.ntile_demo;
--creating view it will give net sales for 2017
CREATE VIEW sales.vw_netsales_2017 AS
SELECT 
	c.category_name,
	DATENAME(month, o.shipped_date) month, 
	CONVERT(DEC(10, 0), SUM(i.list_price * quantity * (1 - discount))) net_sales
FROM 
	sales.orders o
INNER JOIN sales.order_items i ON i.order_id = o.order_id
INNER JOIN production.products p on p.product_id = i.product_id
INNER JOIN production.categories c on c.category_id = p.category_id
WHERE 
	YEAR(shipped_date) = 2017
GROUP BY
	c.category_name,
	DATENAME(month, o.shipped_date);
--cte(Common table expression)
with cte_by_month as (SELECT month,SUM(net_sales) net_sales
	FROM sales.vw_netsales_2017 GROUP BY month)
--NTILE() function
SELECT month, FORMAT(net_sales,'C','en-US') net_sales,NTILE(4) OVER(ORDER BY net_sales DESC) net_sales_group
FROM 
	cte_by_month;

--Date function
--CURRENT_TIMESTAMP=>it will give current date and time of OS
select CURRENT_TIMESTAMP AS current_date_time;
--it will give utc date time
Select GETUTCDATE() as cuurent
--it will give current date time of current standard time zone
Select GETDATE() as cuurent
--will give current date time with more precision
Select SYSDATETIME() as cuurent
--will give  current system date and time in UTC time
Select SYSUTCDATETIME() as cuurent
--will give current date time and time with utc 
Select SYSDATETIMEOFFSET() as cuurent
/*
DATENAME() is similar to the DATEPART() except for the return type.
The DATENAME() function returns the date part as a character string whereas the DATEPART() returns the date part as an integer.
*/
SELECT
    DATEPART(year, '2018-05-10') [datepart], 
    DATENAME(year, '2018-05-10') [datename];
SELECT
    DATEPART(year, '2018-05-10') + '1' [datepart], 
    DATENAME(year, '2018-05-10') + '1' [datename] ;
--dAY() RETURNS DAY VALUES (1-31) INTERGER VALUE
--datepart and day will give the same result 
	SELECT DAY('2030-12-01') [DAY];
	select DATEPART(day, '2018-05-10') [datepart]
--both will give same result in interger in month
	SELECT Month('2030-12-01') [DAY];
	select DATEPART(MONTH, '2018-05-10') [datepart]
--both will give same result in interger in year
	SELECT year('2030-12-01') [DAY];
	select DATEPART(year, '2018-05-10') [datepart]
--it will give difference between two date it will give in day
select DATEDIFF(DAY,'2018-12-11','1997-10-30')
--it will give in year
select DATEDIFF(year,'2018-12-11','1997-10-30')



--string function

--TRIM() it will remove spaces around the strings
SELECT  TRIM('  Test string    ');
SELECT TRIM('.$' FROM '$$$Hello..') result
--we cant trim between words only start or end
SELECT TRIM('.H' FROM 'Hello..') result
--TRIM() it will remove spaces around the strings
SELECT  RTRIM('  Test string    ');
--LTRIM() it will remove spaces around the strings
SELECT  LTRIM('          Test string    ') as v;
--it will find out index of the first matching character like for server it will give five as after 4 character S is matching
--this is case insensitive search
SELECT  CHARINDEX('Server', 'SQL Server CHARINDEX') position;
--this is case sensitive search
SELECT CHARINDEX('SERVER','SQL Server CHARINDEX' COLLATE Latin1_General_CS_AS) position;
--it will give the result
SELECT CHARINDEX('Server','SQL Server CHARINDEX' COLLATE Latin1_General_CS_AS) position;
--here it will start finding char from the given position
SELECT 
    CHARINDEX('is','This is a my sister',5) start_at_fifth,
    CHARINDEX('is','This is a my sister',10) start_at_tenth;

--CONCAT_WS function add two or more string 
--using seperator
SELECT CONCAT_WS(' ', 'John', 'Doe') full_name

SELECT first_name, last_name, CONCAT_WS(', ', last_name, first_name) full_name
FROM sales.customers ORDER BY first_name, last_name;

--Replace function replaces words between string
--string,what to replace,what to add
SELECT  REPLACE('It is a good tea at the famous tea store.', 'tea','coffee') result;