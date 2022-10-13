select * from members

create database Demo
use Demo
create table Demo (
userId int not null primary key,
userName varchar(20) not null ,
mobileNumber bigint unique,
userAddress varchar ,
)
drop table 
select * from Demo
insert into dbo.Demo(userId,userName,mobileNumber) values(124,'vijay',9955334422)

create table userAddress(
addressId smallint not null Primary Key,
addressLine1 varchar(50) not null,
addressLine2 varchar(60) not null,
user_State varchar(20) not null
)
insert into userAddress(addressId,addressLine1,addressLine2,user_State) values(3, 'Ashok rajpath','patna','bihar')
select * from userAddress

alter table dbo.Demo alter column  userAddress int 
alter table dbo.Demo ADD Foreign key(addressId) REFERENCES userAddress(addressId)
alter table dbo.Demo ADD constraint FK_AddressId Foreign key(addressId) REFERENCES userAddress(addressId)

create table userDeatils (
Id int not null primary key,
userAge smallint check (userAge>=15),
 userId int foreign key REFERENCES Demo(userId)
)
select * from userDeatils 

insert into userDeatils(Id,userAge) values(13,16)
use Bike
select * from sales.customers
--here like will match the value that is given __a
select * from sales.customers where first_name Like '__a'
select first_name,last_name,city  from sales.customers where first_name Like '__a'
select * from sales.customers where first_name Like '__a' order By email
--Having clause filter the data by the aggregate value
select Count(*) from sales.customers where state = 'NY'  group by city having COUNT(*) > 10
select * from sales.customers  order By first_name 
SELECT city, COUNT (*) FROM sales.customers WHERE state = 'CA' GROUP BY city ORDER BY city;
--using more then one value in order by then it will order by first ,2,3 and so on
SELECT city,first_name,last_name FROM sales.customers ORDER BY city,first_name , last_name;
SELECT first_name,last_name FROM sales.customers ORDER BY LEN(last_name) ;
--using LEN it will sort by the legth of string
SELECT first_name,last_name FROM sales.customers ORDER BY LEN(first_name) DESC;
--by using order of the select value we can filter the data here 1 stand for first_name and 2 stand for last_name
SELECT first_name,last_name FROM sales.customers ORDER BY 1,2;
--offset clause is come with ORDER BY offset retrive the remainig data like here
--1200 written then offset give remainig data after removing top 1200 data
select * from sales.customers ORDER BY first_name OFFSET 1200 ROWS;
--Fetch will give the data the is described for using fetch we have to use offset here offset will hide 100 rows
--and after that fetch will fetch 10 rows
select * from sales.customers ORDER BY first_name OFFSET 100 ROWS FETCH next 10 ROWS only;
--if wanted to get top data then give OFFSET ==0
select * from sales.customers ORDER BY first_name OFFSET 0 ROWS FETCH next 10 ROWS only;
--if wanted to get top data then give OFFSET ==0
--it will give bottom 10 data as per customer id
select * from sales.customers ORDER BY customer_id desc OFFSET 0 ROWS FETCH next 10 ROWS only;
--it will give bottom 10 data as per firstNAme and customer id
select * from sales.customers ORDER BY first_name,customer_id desc OFFSET 0 ROWS FETCH next 10 ROWS only;
-- it will give top 20 result from customer table 
select TOP 20 first_name,last_name from sales.customers order by first_name;
-- it will give top 2 % from customer table 
select TOP 2 PERCENT first_name,last_name from sales.customers order by first_name;
--with ties will give total 
SELECT TOP 4 WITH TIES product_name, list_price FROM production.products ORDER BY  list_price DESC;

select TOP 10 first_name, last_name from sales.customers union select TOP 10 first_name, last_name from sales.staffs
select TOP 10 first_name, last_name from sales.customers union all select TOP 10 first_name, last_name from sales.staffs
select TOP 10 first_name, last_name from sales.customers union  select TOP 10 first_name, last_name from sales.staffs order by last_name
--it will give only unmatched values which is nt common in these two
select first_name, last_name from sales.customers intersect  select first_name, last_name from sales.staffs order by last_name
--it will give the only result which is not the second one
SELECT product_id FROM production.products EXCEPT SELECT product_id FROM sales.order_items;
