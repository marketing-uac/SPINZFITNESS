-- Script SQL para la base de datos del Gimnasio
-- Nombre de la base de datos: gimnasio_db

CREATE DATABASE IF NOT EXISTS gimnasio_db;
USE gimnasio_db;

-- 1. Tabla de Membresías (Planes)
CREATE TABLE IF NOT EXISTS membresias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    duracion_meses INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Usuarios (Acceso al sistema)
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'recepcionista', 'entrenador') DEFAULT 'recepcionista'
);

-- 3. Tabla de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_registro DATE,
    estado ENUM('activo', 'inactivo') DEFAULT 'activo'
);

-- 4. Tabla de Pagos
CREATE TABLE IF NOT EXISTS pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    membresia_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia') NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (membresia_id) REFERENCES membresias(id)
);

-- DATOS DE EJEMPLO PARA MEMBRESÍAS
INSERT INTO membresias (nombre, descripcion, precio, duracion_meses) VALUES 
('Básico', 'Acceso a zona de pesas y cardio', 29.00, 1),
('Premium', 'Acceso total + Clases grupales + Sauna', 49.00, 1),
('Anual', 'Todo el plan Premium con descuento anual', 450.00, 12);

-- USUARIO ADMINISTRADOR DE EJEMPLO
INSERT INTO usuarios (username, password, rol) VALUES 
('admin_spinz', 'password_segura_123', 'admin');
