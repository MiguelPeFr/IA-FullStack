
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

SELECT name, location 
    FROM owner
    JOIN apartment
    ON owner.owner_id = apartment.owner_id
WHERE owner.owner_id = 1


-- Muestra las comodidades asociadas a un apartamento específico (puedes elegir el apartment_id).
SELECT amenity.name

FROM apt_amenity
JOIN amenity
ON apt_amenity.amenity_id = amenity.amenity_id

WHERE apt_amenity.apartment_id = 1


-- Encuentra los clientes que no han realizado ninguna reserva.

SELECT *
FROM customer

FULL 
JOIN reservation
ON customer.customer_id = reservation.customer_id

WHERE reservation IS NULL


-- Obtén el número total de apartamentos en una ubicación específica (puedes elegir la ubicación).

SELECT COUNT(*)

FROM apartment
WHERE location = 'Madrid'

-- Recupera la información completa de las reservas (reservation_id, start_date, end_date) para los apartamentos que tienen un precio superior a cierto valor (puedes elegir el valor).

SELECT reservation_id, start_date, end_date
FROM reservation
JOIN (SELECT *
		FROM apartment
		WHERE price > 150) AS apt_caros
	ON reservation.apartment_id = apt_caros.apartment_id

-- Encuentra el propietario con más apartamentos y muestra sus detalles (name, surname, email).

WITH propietario_mayor

	AS (SELECT apartment.owner_id
		,COUNT (1) AS numero_apartamentos
		FROM apartment
		GROUP BY owner_id
		ORDER BY numero_apartamentos DESC
		LIMIT 1)
		
SELECT name, surname, email
	FROM owner
	JOIN propietario_mayor
	ON owner.owner_id = propietario_mayor.owner_id
	ORDER BY propietario_mayor.numero_apartamentos DESC

-- Muestra la ubicación y el número de reservas para cada ubicación, ordenado por número de reservas descendente.

SELECT location
	, COUNT (reservation.reservation_id) AS count_reservation
FROM apartment
LEFT
JOIN reservation
ON apartment.apartment_id = reservation.reservation_id
GROUP BY LOCATION
ORDER BY count_reservation DESC


-- Encuentra los clientes que han realizado al menos una reserva y muestra cuántas reservas han hecho.

SELECT name
, COUNT (*) AS res
FROM reservation
JOIN customer
ON customer.customer_id = reservation.customer_id
GROUP BY name
ORDER by res DESC

-- Obtén el precio promedio de los apartamentos.



-- Recupera el nombre de las comodidades que están asociadas a más de un apartamento.



-- Encuentra los propietarios que tienen apartamentos en más de una ubicación.



-- Muestra las reservas que están programadas desde una fecha futura (puedes elegir la fecha).



-- Obtén el nombre de los clientes que han realizado reservas en al menos dos ubicaciones diferentes.



-- Obtén la ubicación con el mayor número de comodidades, mostrando el nombre de la ubicación y la cantidad de comodidades.



-- Obtén la cantidad total de reservas realizadas por cada cliente, ordenado de mayor a menor.



-- Clientes que han repetido en un mismo apartment


