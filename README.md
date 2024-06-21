

# 		Base de datos logistica

![](/home/camper/.config/Typora/typora-user-images/image-20240621132318921.png)

https://dbdiagram.io/d/6675cc755a764b3c721b01ca ENLACE DEL DIAGRAMA E-R



## Consultas sobre una tabla

### Caso de Uso 1: Registrar un Nuevo País
Descripción: Un administrador desea agregar un nuevo país a la base de datos.

```sql
INSERT INTO paises (nombre) VALUES
("Venezuela");
```



### Caso de Uso 2: Registrar una Nueva Ciudad
Descripción: Un administrador desea agregar una nueva ciudad asociada a un país existente.

```sql
INSERT INTO ciudades (nombre,pais_id) VALUES
("Caracas",5);
```



### Caso de Uso 3: Registrar una Nueva Sucursal
Descripción: Un administrador desea agregar una nueva sucursal asociada a una ciudad existente.

```sql
INSERT INTO sucursales (nombre,direccion,ciudad_id) VALUES
("Sucursal Caracas","calle 01 #25-12",9);
```



### Caso de Uso 4: Registrar un Nuevo Cliente

Descripción: Un administrador desea registrar un nuevo cliente en la base de datos.

```sql
INSERT INTO clientes (nombre, email, direccion) VALUES 
('Andrey Jerez', 'Andrey@gmail.com', 'Calle 123 #42-12');
```



### Caso de Uso 5: Registrar un Nuevo Teléfono para un Cliente

Descripción: Un administrador desea agregar un número de teléfono para un cliente existente.

```sql
INSERT INTO telefonos_clientes (numero, cliente_id) VALUES 
('313-3665774', 4);
```



### Caso de Uso 6: Registrar un Nuevo Paquete

Descripción: Un administrador desea registrar un nuevo paquete en la base de datos.

```sql
INSERT INTO paquetes (numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio_id, estado_id) VALUES 
('10001', 2, '20x20x15 cm', 'Libros', 120000, 1, 1);
```



### Caso de Uso 7: Registrar un Nuevo Envío

Descripción: Un administrador desea registrar un nuevo envío, asociando un cliente, paquete, ruta y sucursal.

```sql
INSERT INTO envios (cliente_id, paquete_id, fecha_envio, destino, ruta_id, sucursal_id) VALUES 
(4, 4, '2024-06-20 3:30:00', 'Broadway New York', 1, 9);
```



### Caso de Uso 8: Registrar un Nuevo Vehículo

Descripción: Un administrador desea agregar un nuevo vehículo a la base de datos.

```sql
INSERT INTO vehiculos (placa, marca_id, tipo_vehiculo_id, capacidad_carga, sucursal_id) VALUES 
('POV420', 1, 1, 2000.00, 9);
```



### Caso de Uso 9: Registrar un Nuevo Conductor

Descripción: Un administrador desea agregar un nuevo conductor a la base de datos.

```sql
INSERT INTO conductores (nombre) VALUES 
('Andrey Felipe');
```



### Caso de Uso 10: Registrar un Nuevo Teléfono para un Conductor

Descripción: Un administrador desea agregar un número de teléfono para un conductor existente.

```sql
INSERT INTO telefonos_conductores (numero, conductor_id) VALUES 
('302-0678123', 3);
```



### Caso de Uso 11: Asignar un Conductor a una Ruta y un Vehículo

Descripción: Un administrador desea asignar un conductor a una ruta específica utilizando un vehículo.

```sql
INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id) VALUES 
(3, 4, 4, 9);
```



### Caso de Uso 12: Registrar un Nuevo Auxiliar

Descripción: Un administrador desea agregar un nuevo auxiliar de reparto a la base de datos.

```sql
INSERT INTO auxiliares (nombre, telefono) VALUES 
('Andrey Rubio', '345-6653422');
```



### Caso de Uso 13: Asignar un Auxiliar a una Ruta

Descripción: Un administrador desea asignar un auxiliar de reparto a una ruta específica.

```sql
INSERT INTO ruta_auxiliares (ruta_id, auxiliar_id) VALUES 
(4, 3);
```



### Caso de Uso 14: Registrar un Evento de Seguimiento para un Paquete

Descripción: Un administrador desea registrar un evento de seguimiento para un paquete.

```sql
INSERT INTO seguimiento (paquete_id, ubicacion, fecha_hora, estado_id) VALUES 
(4, 'Nueva York, NY, Estados Unidos', '2024-06-19 10:00:00', 1);
```



### Caso de Uso 15: Generar un Reporte de Envíos por Cliente

Descripción: Un administrador desea generar un reporte de todos los envíos realizados por un cliente específico.

```sql
SELECT e.id AS envio_id
FROM envios e
JOIN clientes c ON e.cliente_id = c.id
WHERE c.id = 4;

+----------+
| envio_id |
+----------+
|        4 |
+----------+
```



### Caso de Uso 16: Actualizar el Estado de un Paquete

Descripción: Un administrador desea actualizar el estado de un paquete específico.

```sql
UPDATE paquetes
SET estado_id = 2
WHERE id = 4;

Query OK, 1 row affected (0,00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```



### Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete

Descripción: Un administrador desea rastrear la ubicación actual de un paquete específico.

```sql
SELECT se.ubicacion as ubicacion
FROM seguimientos se
JOIN paquetes p ON se.paquete_id = p.id
WHERE p.id = 4
ORDER BY se.fecha_hora DESC LIMIT 1;

+--------------------------------+
| ubicacion                      |
+--------------------------------+
| Nueva York, NY, Estados Unidos |
+--------------------------------+
```



## Casos multitabla

### Caso de Uso 1: Obtener Información Completa de Envíos

Descripción: Un administrador desea obtener la información completa de todos los envíos, incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal.

```sql
SELECT 
    e.id AS envio,
    c.nombre AS cliente_nombre,
    c.email AS cliente_email,
    p.numero_seguimiento AS NumeroSeguimiento,
    p.peso AS Peso,
    p.dimensiones AS Dimensiones,
    p.contenido AS Contenido,
    p.valor_declarado AS Valor,
    ts.descripcion AS Servicio,
    es.descripcion AS Estado,
    e.fecha_envio,
    e.destino,
    r.descripcion AS ruta_descripcion,
    s.nombre AS sucursal_nombre,
    co.nombre AS conductor_nombre,
    ve.placa AS vehiculo_placa
FROM 
    envios e
JOIN 
    clientes c ON e.cliente_id = c.id
JOIN 
    paquetes p ON e.paquete_id = p.id
JOIN 
    tipos_servicios ts ON p.tipo_servicio_id = ts.id
JOIN 
    estados es ON p.estado_id = es.id
JOIN 
    rutas r ON e.ruta_id = r.id
JOIN 
    sucursales s ON e.sucursal_id = s.id
JOIN 
    conductores_rutas cr ON r.id = cr.ruta_id
JOIN 
    conductores co ON cr.conductor_id = co.id
JOIN 
    vehiculos ve ON cr.vehiculo_id = ve.id
ORDER BY 
    e.id;
```



### Caso de Uso 2: Obtener Historial de Envíos de un Cliente

Descripción: Un administrador desea obtener el historial completo de envíos de un cliente específico, incluyendo detalles de los paquetes y los eventos de seguimiento.

```sql
SELECT 
    e.id AS envio,
    c.nombre AS cliente_Nombre,
    c.email AS Email,
    p.numero_seguimiento AS paquete_numero_seguimiento,
    p.peso AS Peso,
    p.dimensiones AS Dimensiones,
    p.contenido AS Contenido,
    p.valor_declarado AS Valor,
    ts.descripcion AS Servicio,
    es.descripcion AS Estado,
    e.fecha_envio,
    e.destino,
    r.descripcion AS ruta_descripcion,
    s.nombre AS sucursal_nombre,
    co.nombre AS conductor_nombre,
    ve.placa AS vehiculo_placa
FROM 
    envios e
JOIN 
    clientes c ON e.cliente_id = c.id
JOIN 
    paquetes p ON e.paquete_id = p.id
JOIN 
    tipos_servicios ts ON p.tipo_servicio_id = ts.id
JOIN 
    estados es ON p.estado_id = es.id
JOIN 
    rutas r ON e.ruta_id = r.id
JOIN 
    sucursales s ON e.sucursal_id = s.id
JOIN 
    conductores_rutas cr ON r.id = cr.ruta_id
JOIN 
    conductores co ON cr.conductor_id = co.id
JOIN 
    vehiculos ve ON cr.vehiculo_id = ve.id
WHERE
	e.cliente_id = 4;

```



### Caso de Uso 3: Listar Conductores y sus Rutas Asignadas

Descripción: Un administrador desea obtener una lista de todos los conductores y las rutas a las que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente.

```sql
SELECT 
	c.nombre AS conductor_nombre,
	r.descripcion AS ruta,
	v.id AS vehiculo_id,
	v.placa AS placa,
	ma.descripcion,
	m.descripcion,
	s.nombre AS sucursal_nombre
FROM
	conductores_rutas cr
JOIN
	conductores c ON cr.conductor_id = c.id
JOIN
	rutas r ON cr.ruta_id = r.id
JOIN
	vehiculos v ON cr.vehiculo_id = v.id
JOIN
	marcas ma ON v.marca_id = ma.id
JOIN
	modelos m ON v.modelo_id = m.id
JOIN
	sucursales s ON r.sucursal_id = s.id;

```



### Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados

Descripción: Un administrador desea obtener detalles de todas las rutas, incluyendo los auxiliares asignados a cada ruta.

```sql
SELECT 
	r.id AS ruta_id,
	r.descripcion,
	a.id AS auxiliar_id,
	a.nombre
FROM 
	ruta_auxiliares ra
JOIN
	rutas r ON ra.ruta_id = r.id
JOIN
	auxiliares a ON ra.auxiliar_id = a.id;

```



### Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado

Descripción: Un administrador desea generar un reporte de todos los paquetes agrupados por sucursal y estado.

```sql
SELECT
	s.nombre AS Nombresucursal,
	p.id AS IDpaquete,
	p.contenido,
	es.descripcion AS Estado
FROM
	envios e
JOIN 
	sucursales s ON e.sucursal_id = s.id
JOIN
	paquetes p ON e.paquete_id = p.id
JOIN
	estados es ON p.estado_id = es.id
WHERE
	es.id = 1 AND s.id = 1;
```



### Caso de Uso 6: Obtener Información Completa de un Paquete y su Historial de Seguimiento

Descripción: Un administrador desea obtener la información completa de un paquete específico
y su historial de seguimiento.

```sql
SELECT
	p.id AS IDpaquete,
	p.numero_seguimiento AS NumSeguimiento,
	p.peso,
	p.dimensiones,
	p.contenido,
	p.valor_declarado AS Valor,
	ts.descripcion AS Servicio,
	e.descripcion AS Estado,
	s.ubicacion,
	s.fecha_hora
FROM
	seguimiento s
JOIN
	paquetes p ON s.paquete_id = p.id
JOIN
	tipos_servicios ts ON p.tipo_servicio_id = ts.id
JOIN
	estados e ON s.estado_id = e.id
WHERE
	p.id = 4;

```



## Casos de uso Between, In y Not In

### Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los paquetes que fueron enviados dentro de un rango de fechas específico.

```sql
SELECT
	e.paquete_id
FROM 
	envios e
WHERE
	e.fecha_envio Between '2024-06-19 10:30:00' AND '2024-06-19 12:30:00';
```



### Caso de Uso 2: Obtener Paquetes con Ciertos Estados

Descripción: Un administrador desea obtener todos los paquetes que tienen ciertos estados específicos (por ejemplo, 'en tránsito' o 'entregado').

```sql
SELECT
	se.paquete_id,
	p.contenido,
	p.valor_declarado,
	e.descripcion
FROM
	seguimiento se
JOIN
	paquetes p ON se.paquete_id = p.id
JOIN
	estados e ON se.estado_id = e.id
WHERE
	e.descripcion IN ('en transito','entregado');
```



### Caso de Uso 3: Obtener Paquetes Excluyendo Ciertos Estados

Descripción: Un administrador desea obtener todos los paquetes excluyendo aquellos que tienen ciertos estados específicos (por ejemplo, 'recibido' o 'retenido en aduana').

```sql
SELECT
	se.paquete_id,
	p.contenido,
	p.valor_declarado,
	e.descripcion
FROM
	seguimiento se
JOIN
	paquetes p ON se.paquete_id = p.id
JOIN
	estados e ON se.estado_id = e.id
WHERE
	e.descripcion NOT IN ('recibido','retenido en aduana');
```



### Caso de Uso 4: Obtener Clientes con Envíos Realizados Dentro de un Rango de Fechas

Descripción: Un administrador desea obtener todos los clientes que realizaron envíos dentro de un rango de fechas específico.

```sql
SELECT 
	c.id,
	c.nombre,
	e.id,
	e.fecha_envio
FROM
	envios e
JOIN 
	clientes c ON e.cliente_id = c.id
WHERE
	e.fecha_envio BETWEEN '2024-06-19 12:30:00' AND '2024-06-19 14:30:00';
```



### Caso de Uso 5: Obtener Conductores Disponibles que No Están Asignados a Ciertas Rutas

Descripción: Un administrador desea obtener todos los conductores que no están asignados a ciertas rutas específicas.

```sql
SELECT
    c.id,
    c.nombre
FROM
    conductores_rutas cr
JOIN
    conductores c ON cr.conductor_id = c.id
JOIN
    rutas r ON cr.ruta_id = r.id
WHERE
    r.id NOT IN (2, 3);
```



### Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico

Descripción: Un administrador desea obtener todos los paquetes cuyo valor declarado está dentro de un rango específico.

```sql
SELECT 
	p.id,
	p.numero_seguimiento,
	p.contenido
FROM
	paquetes p
WHERE 
	p.valor_declarado BETWEEN 50.00 AND 150.00;
```



### Caso de Uso 7: Obtener Auxiliares Asignados a Rutas Específicas

Descripción: Un administrador desea obtener todos los auxiliares de reparto que están asignados a ciertas rutas específicas.

```sql
SELECT 
	a.id,
	a.nombre
FROM
	ruta_auxiliares ra
JOIN
	auxiliares a ON ra.ruta_id = a.id
JOIN
	rutas r ON ra.auxiliar_id = r.id
WHERE 
	r.id IN (1,3) ;
```



### Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades

Descripción: Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas
ciudades específicas.

```sql
SELECT 
	e.id,
	e.fecha_envio,
	e.destino
FROM
	envios e
WHERE 
	e.destino NOT IN ('456 Elm St, Los Ángeles, CA, Estados Unidos','103 Birch St, Vancouver, Canadá');
```



### Caso de Uso 9: Obtener Seguimientos de Paquetes en unRango de Fechas

Descripción: Un administrador desea obtener todos los eventos de seguimiento de paquetes que ocurrieron dentro de un rango de fechas específico.

```sql
SELECT 
	se.paquete_id,
	se.fecha_hora
FROM
	seguimiento se
WHERE 
	se.fecha_hora BETWEEN '2024-06-19 10:00:00' AND '2024-06-19 13:00:00';
```



### Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes

Descripción: Un administrador desea obtener todos los clientes que tienen paquetes de ciertos tipos específicos (por ejemplo, 'nacional' o 'internacional').

```sql
SELECT
	p.id,
	p.contenido,
	p.valor_declarado,
	ts.descripcion
FROM
	paquetes p
JOIN
	tipos_servicios ts ON p.tipo_servicio_id = ts.id
WHERE
	ts.descripcion IN ('Envio Estandar','Envio Internacional');
```



