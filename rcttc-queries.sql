-- Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021).
select * 
from `Show` s
where s.date > '2021-10-01';

-- List customers without duplication.
select distinct customer_first, customer_last
from Customer;

-- Find all customers without a .com email address.
select * 
from Customer 
where customer_email like '%.com';

-- Find the three cheapest shows.
select distinct s.show_name,  s.date, s.ticket_price
from TicketPurchase tp
left outer join `Show` s on s.show_id = tp.show_id
order by s.ticket_price
limit 3;

-- List customers and the show they're attending with no duplication.
select distinct c.customer_first, c.customer_last, s.show_name, s.date
from TicketPurchase tp
left outer join Customer c on c.customer_id = tp.customer_id
left outer join `Show` s on s.show_id = tp.show_id;

-- List customer, show, theater, and seat number in one query.
select c.customer_first, c.customer_last, s.show_name, t.theater_name, tp.seat_label
from TicketPurchase tp
left outer join Customer c on c.customer_id = tp.customer_id
left outer join `Show` s on s.show_id = tp.show_id
left outer join Theater t on t.theater_id = s.theater_id;

-- Find customers without an address.
select *
from Customer
where customer_address = ' ';

-- Recreate the spreadsheet data with a single query.
select c.customer_first, 
c.customer_last, 
c.customer_email, 
c.customer_phone, 
c.customer_address, 
tp.seat_label, 
s.show_name, 
s.ticket_price,
s.date, 
t.theater_name, 
t.theater_address, 
t.theater_phone,
t.theater_email
from TicketPurchase tp
left outer join Customer c on c.customer_id = tp.customer_id
left outer join `Show` s on s.show_id = tp.show_id
left outer join Theater t on t.theater_id = s.theater_id;


-- Count total tickets purchased per customer.
