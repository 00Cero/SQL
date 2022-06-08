-- bbdd udemy leccion 107

create database udemy;
use udemy;

show tables;

select * from users;
select * from categories;
select * from entries;


create table users (
	
id int not null auto_increment,
name varchar(50) not null,
surname varchar(50) not null,
email varchar(50) not null,
pass varchar(50) not null,
fecha date not null,
primary key(id)

);

create table categories (
id int not null auto_increment,
name varchar(100) not null,
constraint pk_id primary key(id)
);


create table entries (
 id int not null auto_increment,
 user_id int not null,
 category_id int not null,
 title varchar(100) not null,
 description mediumtext,
 `date` date not null,
 primary key(id),
 foreign key (user_id) references users(id),
 constraint fk_entries_categories foreign key(category_id) references categories(id)

);

-- en las foreign keys, se puede poner una accion a ella por ejemplo:
-- constraint fk_entries_categories foreign key(category_id) references categories(id) on delete cascade, cuando se borre la id a la que esta referenciada, que se borre este registro de la tabla, por ejemplo si se borra el id=3 de categories, se borra todos los registros que apunten a ese categorires id = 3

-- el poner constraint y un nombre, es el nombre que ponemos cuando creamos unas foreign keys desde la vista de esquema

select * from users; 

-- insertando datos en las tablas:
-- se puede insertar sin poner a los campos a los cuales se quiere insertar siempre y cuando en values se pongan todas las columnas, la columna del id tambien


insert into users values(null,'pepe','pepe','pepe@pepe.com',1234,'2001-01-01');

-- si se pone los campos a los cuales se quiere insertar no hace falta poner todos los campos pero si hace falta que se pongan en orden
-- (name,surname,email,pass,fecha)
-- ('juan','juan','juan@juan.com',1234,'2001-01-01')
insert into users(name,surname,email,pass,fecha) values('juan','juan','juan@juan.com',1234,'2001-01-01');

insert into users(name,surname,email,pass,fecha) values('alberto','salinas','alberto@alberto.com',1234567,'1994-06-17');


-- selects
select id,name, (id+3) as 'operacion' from users order by email asc;
select id,fecha from users;

select email, datediff(curdate(), fecha) as 'tiempo', dayofmonth(fecha) as 'mes' from users;

select email, current_time() from users;

select email, sysdate() from users;

select email, strcmp('hola','hola') from users;
-- si son iguales los valores, la funcion strcmp devuelve 0 y si son diferentes devuelve 1

select * from users;

-- la pass es un varchar a si que mejor pasar el valor entre_comillado
select name,surname,pass from users where surname like '%a%' and pass = '1234';

select upper(name) as nombre_mayus,fecha,email, id from users where length(name) >= 4 and year(fecha) < 2002;

-- normalmente ordena por id
select * from users order by fecha asc;

-- se puede limitar el numero de busquedas
select * from users order by fecha asc limit 2;

-- a la func limit se le puede pasar un rango, x ejemplo, de la busqueda que hagas muestra solo del 1 al 2
select * from users order by fecha asc limit 1,2;

-- traversing filas
update users set fecha = current_date() where id = 3;

delete from users where id = 1 ;

-- para info de las tablas
desc entries;




desc categories;

insert into categories (name) values
('accion'),
('comedia'),
('miedo'); 

select * from categories;

select * from users;

desc entries;


-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`udemy`.`entries`, CONSTRAINT `fk_entries_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`))
-- sale este error si se intenta poner como foreign key una key que ya no existe
 insert into entries values(null, 2, 1, 'GTA', 'juego super juego',current_date());
 
 insert into entries values(null, 2, 2, 'lol', 'juego super juego',current_date());
 
 insert into entries values(null, 3, 3, 'wow', 'juego super juego',current_date());
 
 insert into entries values(null, 3, 3, 'pokemon', 'juego super juego',current_date());
 insert into entries values(null, 3, 3, 'clash', 'juego super juego',current_date());
 
 select * from entries;
 
 
 
 select user_id, count(*) from entries group by user_id;
 
 -- para poder utilizar condiciones en agrupamientos no se puede hacer WHERE hace falta utilizar el having
 
 select user_id, count(*) as total from entries group by user_id having count(*) = 2 ;


-- #### SUBCONSULTAS #####

-- al hacer subconsultas buscamos where id in "la subconsulta" con lo cual en la subconsulta hay que seleccionar -> SELECT *_id

select * from users;

insert into users (name,surname,email,pass,fecha) values ('admin','admin','admin@admin.com','admin',current_date());

-- saca solo los datos de users que tenga registros en entries
select * from users where id in (select user_id from entries);

select * from users where id not in (select user_id from entries);

select * from entries;

insert into entries (user_id,category_id,title,description,date) values(2,2,'wow2','wow 2 bien',current_date());

select * from users where id in (select user_id from entries where title like '%wow%'); 

select * from categories;

-- sacar todos los registros de la categoria miedo utilizando su nombre
select * from entries where category_id in (select id from categories where name like 'miedo' );

select id,name from categories where name like 'accion';

-- @@@@@@@ mostrar las categorias con mas de 2 entradas

-- ###### A tener en cuenta ######
    
    -- Error Code: 1241. Operand should contain 1 column(s); La SUBCONSULTA solo puede contener una columna, por eso solo se selecciona una columna y no varias
    
-- explicacion de la subconsulta:  selecciona la columna category_id de la tabla entries y agrupalo por category_id y este agrupamiento(el resultado del agrupamiento debe ser mayor igual a 2)
-- explicacion de la consulta: la subconsulta devulve 2 lineas, de cada linea sacar la categoria a la cual pertenecen
select * from categories where id in (select category_id from entries group by category_id having count(category_id) >=2);

select category_id,count(category_id) as total from entries group by category_id having count(category_id) >=3;

select category_id from entries group by category_id having count(category_id) >=2;

select version();

-- @@@@@@ mostrar los usuarios que crearon una entrada un martes

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`udemy`.`entries`, CONSTRAINT `fk_entries_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)) ya que se intentaba crear una entrie con un user que ha sido borrado

insert into entries values (null, 2,1,'classic','fumo burrules', current_date());

-- domingo es dia 1
select name,date from users where id in (select user_id,date from entries where dayofweek(date) = 3);

select user_id, date from entries where dayofweek(date) = 3;

-- @@@@@ mostrar el nombre del usuario que tengas mas entradas

select * from entries;


select 

select name from users u inner join (select user_id from entries group by user_id order by COUNT(id) desc limit 1) entries  on u.id = entries.user_id ;
select count(id) from entries group by user_id order by COUNT(id) desc limit 1;

-- @@@@@@ mostrar las categorias sin entradas

insert into categories values(null,'diversion');

select * from categories where id not in (select category_id from entries);