INSERT INTO paises (nombre) VALUES 
('Estados Unidos'),
('México'),
('Canadá'),
('España');

INSERT INTO clientes (nombre, email, direccion) VALUES 
('Juan Pérez', 'juan.perez@example.com', 'Calle Falsa 123, Ciudad de México, México'),
('Ana García', 'ana.garcia@example.com', 'Avenida Siempre Viva 742, Monterrey, México'),
('Carlos López', 'carlos.lopez@example.com', 'Calle Principal 456, Madrid, España');

INSERT INTO conductores (nombre) VALUES 
('Pedro Gómez'),
('Luis Martínez');

INSERT INTO auxiliares (nombre, telefono) VALUES 
('María Rodríguez', '555-1234'),
('Jorge Sánchez', '555-5678');

INSERT INTO tipos_servicios (descripcion) VALUES 
('Envío Rápido'),
('Envío Estándar'),
('Envío Internacional');

INSERT INTO estados (descripcion) VALUES 
('En Tránsito'),
('Entregado'),
('Pendiente de Recogida'),
('Devuelto');

INSERT INTO marcas (descripcion) VALUES 
('Toyota'),
('Ford'),
('Chevrolet'),
('Nissan');

INSERT INTO modelos (descripcion) VALUES 
('Camión'),
('Van'),
('SUV');

INSERT INTO ciudades (nombre, pais_id) VALUES 
('Nueva York', 1),
('Los Ángeles', 1),
('Ciudad de México', 2),
('Monterrey', 2),
('Toronto', 3),
('Vancouver', 3),
('Madrid', 4),
('Barcelona', 4);

INSERT INTO telefonos_clientes (numero, cliente_id) VALUES 
('555-1111', 1),
('555-2222', 2),
('555-3333', 3);

INSERT INTO telefonos_conductores (numero, conductor_id) VALUES 
('555-4444', 1),
('555-5555', 2);

INSERT INTO sucursales (nombre, direccion, ciudad_id) VALUES 
('Sucursal Nueva York', '123 Main St, Nueva York, NY, Estados Unidos', 1),
('Sucursal Los Ángeles', '456 Elm St, Los Ángeles, CA, Estados Unidos', 2),
('Sucursal Ciudad de México', '789 Oak St, Ciudad de México, México', 3),
('Sucursal Monterrey', '101 Pine St, Monterrey, México', 4),
('Sucursal Toronto', '102 Maple St, Toronto, Canadá', 5),
('Sucursal Vancouver', '103 Birch St, Vancouver, Canadá', 6),
('Sucursal Madrid', '104 Cherry St, Madrid, España', 7),
('Sucursal Barcelona', '105 Willow St, Barcelona, España', 8);

INSERT INTO paquetes (numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio_id, estado_id) VALUES 
('TRACK123', 1.5, '30x20x10 cm', 'Libros', 100.00, 1, 1),
('TRACK456', 2.0, '40x30x20 cm', 'Ropa', 200.00, 2, 2),
('TRACK789', 0.5, '20x10x5 cm', 'Electrónicos', 50.00, 3, 3);

INSERT INTO seguimiento (paquete_id, ubicacion, fecha_hora, estado_id) VALUES 
(1, 'Nueva York, NY, Estados Unidos', '2024-06-19 10:00:00', 1),
(2, 'Los Ángeles, CA, Estados Unidos', '2024-06-19 12:00:00', 2),
(3, 'Ciudad de México, México', '2024-06-19 14:00:00', 3);

INSERT INTO vehiculos (placa, marca_id, modelo_id, capacidad_carga, sucursal_id) VALUES 
('ABC123', 1, 1, 1000.00, 1),
('DEF456', 2, 2, 800.00, 2),
('GHI789', 3, 3, 600.00, 3);

INSERT INTO rutas (descripcion, sucursal_id) VALUES 
('Ruta 1 - Nueva York a Los Ángeles', 1),
('Ruta 2 - Ciudad de México a Monterrey', 3),
('Ruta 3 - Toronto a Vancouver', 5);

INSERT INTO envios (cliente_id, paquete_id, fecha_envio, destino, ruta_id, sucursal_id) VALUES 
(1, 1, '2024-06-19 10:30:00', '456 Elm St, Los Ángeles, CA, Estados Unidos', 1, 1),
(2, 2, '2024-06-19 12:30:00', '101 Pine St, Monterrey, México', 2, 3),
(3, 3, '2024-06-19 14:30:00', '103 Birch St, Vancouver, Canadá', 3, 5);

INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id) VALUES 
(1, 1, 1, 1),
(2, 2, 2, 3);

INSERT INTO ruta_auxiliares (ruta_id, auxiliar_id) VALUES 
(1, 1),
(2, 2);
