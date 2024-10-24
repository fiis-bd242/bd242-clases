-- Muestre los nombres de los empleados y el nombre del departamento al que pertenecen. Solo incluya a aquellos empleados que tengan un departamento asignado.
select first_name || ' ' || last_name, d.department_name 
from employees e 
join departments d
on e.department_id  = d.department_id;

-- Muestre el nombre del empleado y el nombre de su gerente. Incluya a todos los empleados que tengan un gerente.
select emp.first_name || ' ' || emp.last_name as emp, mgr.first_name || ' ' || mgr.last_name as mgr
from employees emp
join employees mgr
on emp.manager_id  = mgr.employee_id;


-- Muestre el nombre del empleado, el título de su rol y el nombre del departamento al que pertenece. Incluya todos los empleados.
select e.first_name || ' ' || e.last_name, j.job_title, d.department_name
from employees e
join jobs j
on e.job_id  = j.job_id
left join departments d
on e.department_id = d.department_id;

-- Muestre los nombres de los empleados y la ciudad en la que se encuentran sus oficinas. Incluya a aquellos empleados que tengan un departamento asignado.
select e.first_name || ' ' || e.last_name, l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- Muestre el nombre del empleado, el nombre del departamento y el país donde se encuentra el departamento.
select e.first_name || ' ' || e.last_name, d.department_name, c.country_name 
from employees e
left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id 
left join countries c
on l.country_id  = c.country_id ;