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

create unique index on employees (employee_id, subsidiary_id);

create index employees_last_name on employees(last_name);

insert into employees (employee_id, subsidiary_id, first_name, last_name, date_of_birth, phone_number)
  select i, i % 100, 'FN ' || i, 'LN ' || i, date '01/01/1080' + i, 'PN' || i from generate_series(1, 100000) a(i);

update employees set enabled = false where employee_id % 100 = 0;

-- create index employees_upper_last_name on employees(upper(last_name));

-- create index employees_date on employees(date_of_birth);

-- create index employees_date on employees(date_of_birth, subsidiary_id);

-- create index employees_date on employees(subsidiary_id, date_of_birth);