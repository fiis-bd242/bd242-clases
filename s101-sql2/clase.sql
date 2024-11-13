-- Funciones de grupo
select d.department_name, trunc(avg(e.salary), 2), 
       count(*), sum(e.salary), max(e.salary), 
       min(e.salary), min(e.hire_date)
from employees e, departments d
where e.department_id = d.department_id
  and d.department_id <> 90
group by d.department_name
having avg(e.salary) > 5000;

-- Funciones BD: cadenas
select lpad(cast(employee_id as varchar), 10, '0'),
       lpad(first_name, 15, '*'),
       rpad(first_name, 15, '-'),
       first_name || ' ' || last_name,
       upper(first_name), lower(last_name),
       initcap(first_name)
from employees;

-- Funciones numéricas
select avg(salary),
       trunc(avg(salary)),
       round(avg(salary))
from employees;

select avg(salary),
       trunc(avg(salary), 1),
       round(avg(salary), 1)
from employees;

-- Uso de 'LIKE'

-- Apellidos que empiecen con 'A'
select * from employees where last_name like 'a%';

-- Apellidos que terminen en 'G'
select * from employees where last_name like '%g';

-- Apellidos que tengan 'N' como tercera letra
select * from employees where last_name like '__n%';

-- Apellidos que contengan la cadena 'OL'
select * from employees where last_name like '%ol%';

-- Subconsultas

-- Empleados que ganan más que el promedio de la empresa
select * from employees
where salary > (select avg(salary) from employees);

-- Empleados que ganan más que el promedio de su departamento
select * from employees e
where salary > (select avg(salary) from employees where department_id = e.department_id);

-- Nombre de empleado, salario y salario promedio de su departamento
select e.last_name, e.salary, e.department_id,
       (select trunc(avg(salary), 2) from employees where department_id = e.department_id)
from employees e;

select e.last_name, e.salary, trunc(prom.sal_prom, 2)
from employees e,
     (select department_id, avg(salary) as sal_prom
      from employees
      group by department_id) prom
where e.department_id = prom.department_id;

-- Fechas
select max(hire_date), min(hire_date), max(hire_date) - min(hire_date)
from employees;

select current_date - max(hire_date) from employees;

select last_name, salary, hire_date, age(current_date, hire_date) from employees;

-- Extract: year, month, day
select age(current_date, hire_date), extract(year from age(current_date, hire_date)) from employees;

-- Nombre del empleado y nombre de su supervisor: '<Empleado> está a cargo de <Supervisor>'
select e.first_name || ' ' || e.last_name || ' está a cargo de ' ||
       mgr.first_name || ' ' || mgr.last_name
from employees e, employees mgr
where e.manager_id = mgr.employee_id;

-- Empleados contratados a partir de 1994
select *
from employees
where hire_date >= to_date('01/01/1994', 'dd/mm/yyyy');

-- Uso de HAVING
select region_name, country_name, city, count(*)
from emp_full
group by region_name, country_name, city
having count(*) > 5
order by count(*) desc;

-- Crear una nueva tabla con el código de empleado completado con ceros a la izquierda (10 dígitos), el nombre completo 
-- del empleado y el salario del mismo. Excluya a los empleados del área Executive
create table emp001 as (
    select lpad(cast(e.employee_id as varchar), 10, '0') as cod,
           e.first_name || ' ' || e.last_name as nom,
           e.salary as sal
    from employees e, departments d
    where e.department_id = d.department_id
      and d.department_name <> 'executive'
);

-- Usando vistas
create view emp_view as (
    select lpad(cast(e.employee_id as varchar), 10, '0') as cod,
           e.first_name || ' ' || e.last_name as nom,
           e.salary as sal
    from employees e, departments d
    where e.department_id = d.department_id
      and d.department_name <> 'executive'
);