\c postgres

drop database sqlperf;
create database sqlperf;

\c sqlperf;

drop table if exists employees;
CREATE TABLE employees (
  employee_id integer not null PRIMARY key,
  subsidiary_id integer not null,
  first_name text,
  last_name text,
  date_of_birth DATE NOT NULL,
  phone_number character varying(1000) NOT NULL,
  enabled boolean default true
);

create unique index on employees (subsidiary_id, employee_id);

--create index employees_last_name on employees(last_name);

insert into employees (employee_id, subsidiary_id, first_name, last_name, date_of_birth, phone_number)
  select i, i % 100, 'FN ' || i, 'LN ' || i, date '01/01/1950' + i * interval '4 HOUR', 'PN' || i from generate_series(1, 100000) a(i);

update employees set enabled = false where employee_id % 100 = 0;

-- create index employees_upper_last_name on employees(upper(last_name));

-- create index employees_date on employees(date_of_birth);

-- create index employees_date on employees(date_of_birth, subsidiary_id);

-- create index employees_date on employees(subsidiary_id, date_of_birth);

CREATE TABLE sales (
  employee_id integer not null,
  subsidiary_id integer not null,
  sale_id bigint not null,
  amount integer,
  sale_date DATE NOT NULL
);

alter table sales add primary key (employee_id, subsidiary_id, sale_id);

alter table sales add constraint employee_sales foreign key (employee_id, subsidiary_id) references employees (employee_id, subsidiary_id);

insert into sales (employee_id, subsidiary_id, sale_id, amount, sale_date)
  select (i / 10) + 1, ((i / 10) + 1) % 100, i, i + i, date '01/06/2016' - i * interval '10 minutes' from generate_series(1, 900000) a(i);

-- create index employees_date on employees(date_of_birth, subsidiary_id);

-- create index sales_date on sales(sale_date);
