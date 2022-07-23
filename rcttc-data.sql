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

-- Show
select * from `Show`;

-- confirm
select distinct t.theater_id, `show`, ticket_price, date
from `rcttc-data` d
inner join Theater t on t.theater_name = d.theater;

-- insert 
insert into `Show`(show_name, ticket_price, date, theater_id)
select distinct `show`, ticket_price, date, t.theater_id
from `rcttc-data` d
inner join Theater t on t.theater_name = d.theater;

select * from `Show`;


-- TicketPurchase

select * from Theater;
select * from `rcttc-data`;

select distinct d.seat, c.customer_id, s.show_id
from `rcttc-data` d
inner join Customer c on c.customer_first = d.customer_first and c.customer_last = d.customer_last and c.customer_email = d.customer_email
inner join Theater t on t.theater_name = d.theater
inner join `Show` s on s.show_name = d.show and s.date = d.date and s.theater_id = t.theater_id;


insert into TicketPurchase(seat_label, customer_id, show_id)
select distinct d.seat, c.customer_id, s.show_id
from `rcttc-data` d
inner join Customer c on c.customer_first = d.customer_first and c.customer_last = d.customer_last and c.customer_email = d.customer_email
inner join Theater t on t.theater_name = d.theater
inner join `Show` s on s.show_name = d.show and s.date = d.date and s.theater_id = t.theater_id;

select * from TicketPurchase;







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
