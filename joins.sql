use udemy;

select * from categories;

select * from entries;

-- @@@@@ mostrar las entradas con el nombre del autor y el nombre de la categoria

-- selecciona el name de la tabla usuarios, el title de la tabla entries y name de la tabla categories where entries.user_id = users.id y entries_category_id = category_id
select e.id, u.name, e.title, c.name from users u, entries e , categories c where e.user_id = u.id and e.category_id = c.id order by (u.name);

-- si se quita la condicion de "and e.category_id = c.id" que coincida en las categorias, va a mostrar todas las coincidicencias con todas las categorias,por eso casa fila existe 4 veces (una por cada categoria existente)
select e.id, u.name, e.title, c.name from users u, entries e , categories c where e.user_id = u.id order by (e.id);

-- @@@@@ mostrar el nombre de las categorias y cuantas entradas tienen

-- contar todas las entries.id y de esa cuenta, agrupa por diferentes category_id
select categories.name, count(entries.id) from categories, entries where categories.id = entries.category_id group by category_id;


-- @@@@@ mostrar el mail de los usuarios y al lado cuantas entradas tiene

select * from users;

select * from entries;

select email,count(e.id) as 'entradas' from users u , entries e where u.id = e.user_id group by (e.user_id);

-- ##### las consultas de arriba lo que hace es recorrer todas las filas y todas la tablas y solo muestra lo que se le ha pedido #####
-- ##### los joins no recorren todas las tablas

-- @@@@@ mostrar las entradas con el nombre del autor y el nombre de la categoria

-- INNER JOIN -> junta solo lo que coincide entre la tabla de la izquierda con la tabla de la derecha
select u.name, e.id, e.title as 'autor',c.name as 'categoria' from entries e
inner join users u on e.user_id = u.id
inner join categories c on e.category_id = c.id
order by u.name;

-- @@@@@ mostrar el nombre de las categorias y cuantas entradas tienen

-- LEFT JOIN -> 

select c.name, count(e.id) as total from categories c
left join entries e on c.id = e.category_id
group by e.category_id;


-- muestra todos los registros de la tabla de la izquierda y de la tabla de la derecha solo muestra lo que coincide, si no coincide devuelve null y si es un cont() devuelve 0

select c.name, e.title as total from categories c
left join entries e on c.id = e.category_id
group by e.category_id;

-- voy a crear una vista de esta consulta de aqui arriba en el archivo vistas






