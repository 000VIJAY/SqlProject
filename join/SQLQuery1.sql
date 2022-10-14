select * from sales.staffs
select * from sales.customers
--inner join 
select s.first_name,s.last_name,c.first_name from sales.staffs  s inner join sales.customers c on s.staff_id = c.customer_id;
select s.first_name,s.last_name,c.first_name from sales.customers  s inner join sales.staffs c on s.customer_id = c.staff_id;
--outer join
select s.first_name,s.last_name,c.first_name from sales.customers  c full outer join sales.staffs s on s.staff_id = c.customer_id;
select s.first_name,s.last_name,c.first_name from sales.staffs  s full outer join sales.customers c on s.staff_id = c.customer_id;
select s.first_name,s.last_name,c.first_name from sales.staffs  s full outer join sales.customers c on s.staff_id = c.customer_id order by c.first_name;
--left join
select s.first_name,s.last_name,c.first_name from sales.staffs  s left join sales.customers c on s.staff_id = c.customer_id;
select s.first_name,s.last_name,c.first_name from sales.customers  c left join sales.staffs s on c.customer_id = s.staff_id;
--right join
select s.first_name,s.last_name,c.first_name from sales.staffs  s right join sales.customers c on s.staff_id = c.customer_id;
select s.first_name,s.last_name,c.first_name from sales.customers  c right join sales.staffs s on c.customer_id = s.staff_id;
--self join
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

SELECT
    e.first_name + ' ' + e.last_name employee,
	e.staff_id,
	m.staff_id,
	e.manager_id,
	e.store_id,
    m.first_name + ' ' + m.last_name manager
FROM
		sales.staffs e
	INNER JOIN sales.staffs m ON m.staff_id = e.store_id
ORDER BY
	m.staff_id;
select * from sales.staffs
--cross join
select s.first_name , s.last_name , c.first_name +' ' + c.last_name cust from sales.staffs s cross join sales.customers c;