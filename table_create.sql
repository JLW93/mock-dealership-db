create table car(
	serial_number SERIAL primary key,
	make VARCHAR(50),
	model VARCHAR(100),
	condition_ VARCHAR(50)
);

create table part(
	part_number SERIAL primary key,
	description VARCHAR(150),
	price NUMERIC(5,2)
);

create table salesperson(
	employee_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table mechanic(
	employee_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

create table customer(
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(150),
	payment_info VARCHAR(150)
);

create table service(
	service_id SERIAL primary key,
	service_type VARCHAR(100),
	service_date DATE default current_date,
	employee_id INTEGER,
	part_number INTEGER,
	serial_number INTEGER,
	foreign key(employee_id) references mechanic(employee_id),
	foreign key(part_number) references part(part_number),
	foreign key(serial_number) references car(serial_number)
);

create table invoice(
	invoice_id SERIAL primary key,
	total_cost NUMERIC(6,2),
	service_id INTEGER,
	employee_id INTEGER,
	customer_id INTEGER,
	serial_number INTEGER,
	foreign key(service_id) references service(service_id),
	foreign key(employee_id) references salesperson(employee_id),
	foreign key(customer_id) references customer(customer_id),
	foreign key(serial_number) references car(serial_number)
);

create table inventory(
	inventory_id SERIAL primary key,
	serial_number INTEGER,
	price NUMERIC(6,2),
	foreign key(serial_number) references car(serial_number)
);