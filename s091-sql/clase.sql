--INNER JOIN
select * 
from employees e, departments d
where e.department_id = d.department_id;

select *
from employees e
inner join departments d
on e.department_id = d.department_id;

--OUTER JOIN
select count(*)
from employees e, departments d
where e.department_id = d.department_id;

--LEFT (OUTER) JOIN
select  e.first_name || ' ' || e.last_name as nom,
        coalesce(d.department_name, 'sin dpto') as dpto
from employees e
left join departments d
on e.department_id = d.department_id
where e.department_id is null;

--UNION
select employee_id as cod_emp, first_name as nom, last_name as ape, salary as sueldo
from employees where department_id = 90
union
select employee_id, first_name, last_name, salary 
from employees where department_id = 50;

select * 
from employees 
where department_id in (50, 90);


/*
    Muestre el nombre del empleado, el salario del empleado, el nombre del departamento al que pertenece, 
    el nombre de su rol y la ciudad donde trabaja
*/

select  e.first_name, e.last_name, 
        e.salary, d.department_name, j.job_title,
        l.city
from employees e, departments d, jobs j, locations l
where e.department_id = d.department_id
and e.job_id = j.job_id
and d.location_id = l.location_id;


/*
    Muestre el nombre del empleado, el salario, la región, el país, la ciudad, y el departamento al que pertenece
*/

select  e.first_name || ' ' || e.last_name as nom,
        e.salary as sal, r.region_name as reg, c.country_name as pais,
        l.city as ciudad, d.department_name as dpto      
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id;
