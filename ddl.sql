CREATE DATABASE logistica3;

USE logistica3;

CREATE TABLE paises (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    CONSTRAINT Pk_id_paises PRIMARY KEY (id)
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    direccion VARCHAR(200),
    CONSTRAINT Pk_id_clientes PRIMARY KEY (id)
);

CREATE TABLE tipos_servicios (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(50),
    CONSTRAINT Pk_id_tipos_servicios PRIMARY KEY (id)
);

CREATE TABLE estados (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(50),
    CONSTRAINT Pk_id_estados PRIMARY KEY (id)
);

CREATE TABLE marcas (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(50),
    CONSTRAINT Pk_id_marcas PRIMARY KEY (id)
);

CREATE TABLE modelos (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(50),
    CONSTRAINT Pk_id_modelos PRIMARY KEY (id)
);

CREATE TABLE paquetes (
    id INT AUTO_INCREMENT,
    numero_seguimiento VARCHAR(50),
    peso DECIMAL(10,2),
    dimensiones VARCHAR(50),
    contenido TEXT,
    valor_declarado DECIMAL(10,2),
    tipo_servicio_id INT,
    estado_id INT,
    CONSTRAINT Pk_id_paquetes PRIMARY KEY (id),
    CONSTRAINT Fk_id_paquetes_servicios FOREIGN KEY (tipo_servicio_id) REFERENCES tipos_servicios(id)
);

CREATE TABLE conductores (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    CONSTRAINT Pk_conductores PRIMARY KEY (id)
);

CREATE TABLE auxiliares (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    CONSTRAINT Pk_auxiliares PRIMARY KEY (id)
);

CREATE TABLE ciudades (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    pais_id INT,
    CONSTRAINT Pk_id_ciudades PRIMARY KEY (id),
    CONSTRAINT Fk_id_ciudades_paises FOREIGN KEY (pais_id) REFERENCES paises(id)
);

CREATE TABLE telefonos_clientes (
    id INT AUTO_INCREMENT,
    numero VARCHAR(20),
    cliente_id INT,
    CONSTRAINT Pk_id_telefonos_clientes PRIMARY KEY (id),
    CONSTRAINT Fk_id_telefonos_clientes_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE telefonos_conductores (
    id INT AUTO_INCREMENT,
    numero VARCHAR(20),
    conductor_id INT,
    CONSTRAINT Pk_id_telefonos_conductores PRIMARY KEY (id),
    CONSTRAINT Fk_id_telefonos_conductores_conductores FOREIGN KEY (conductor_id) REFERENCES conductores(id)
);

CREATE TABLE sucursales (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    ciudad_id INT,
    CONSTRAINT Pk_id_sucursales PRIMARY KEY (id),
    CONSTRAINT Fk_id_sucursales_ciudades FOREIGN KEY (ciudad_id) REFERENCES ciudades(id)
);

CREATE TABLE seguimiento (
    id INT AUTO_INCREMENT,
    paquete_id INT,
    ubicacion VARCHAR(200),
    fecha_hora TIMESTAMP,
    estado_id INT,
    CONSTRAINT Pk_id_seguimiento PRIMARY KEY (id),
    CONSTRAINT Fk_id_seguimiento_paquetes FOREIGN KEY (paquete_id) REFERENCES paquetes(id),
    CONSTRAINT Fk_id_seguimiento_estado FOREIGN KEY (estado_id) REFERENCES estados(id)
);

CREATE TABLE vehiculos (
    id INT AUTO_INCREMENT,
    placa VARCHAR(20),
    marca_id INT NOT NULL,
    modelo_id INT NOT NULL,
    capacidad_carga DECIMAL(10,2),
    sucursal_id INT,
    CONSTRAINT Pk_id_vehiculos PRIMARY KEY (id),
    CONSTRAINT Fk_id_vehiculos_marcas FOREIGN KEY (marca_id) REFERENCES marcas(id),
    CONSTRAINT Fk_id_vehiculos_modelos FOREIGN KEY (modelo_id) REFERENCES modelos(id),
    CONSTRAINT Fk_id_vehiculos_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

CREATE TABLE rutas (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(200),
    sucursal_id INT,
    CONSTRAINT Pk_id_rutas PRIMARY KEY (id),
    CONSTRAINT Fk_id_rutas_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

CREATE TABLE envios (
    id INT AUTO_INCREMENT,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP,
    destino VARCHAR(200),
    ruta_id INT,
    sucursal_id INT,
    CONSTRAINT Pk_id_envios PRIMARY KEY (id),
    CONSTRAINT Fk_id_envios_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT Fk_id_envios_paquetes FOREIGN KEY (paquete_id) REFERENCES paquetes(id),
    CONSTRAINT Fk_id_envios_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(id),
    CONSTRAINT Fk_id_envios_sucursales FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

CREATE TABLE conductores_rutas (
    conductor_id INT AUTO_INCREMENT,
    ruta_id INT,
    vehiculo_id INT,
    sucursal_id INT,
    CONSTRAINT Pk_id_conductores_rutas PRIMARY KEY (conductor_id, ruta_id),
    CONSTRAINT Fk_conductores_rutas_conductores_id FOREIGN KEY (conductor_id) REFERENCES conductores(id),
    CONSTRAINT Fk_conductores_rutas_rutas_id FOREIGN KEY (ruta_id) REFERENCES rutas(id),
    CONSTRAINT Fk_conductores_rutas_vehiculos_id FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id),
    CONSTRAINT Fk_conductores_rutas_sucursales_id FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
);

CREATE TABLE ruta_auxiliares (
    ruta_id INT,
    auxiliar_id INT,
    CONSTRAINT Pk_id_ruta_auxiliares PRIMARY KEY (ruta_id, auxiliar_id),
    CONSTRAINT Fk_id_ruta_auxiliares_rutas FOREIGN KEY (ruta_id) REFERENCES rutas(id),
    CONSTRAINT Fk_id_ruta_auxiliares_auxiliares FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(id)
);
