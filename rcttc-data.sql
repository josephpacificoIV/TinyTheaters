use TinyTheaters;
-- Step 4: Transform
-- With our imported data and target schema in the same database, we can write SQL to select from the imported table 
-- and insert into the target tables. Always start with a select statement, confirm you have the results you want, 
-- then complete the statement with an insert into. Never write an untested insert into... select and hope for the best.

-- confirm before the insert for NN columns, let database generate customer_id 
select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from `rcttc-data`;

-- if you end up with more than 74 rows, delete all rows and re-run the insert
insert into Customer(customer_first, customer_last, customer_email, customer_phone, customer_address)
select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from `rcttc-data`;

select * from Customer;

-- ======================Show
select * from Theater;
-- check first
select distinct theater, theater_address, theater_phone, theater_email
from `rcttc-data`;

-- Theater
insert into Theater(theater_name, theater_address, theater_phone, theater_email)
select distinct theater, theater_address, theater_phone, theater_email
from `rcttc-data`;

select * from Theater;

-- confirm
select * from `Show`;

select distinct t.theater_id, `show`, ticket_price, date
from `rcttc-data` d
inner join Theater t on t.theater_name = d.theater;

select * from Theater;
-- insert into `Show`(show_name, ticket_price, date)
-- select distinct `show`, ticket_price, date
-- from `rcttc-data`;







-- -- disable safe updates
-- set sql_safe_updates = 0;

-- -- remove all in one statement.
-- delete from Customer where customer_id > 0;

-- -- enable safe updates
-- set sql_safe_updates = 1;

-- select * from Customer;

-- -- check first
-- select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
-- from `rcttc-data`;
