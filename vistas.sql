
# Las vistas son una constante almacenada en la bbdd que se utiliza como una tabla virtual
# No almacena datos sino que utiliza asociaciones y los datos originales de las tablas, de forma que siempre se mantiene actualizada
# una vista es un alias de una consulta
# si una consulta va a ser muy reiterativa, se crea la vista

create view categoria_numero_entrada as 
select c.name, count(e.id) as total from categories c
left join entries e on c.id = e.category_id
group by e.category_id;

-- la vista se ve en tables
show tables;

-- renombrando la tabla
rename table categoria_numero_entrada to view_categoria_numero_entrada;

select * from view_categoria_numero_entrada where name = 'accion';