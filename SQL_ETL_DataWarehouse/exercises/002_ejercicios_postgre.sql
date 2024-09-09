
-- Recupera todos los clientes (name y email) ordenados alfabéticamente por nombre.

SELECT customer_id
, NAME
, surname
FROM customer
order by "name"

-- Encuentra el número total de reservas.

SELECT COUNT(*)
FROM reservation

-- Muestra los detalles de las reservas (reservation_id, start_date, end_date) para un cliente específico (puedes elegir el customer_id).

SELECT reservation_id
, start_date
, end_date
FROM reservation
WHERE customer_id = 1

-- Encuentra el nombre y apellido de los propietarios que tienen apartamentos.

SELECT owner_id
, name
, surname
FROM owner
WHERE owner_id IN (SELECT owner_id FROM apartment)


-- Recupera el nombre y la ubicación de los apartamentos propiedad de un propietario específico (puedes elegir el owner_id).



-- Muestra las comodidades asociadas a un apartamento específico (puedes elegir el apartment_id).



-- Encuentra los clientes que no han realizado ninguna reserva.



-- Obtén el número total de apartamentos en una ubicación específica (puedes elegir la ubicación).



-- Recupera la información completa de las reservas (reservation_id, start_date, end_date) para los apartamentos que tienen un precio superior a cierto valor (puedes elegir el valor).



-- Encuentra el propietario con más apartamentos y muestra sus detalles (name, surname, email).



-- Muestra la ubicación y el número de reservas para cada ubicación, ordenado por número de reservas descendente.



-- Encuentra los clientes que han realizado al menos una reserva y muestra cuántas reservas han hecho.



-- Obtén el precio promedio de los apartamentos.



-- Recupera el nombre de las comodidades que están asociadas a más de un apartamento.



-- Encuentra los propietarios que tienen apartamentos en más de una ubicación.



-- Muestra las reservas que están programadas desde una fecha futura (puedes elegir la fecha).



-- Obtén el nombre de los clientes que han realizado reservas en al menos dos ubicaciones diferentes.



-- Obtén la ubicación con el mayor número de comodidades, mostrando el nombre de la ubicación y la cantidad de comodidades.



-- Obtén la cantidad total de reservas realizadas por cada cliente, ordenado de mayor a menor.



-- Clientes que han repetido en un mismo apartment


