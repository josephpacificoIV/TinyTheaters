
-- right click on TinyTheaters, Data Import Wizard, find the `rcttc-data` CSV, import into new table, click wrench icon, change delimiter to a comma

use TinyTheaters;
-- Step 4: Transform
-- With our imported data and target schema in the same database, we can write SQL to select from the imported table 
-- and insert into the target tables. Always start with a select statement, confirm you have the results you want, 
-- then complete the statement with an insert into. Never write an untested insert into... select and hope for the best.
-- if you end up with more than 74 rows, delete all rows and re-run the insert

-- confirm before the insert for NN columns, let database generate customer_id 



-- Customer

select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from `rcttc-data`;

insert into Customer(customer_first, customer_last, customer_email, customer_phone, customer_address)
select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from `rcttc-data`;

select * from Customer;

-- Theater

select * from Theater;
-- check first
select distinct theater, theater_address, theater_phone, theater_email
from `rcttc-data`;

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

select * from TicketPurchase;

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

-- drop 
drop table `rcttc-data`;

-- ==================UPDATE=========================

-- update #1
select * from `Show`;

update `Show` set
    ticket_price = 22.25
where show_id = 5;

select * from `Show`;

-- update #2

-- confirm
select * 
from TicketPurchase t
left outer join Customer c on c.customer_id = t.customer_id
where show_id = 5
order by seat_label;

-- update
update TicketPurchase set
    seat_label = 'B4'
where ticket_purchase_id = 98;

update TicketPurchase set
    seat_label = 'C2'
where ticket_purchase_id = 100;

update TicketPurchase set
    seat_label = 'A4'
where ticket_purchase_id = 101;

select * 
from TicketPurchase t
left outer join Customer c on c.customer_id = t.customer_id
where show_id = 5
order by seat_label;

-- update #3 
select * 
from Customer 
where customer_first = 'Jammie' and customer_last = 'Swindles';

-- turn off safe updates
set sql_safe_updates = 0;

-- update
update Customer set 
customer_phone = '1-801-EAT-CAKE' 
where customer_first = 'Jammie' and customer_last = 'Swindles';

-- turn on safe updates
set sql_safe_updates = 1;

select * 
from Customer 
where customer_first = 'Jammie' and customer_last = 'Swindles';

-- ==================DELETE=========================

-- this finds the single ticket reservations for a given theater
-- 87 rows of tickets purchased at 10 pins theater
select count(t.customer_id) total_tickets, t.customer_id, r.theater_name, s.show_name
from TicketPurchase t
left outer join `Show` s on s.show_id = t.show_id
left outer join Theater r on r.theater_id = s.theater_id
group by t.customer_id, r.theater_name, s.show_name
having r.theater_name = '10 Pin' and total_tickets = 1
order by customer_id;

-- there are 9 single-ticket reservations at the 10 Pin that need to be removed
-- customer_id = 7,8,10,15 in Send in the Clowns (4 tickets)
-- customer_id = 18,19,22,25,26 in The Dress (4 tickets)
-- customer_id = 26 in Tell Me What To Think (1 ticket)
-- select * from TicketPurchase where show_id in (1,2,3,4); 
-- 87 tickets purchased for shows at 10 Pin, 9 of which are single ticket
-- should return 78 rows of tickets purchased at the 10 Pin. 
-- delete 9 tickets from main ticket registry

-- confirm
select * 
from TicketPurchase -- 194 rows
where ticket_purchase_id not in (25,26, 29, 41, 50, 51, 59, 67, 68);

-- delete the 9 single reservations from 10 pins
delete from TicketPurchase where ticket_purchase_id in (25,26, 29, 41, 50, 51, 59, 67, 68);

-- should return 185 rows 
select * from TicketPurchase;




-- delete #2
select * 
from Customer
where customer_first = 'Liv'; 

-- customer_id = 65


-- delete from TicketPurchase first, since there is a foreign key from Customer

select * from TicketPurchase where customer_id = 65; -- 2 ticket reservations to be deleted
-- -- disable safe updates
set sql_safe_updates = 0;
delete from TicketPurchase where customer_id = 65;
-- -- enable safe updates
set sql_safe_updates = 1;
-- should return null
select * from TicketPurchase where customer_id = 65;

-- now delete in Customer
-- -- disable safe updates
set sql_safe_updates = 0;
delete from Customer where customer_first = 'Liv';
-- -- enable safe updates
set sql_safe_updates = 1;
-- should return null
select * from Customer where customer_first = 'Liv';

-- =====End of DML===============
