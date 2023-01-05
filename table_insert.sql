-- Function to create car and add it to inventory
create or replace function add_car(_serial_number INTEGER, _make VARCHAR, _model VARCHAR, _condition_ VARCHAR, _inventory_id INTEGER, _price numeric)
returns void
as $MAIN$
begin 
	insert into car(serial_number, make, model, condition_)
	values (_serial_number, _make, _model, _condition_);

	insert into inventory(inventory_id, serial_number, price)
	values (_inventory_id, _serial_number, _price);
end
$MAIN$
language plpgsql;

-- Alter table to update the numeric value to be correct
alter table inventory
alter column price
type NUMERIC(7,2);

alter table invoice
alter column total_cost
type NUMERIC(7,2);

-- function calls to create cars
select add_car(12345678, 'Chevrolet', 'Camaro', 'New', 1, 42395.00);

select add_car(56384560, 'Ford', 'Mustang', 'Used', 2, 18495.00);

select add_car(16532956, 'Honda', 'Civic', 'New', 3, 22995.00);

select add_car(04573865, 'Toyota', 'Supra', 'New', 4, 58450.00);

select add_car(99667123, 'Dodge', 'Neon', 'Used', 5, 4500.00);

select add_car(31343485, 'Toyota', 'Camry', 'New', 6, 32654.00);

-- Test to make sure that the function calls worked
select car.serial_number, make, model, condition_, inventory_id, price
from car
full join inventory
on car.serial_number = inventory.serial_number;

-- Customer data insertion
insert into customer(customer_id, first_name, last_name, address, payment_info)
values(1, 'Greg', 'Jones', '445 E West St, Northtown, SC 33428', '4433 3434 5544 4545 902 05/27');

insert into customer(customer_id, first_name, last_name, address, payment_info)
values(2, 'Clark', 'Duncan', '138 Lumbridge Dr, Gielenor RS 20071', '3765 4987 0023 2319 451 09/30');

insert into customer(customer_id, first_name, last_name, address, payment_info)
values(3, 'Oliver', 'Queen', '398 Verdant Ave, Star City, WA 11945', '9905 4760 2032 3001 980 10/23');

insert into customer(customer_id, first_name, last_name, address, payment_info)
values(4, 'Walter', 'White', '308 Negra Arroyo Ln, Albuquerque NM 87104', '5555 8490 1324 5093 341 01/19');

select * from customer

-- employee data insertion

insert into mechanic(employee_id, first_name, last_name)
values(4, 'Paul', 'Allen');

insert into mechanic(employee_id, first_name, last_name)
values(5, 'Tommy', 'Oliver');

insert into mechanic(employee_id, first_name, last_name)
values(6, 'Billy', 'Cranston');

insert into salesperson(employee_id, first_name, last_name)
values(1, 'Sean', 'Gunn');

insert into salesperson(employee_id, first_name, last_name)
values(7, 'David', 'Smith');

insert into salesperson(employee_id, first_name, last_name)
values(2, 'Aaron', 'Balakay');

insert into salesperson(employee_id, first_name, last_name)
values(3, 'Saul', 'Goodman');

select * from mechanic

select * from salesperson

-- part information insertion
insert into part(part_number, description, price)
values(0, 'No Part', 0.00);

insert into part(part_number, description, price)
values(1, 'Brake Pads', 49.99);

insert into part(part_number, description, price)
values(2, 'Carburetor', 644.99);

insert into part(part_number, description, price)
values(3, 'Timing Belt', 94.99);

select * from part

-- service data
insert into service(service_id, service_type, employee_id, part_number, serial_number)
values(1, 'Oil Change', 5, 0, 16532956);

insert into service(service_id, service_type, employee_id, part_number, serial_number)
values(2,'Brake Pad Replacement', 5, 1, 99667123);

insert into service(service_id, service_type, employee_id, part_number, serial_number)
values(3, 'Carburetor Replacement', 4, 2, 56384560);

select * from service;

-- invoice data insertion

insert into invoice(invoice_id, total_cost, service_id, employee_id, customer_id, serial_number)
values(1, 4549.99, 2, 3, 4, 99667123);

insert into invoice(invoice_id, total_cost, service_id, employee_id, customer_id, serial_number)
values(2, 58450.00, null, 2, 2, 04573865);

select * from invoice

-- test query
select customer.customer_id, customer.first_name, customer.last_name, make, model, salesperson.employee_id, salesperson.first_name, salesperson.last_name, total_cost
from customer
full join invoice
on customer.customer_id = invoice.customer_id
full join car
on car.serial_number = invoice.serial_number
full join salesperson
on salesperson.employee_id = invoice.employee_id;