use TinyTheaters;
-- Step 4: Transform
-- With our imported data and target schema in the same database, we can write SQL to select from the imported table 
-- and insert into the target tables. Always start with a select statement, confirm you have the results you want, 
-- then complete the statement with an insert into. Never write an untested insert into... select and hope for the best.

-- confirm before the insert for NN columns, let database generate customer_id 
select distinct customer_last 
from `rcttc-data`;

-- if you end up with more than 74 rows, delete all rows and re-run the insert
insert into Customer(customer_first, customer_last, customer_email)
select distinct customer_first, customer_last, customer_email
from `rcttc-data`;

select * from Customer;


