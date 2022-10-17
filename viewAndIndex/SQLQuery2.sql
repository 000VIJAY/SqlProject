create table Employee(id int primary key ,name varchar,slary money,gender varchar(2),city varchar(20))

insert into Employee values(5,30000,'M','Patna' ,'Rahul')
insert into Employee values(6,35800,'M','Nalanda','Nitish')
insert into Employee values(2,37000,'F','Lucknow','Shivani')
insert into Employee values(1,36000,'M','Chandigarh','Praveen')
insert into Employee values(4,33000,'F','Muzzfarpur','Sweta')
insert into Employee values(3,32000,'M','Raipur','Niraj')
insert into Employee values(7,31000,'M','Kolkata','Umesh')


alter table Employee add EmployeeName varchar(30)
 select * from Employee
 --it will throw an error as primary key is behave like clustered index so if want to add clustered index need to delete pre defined clustererd index
 create clustered INdex IX_tblmployee_Gender_Salary
 ON Employee(id)
 --
  create nonclustered INdex IX_tblmployee_Salary
 ON Employee(slary )
 --removing index
 DROP INDEX  IX_tblmployee_Salary ON dbo.Employee
 --A unique index ensures the index key columns do not contain any duplicate values.
 --it will thrwo error as salary have duplicate values
 CREATE UNIQUE INDEX  IX_tblmployee_Salary
ON  Employee(slary );