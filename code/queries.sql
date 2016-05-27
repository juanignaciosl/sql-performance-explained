explain analyze SELECT first_name, last_name
  FROM employees WHERE employee_id = 123;

explain analyze SELECT first_name, last_name
  FROM employees WHERE employee_id = 111 and subsidiary_id = 333;

explain analyze SELECT first_name, last_name
  FROM employees WHERE subsidiary_id = 333;

explain analyze SELECT first_name, last_name
  FROM employees WHERE upper(last_name) = 'LN 38'
