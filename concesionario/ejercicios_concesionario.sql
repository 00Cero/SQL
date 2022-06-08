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





