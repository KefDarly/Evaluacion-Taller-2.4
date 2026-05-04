-- =====================================================
-- AUTOR: Chuquitapa Flores Kefren Darly
-- PROYECTO: Sistema de Seguimiento de Carga Ancha
-- =====================================================

-- =====================================================
-- SCRIPT COMPLETO - Base de Datos SeguimientoCargaAnchaDB
-- =====================================================

-- Cambiar a master y forzar cierre de conexiones
USE master;
GO

-- Destruir la base de datos si existe
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SeguimientoCargaAnchaDB')
BEGIN
    ALTER DATABASE SeguimientoCargaAnchaDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SeguimientoCargaAnchaDB;
END
GO

-- Crear base de datos nuevamente
CREATE DATABASE SeguimientoCargaAnchaDB;
GO

-- Usar la base de datos
USE SeguimientoCargaAnchaDB;
GO

-- =====================================================
-- 1. Tabla: empresa
-- =====================================================
CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY IDENTITY(1,1),
    razon_social NVARCHAR(150) NOT NULL,
    ruc NVARCHAR(20) UNIQUE NOT NULL,
    direccion NVARCHAR(200),
    telefono NVARCHAR(20)
);
GO

-- =====================================================
-- 2. Tabla: vehiculo
-- =====================================================
CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY IDENTITY(1,1),
    id_empresa INT NOT NULL,
    placa NVARCHAR(20) UNIQUE NOT NULL,
    marca NVARCHAR(50),
    modelo NVARCHAR(50),
    anio INT,
    capacidad_toneladas DECIMAL(10,2),
    CONSTRAINT FK_vehiculo_empresa FOREIGN KEY (id_empresa)
        REFERENCES empresa(id_empresa) ON DELETE CASCADE
);
GO

-- =====================================================
-- 3. Tabla: conductor
-- =====================================================
CREATE TABLE conductor (
    id_conductor INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(50) NOT NULL,
    apellido NVARCHAR(50) NOT NULL,
    licencia NVARCHAR(20) UNIQUE NOT NULL,
    telefono NVARCHAR(20)
);
GO

-- =====================================================
-- 4. Tabla: ruta
-- =====================================================
CREATE TABLE ruta (
    id_ruta INT PRIMARY KEY IDENTITY(1,1),
    origen NVARCHAR(100) NOT NULL,
    destino NVARCHAR(100) NOT NULL,
    distancia_km DECIMAL(10,2)
);
GO

-- =====================================================
-- 5. Tabla: monitoreo
-- =====================================================
CREATE TABLE monitoreo (
    id_monitoreo INT PRIMARY KEY IDENTITY(1,1),
    id_vehiculo INT NOT NULL,
    id_conductor INT NOT NULL,
    id_ruta INT NOT NULL,
    fecha_salida DATETIME NOT NULL,
    fecha_llegada DATETIME NULL,
    estado NVARCHAR(30) DEFAULT 'EN CURSO',
    CONSTRAINT CK_estado CHECK (estado IN ('EN CURSO', 'COMPLETADO', 'CANCELADO')),
    CONSTRAINT FK_monitoreo_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),
    CONSTRAINT FK_monitoreo_conductor FOREIGN KEY (id_conductor)
        REFERENCES conductor(id_conductor),
    CONSTRAINT FK_monitoreo_ruta FOREIGN KEY (id_ruta)
        REFERENCES ruta(id_ruta)
);
GO

-- =====================================================
-- 6. Tabla: consumo_combustible
-- =====================================================
CREATE TABLE consumo_combustible (
    id_consumo INT PRIMARY KEY IDENTITY(1,1),
    id_monitoreo INT NOT NULL,
    cantidad_litros DECIMAL(10,2) NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_consumo_monitoreo FOREIGN KEY (id_monitoreo)
        REFERENCES monitoreo(id_monitoreo) ON DELETE CASCADE
);
GO

-- =====================================================
-- 7. Tabla: incidencia
-- =====================================================
CREATE TABLE incidencia (
    id_incidencia INT PRIMARY KEY IDENTITY(1,1),
    id_monitoreo INT NOT NULL,
    tipo NVARCHAR(50) NOT NULL,
    descripcion NVARCHAR(200),
    fecha DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_incidencia_monitoreo FOREIGN KEY (id_monitoreo)
        REFERENCES monitoreo(id_monitoreo) ON DELETE CASCADE
);
GO

-- =====================================================
-- 8. Tabla: mantenimiento
-- =====================================================
CREATE TABLE mantenimiento (
    id_mantenimiento INT PRIMARY KEY IDENTITY(1,1),
    id_vehiculo INT NOT NULL,
    descripcion NVARCHAR(200),
    fecha DATE DEFAULT GETDATE(),
    costo DECIMAL(10,2),
    CONSTRAINT FK_mantenimiento_vehiculo FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo) ON DELETE CASCADE
);
GO

-- =====================================================
-- 9. Tabla: proveedor
-- =====================================================
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    ruc NVARCHAR(20) UNIQUE,
    telefono NVARCHAR(20),
    direccion NVARCHAR(200)
);
GO

-- =====================================================
-- 10. Tabla: repuesto
-- =====================================================
CREATE TABLE repuesto (
    id_repuesto INT PRIMARY KEY IDENTITY(1,1),
    id_proveedor INT NOT NULL,
    nombre NVARCHAR(100) NOT NULL,
    precio DECIMAL(10,2),
    stock INT DEFAULT 0,
    CONSTRAINT FK_repuesto_proveedor FOREIGN KEY (id_proveedor)
        REFERENCES proveedor(id_proveedor) ON DELETE CASCADE
);
GO

-- =====================================================
-- ÍNDICES PARA MEJOR RENDIMIENTO
-- =====================================================
CREATE INDEX IX_vehiculo_empresa ON vehiculo(id_empresa);
CREATE INDEX IX_monitoreo_vehiculo ON monitoreo(id_vehiculo);
CREATE INDEX IX_monitoreo_conductor ON monitoreo(id_conductor);
CREATE INDEX IX_monitoreo_ruta ON monitoreo(id_ruta);
CREATE INDEX IX_consumo_monitoreo ON consumo_combustible(id_monitoreo);
CREATE INDEX IX_incidencia_monitoreo ON incidencia(id_monitoreo);
CREATE INDEX IX_mantenimiento_vehiculo ON mantenimiento(id_vehiculo);
CREATE INDEX IX_repuesto_proveedor ON repuesto(id_proveedor);
GO

-- =====================================================
-- DATOS DE PRUEBA - EMPRESAS
-- =====================================================
INSERT INTO empresa (razon_social, ruc, direccion, telefono) VALUES
('Transportes Ejemplo S.A.C.', '20123456789', 'Av. Principal 123, Lima', '555-1000'),
('Logística Rápida S.R.L.', '20987654321', 'Calle Secundaria 456, Callao', '555-2000'),
('Carga Express E.I.R.L.', '20555555555', 'Av. Colonial 789, Lima', '555-3000');
GO

-- =====================================================
-- DATOS DE PRUEBA - CONDUCTORES
-- =====================================================
INSERT INTO conductor (nombre, apellido, licencia, telefono) VALUES
('Juan', 'Pérez', 'L123456', '955123456'),
('María', 'Gómez', 'L789012', '955789012'),
('Carlos', 'López', 'L345678', '955345678'),
('Ana', 'Martínez', 'L901234', '955901234'),
('Luis', 'Ramírez', 'L567890', '955567890'),
('Elena', 'Torres', 'L234567', '955234567'),
('Jorge', 'Flores', 'L678901', '955678901'),
('Patricia', 'Mendoza', 'L456789', '955456789'),
('Ricardo', 'Castro', 'L890123', '955890123'),
('Sofía', 'Rojas', 'L012345', '955012345');
GO

-- =====================================================
-- DATOS DE PRUEBA - RUTAS
-- =====================================================
INSERT INTO ruta (origen, destino, distancia_km) VALUES
('Lima', 'Callao', 15.5),
('Lima', 'Huacho', 148.0),
('Lima', 'Ica', 304.0),
('Lima', 'Trujillo', 560.0),
('Callao', 'Chancay', 78.0);
GO

-- =====================================================
-- DATOS DE PRUEBA - VEHÍCULOS
-- =====================================================
INSERT INTO vehiculo (id_empresa, placa, marca, modelo, anio, capacidad_toneladas) VALUES
(1, 'ABC-123', 'Volvo', 'FH16', 2020, 25.5),
(1, 'XYZ-789', 'Scania', 'R500', 2021, 30.0),
(2, 'DEF-456', 'Mercedes', 'Actros', 2019, 28.0),
(2, 'GHI-789', 'Volvo', 'FMX', 2022, 26.0),
(3, 'JKL-012', 'International', 'LT', 2020, 22.5);
GO

-- =====================================================
-- DATOS DE PRUEBA - MONITOREOS
-- =====================================================
INSERT INTO monitoreo (id_vehiculo, id_conductor, id_ruta, fecha_salida, fecha_llegada, estado) VALUES
(1, 1, 1, '2026-05-01 08:00:00', '2026-05-01 09:30:00', 'COMPLETADO'),
(2, 2, 2, '2026-05-02 07:00:00', '2026-05-02 10:00:00', 'COMPLETADO'),
(3, 3, 3, '2026-05-03 06:00:00', NULL, 'EN CURSO');
GO

-- =====================================================
-- DATOS DE PRUEBA - PROVEEDORES
-- =====================================================
INSERT INTO proveedor (nombre, ruc, telefono, direccion) VALUES
('Repuestos El Tigre', '20444444444', '555-4000', 'Av. Argentina 500, Lima'),
('Lubricantes San Pedro', '20555555555', '555-5000', 'Calle Los Olivos 123, Callao'),
('Neumáticos Andinos', '20666666666', '555-6000', 'Av. Universitaria 789, Lima');
GO

-- =====================================================
-- DATOS DE PRUEBA - REPUESTOS
-- =====================================================
INSERT INTO repuesto (id_proveedor, nombre, precio, stock) VALUES
(1, 'Filtro de Aceite', 45.50, 100),
(1, 'Pastillas de Freno', 120.00, 50),
(2, 'Aceite 15W40 (Galón)', 85.00, 200),
(3, 'Neumático 12R22.5', 850.00, 30);
GO

-- =====================================================
-- DATOS DE PRUEBA - CONSUMO COMBUSTIBLE
-- =====================================================
INSERT INTO consumo_combustible (id_monitoreo, cantidad_litros, costo_total) VALUES
(1, 45.5, 227.50),
(2, 120.0, 600.00),
(3, 80.0, 400.00);
GO

-- =====================================================
-- DATOS DE PRUEBA - INCIDENCIAS
-- =====================================================
INSERT INTO incidencia (id_monitoreo, tipo, descripcion) VALUES
(1, 'Retraso', 'Tráfico pesado en la Panamericana'),
(2, 'Mecánica', 'Revisión de frenos en el kilómetro 80');
GO

-- =====================================================
-- DATOS DE PRUEBA - MANTENIMIENTOS
-- =====================================================
INSERT INTO mantenimiento (id_vehiculo, descripcion, fecha, costo) VALUES
(1, 'Cambio de aceite y filtros', '2026-04-15', 350.00),
(2, 'Alineamiento y balanceo', '2026-04-20', 180.00),
(3, 'Revisión general de frenos', '2026-04-25', 450.00);
GO

-- =====================================================
-- VERIFICACIÓN FINAL
-- =====================================================
PRINT '==================================================';
PRINT 'BASE DE DATOS CREADA EXITOSAMENTE';
PRINT '==================================================';
PRINT '';

SELECT 'TABLAS CREADAS:' AS Mensaje;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME;
PRINT '';

SELECT 'REGISTROS POR TABLA:' AS Mensaje;
SELECT 'empresa' AS Tabla, COUNT(*) AS Registros FROM empresa
UNION SELECT 'vehiculo', COUNT(*) FROM vehiculo
UNION SELECT 'conductor', COUNT(*) FROM conductor
UNION SELECT 'ruta', COUNT(*) FROM ruta
UNION SELECT 'monitoreo', COUNT(*) FROM monitoreo
UNION SELECT 'proveedor', COUNT(*) FROM proveedor
UNION SELECT 'repuesto', COUNT(*) FROM repuesto;
PRINT '';

SELECT 'LISTA DE CONDUCTORES:' AS Mensaje;
SELECT id_conductor, nombre, apellido, licencia, telefono FROM conductor;
PRINT '';

PRINT '==================================================';
PRINT 'TODO LISTO PARA CONECTAR EN VISUAL STUDIO 2022';
PRINT '==================================================';
GO