use concesionario;

-- ejercicio 2 - modificar la comision de los vendedores y ponerla a 0.5% cuando ganan mas de 50000

select * from vendedores order by sueldo desc;

update vendedores set comision = 0.5 where sueldo >= 50000;

-- @@@@@ejercicio3 Incrementar el precio de todos los coches en un 2%

select * from coches order by precio desc;

update coches set precio = precio + (precio * 0.02);

-- @@@@@ ejercicio 4  sacar todos los vendedores que su fecha de alta es posterior al 1 de julio de 2020

select * from vendedores where fecha_alta <= '2020-07-01';

update vendedores set fecha_alta = '2020-01-01' where id = 1;

-- @@@@@ ejercicio 5 mostrar el nombre del vendedor y los dias que lleva de alta

select * from vendedores;

update vendedores set fecha_alta = current_date()-2 where id = 9 ;

select nombre, datediff( current_date(),fecha_alta) as 'dias' from vendedores;

-- @@@@@ ejercicio 6 visualizar el nombre y apellido de los vendedores en una misma columna, su fecha de registro y el dia de la semana en la que se registraron

select * from vendedores;

select concat(nombre,' ',apellido) as 'nombre completo' , fecha_alta, dayname(fecha_alta) from vendedores;

-- ejercicio 7

select * from vendedores;

select nombre, sueldo,cargo from vendedores where cargo like '%ayudante%';

-- @@@@@ ejercicio 8 visualizar todos los coches en cuya marca exista la letra "a" y que el modelo empiecen por "f"

select marca,modelo from coches where marca like '%a%' and modelo like 'f%';

-- @@@@@ ejercicio 9 mostrar todos los vendedores del grupo 2 ordenados por salario descendente

SELECT * from vendedores where grupo_id= 2 order by sueldo desc;

-- @@@@@ ejercicio 10 visualizar los apellidos de los vendedores, su fecha y su numero de grupo ordenado por fecha descencente y mostrar los 4 ultimos que se registraron

select apellido, fecha_alta, grupo_id from vendedores order by fecha_alta desc limit 4;

-- @@@@@ ejercicio 11 visualizar toodos los cargos de los vendedores y el numero de vendedores que hay en cada cargo

select cargo,count(*) as 'total' from vendedores GROUP BY cargo;

-- @@@@@ ejercicio 12 conseguir la cantidad total de dinero que se destina a sueldos

select sum(sueldo) as 'dinero total' from vendedores;

-- @@@@@ ejercicio 13 sacar la media de sueldos entre todos los vendedores por grupo
select * from vendedores;

select grupo_id,count(*), avg(sueldo) as 'total' from vendedores GROUP BY grupo_id ;

-- @@@@@ ejercicio 13.1 en evez del id del grupo poner nombre


select concat(g.nombre, ' - ', g.ciudad ),count(*) as 'total x grupo', avg(v.sueldo) as 'total' from vendedores v
right join grupo g on v.grupo_id = g.id
GROUP BY grupo_id ;

-- @@@@@ ejercicio 14 visualizar las unidades totales vendidas de cada coche a cada cliente mostrando el nombre de producto, numero de cliente y la suma de unidades

select e.coche_id, e.cantidad,co.modelo, cl.nombre from encargos e 
inner join coches co on e.coche_id = co.id
inner join clientes cl on e.cliente_id = cl.id ;

-- @@@@@ ejercicio 15 los 2 clientes con mayor numero de coches comprados y cuantos pedidos han hecho

select c.nombre, e.cantidad from clientes c
inner join encargos e on e.cliente_id = c.id
order by e.cantidad desc limit 2;


-- @@@@@ ejercicio 16 obtener listado de clientes atendidos por el vendedor david lopez

select * from vendedores;

select * from clientes;

insert into clientes values(null,2,'pepe','irun',2,current_date());

desc clientes;

select c.nombre, concat(v.nombre, ' ', v.apellido) as 'vendedor' from clientes c
inner join vendedores v on v.id = c.vendedor_id where v.nombre like 'david' and v.apellido like 'lopez' ;

-- @@@@@ ejercicio 17 obtener un listado con los encargos realizados por el cliente fruteria antonia

select e.id,e.cantidad,c.nombre from encargos e
inner join clientes c on e.cliente_id = c.id
where e.cliente_id in (select id from clientes where nombre like '%fruteria antonia%');

-- @@@@@ ejercicio 18 listar los clientes que han hecho un encargo del coche mercedes 

select * from encargos;

insert into encargos values(null,3,6,2,current_date());

select cl.nombre, e.cantidad, co.marca,co.modelo from clientes cl
inner join encargos e on cl.id = e.cliente_id
inner join coches co on e.coche_id = co.id
where co.marca like '%mercedes%';

-- otra forma de hacerlo

select * from clientes where id in
(select cliente_id from encargos where coche_id in
(select id from coches where marca like '%mercedes%')
);


-- @@@@@ ejercicio 19 obtener los vendedores con 2 o mas clientes

select * from clientes;

insert into clientes values (null,2,'juan','donostia',5,current_date());

select vendedores.nombre, count(clientes.id) from clientes
inner join vendedores on clientes.vendedor_id = vendedores.id
group by vendedor_id having count(clientes.id) > 3;


-- @@@@@ ejercicio 20 seleccionar el grupo que trabaja el vendedor con mayor salario 

select * from grupo where id in 
( select grupo_id from vendedores where sueldo = (select max(sueldo) from vendedores));

-- @@@@@ ejercicio 21 obtnere los nombres y las ciudades de los clientes que hayan hecho encargos

select * from clientes;

select * from encargos;
delete from encargos where id = 7;
insert into encargos values (null,6,6,2,current_date());


select c.id,c.nombre, c.ciudad, e.cantidad from clientes c 
inner join encargos e on c.id = e.cliente_id ;

-- @@@@@ ejercicio 21.1 obtnere los nombres y las ciudades de los clientes que hayan comprado 3 o mas coches en el encargo


select c.id, c.nombre, c.ciudad, e.cantidad from clientes c 
inner join encargos e on c.id = e.cliente_id 
where cantidad >= 3
;

-- @@@@@ ejercicio 21.2 obtnere los nombres y las ciudades de los clientes que hayan hehco 2 o mas encargos

select count(c.id) as 'numero de pedidos', c.id,c.nombre, c.ciudad, e.cantidad from clientes c 
inner join encargos e on c.id = e.cliente_id group by c.id ;
 














