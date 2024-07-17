drop schema BANCO_GRUPO1;

create schema BANCO_GRUPO1;
use BANCO_GRUPO1;

CREATE TABLE paises (
    pais_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE provincias (
    provincia_id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    pais_id INT NOT NULL,
    PRIMARY KEY (provincia_id, pais_id),
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id) 
);

CREATE TABLE localidades (
    localidad_id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    provincia_id INT NOT NULL,
    PRIMARY KEY (localidad_id, provincia_id),
    FOREIGN KEY (provincia_id) REFERENCES provincias(provincia_id)
);

CREATE TABLE tipos_usuarios (
	tipos_usuario_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_usuario VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL,
    tipo_usuario_id INT NOT NULL,
	estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipos_usuarios(tipos_usuario_id)
);

CREATE TABLE clientes (
    dni VARCHAR(8) NOT NULL UNIQUE,
    cuil VARCHAR(13) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    sexo ENUM('M', 'F', 'X') NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    localidad_id INT NOT NULL,
    provincia_id INT NOT NULL,                                                   
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    usuario_id INT NOT NULL,
	estado BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (dni, usuario_id),
    FOREIGN KEY (localidad_id, provincia_id) REFERENCES localidades(localidad_id, provincia_id),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
);

CREATE TABLE tiposcuentas (
    id_tipoCuenta INT NOT NULL AUTO_INCREMENT, 
    tipo_cuenta VARCHAR(22) NOT NULL,
    PRIMARY KEY (id_tipoCuenta)
);

CREATE TABLE cuentas (
    numero_cuenta INT NOT NULL AUTO_INCREMENT, 
    cbu VARCHAR(22) NOT NULL UNIQUE,
    dni VARCHAR(8) NOT NULL,
    fecha_creacion DATE NOT NULL,
    id_tipoCuenta INT NOT NULL,
    saldo DECIMAL(10, 2) DEFAULT 10000.00,
    estado BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (numero_cuenta, cbu, dni),
    FOREIGN KEY (dni) REFERENCES clientes(dni),
    FOREIGN KEY (id_tipoCuenta) REFERENCES tiposcuentas(id_tipoCuenta),
    CHECK (saldo >= 0)
);

CREATE TABLE tipos_prestamo (
    tipo_prestamo_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    importe_total DECIMAL(10, 2) NOT NULL,
    importe_intereses DECIMAL(10, 2) NOT NULL,
    nro_cuotas INT NOT NULL,
    cuota_mensual DECIMAL(10, 2) NOT NULL,
    interes_anual INT NOT NULL
);

CREATE TABLE prestamos (
    prestamo_id INT NOT NULL AUTO_INCREMENT,
    numero_cuenta INT NOT NULL,
    fecha DATE NOT NULL,
    plazo_pago int NOT NULL,
    tipo_prestamo_id INT NOT NULL,
    estado_prestamo ENUM('Autorizado', 'Rechazado', 'En proceso') NOT NULL default 'En proceso',
    estado  ENUM('Vigente', 'Cancelado') NOT NULL default 'Vigente',
    PRIMARY KEY(prestamo_id,numero_cuenta),
    FOREIGN KEY (tipo_prestamo_id) REFERENCES tipos_prestamo(tipo_prestamo_id),
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta)
);

CREATE TABLE cuotas (
    cuota_id INT NOT NULL AUTO_INCREMENT,
    prestamo_id INT NOT NULL,
    numero_cuota INT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE,
    PRIMARY KEY(cuota_id, prestamo_id),
    FOREIGN KEY (prestamo_id) REFERENCES prestamos(prestamo_id)
);

CREATE TABLE movimientos (
    movimiento_id INT NOT NULL AUTO_INCREMENT,
    numero_cuenta INT NOT NULL,
    fecha DATE NOT NULL,
    detalle VARCHAR(255),
    importe DECIMAL(10, 2) NOT NULL,
    tipo_movimiento ENUM('alta de cuenta', 'alta de préstamo', 'pago de préstamo', 'transferencia') NOT NULL,
    PRIMARY KEY(movimiento_id, numero_cuenta),
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta)
);

CREATE TABLE transferencias (
    transferencia_id INT NOT NULL AUTO_INCREMENT,
	dni VARCHAR(8) NOT NULL,
    cbu_origen VARCHAR(22) NOT NULL,
    cbu_destino VARCHAR(22) NOT NULL,
    fecha DATE NOT NULL,
    detalle VARCHAR(255),
    importe DECIMAL(10, 2) NOT NULL,
    movimiento_id INT NOT NULL,
    PRIMARY KEY (transferencia_id),
	FOREIGN KEY (dni) REFERENCES clientes(dni),
    FOREIGN KEY (cbu_origen) REFERENCES cuentas(cbu),
    FOREIGN KEY (movimiento_id) REFERENCES movimientos(movimiento_id)
);

DELIMITER //
CREATE PROCEDURE SP_BAJA_CLIENTE(
    _dni VARCHAR(8),
    _idUsuario INT
)
BEGIN
      UPDATE clientes SET estado = FALSE WHERE dni = _dni;
      UPDATE cuentas SET estado = FALSE  WHERE dni = _dni;
      UPDATE usuarios SET estado = FALSE WHERE usuario_id = _idUsuario;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_TRANSFERENCIAS(
    cbuOrigen VARCHAR(22),
    cbuDestino VARCHAR(22),
    importe DECIMAL(10,2),
    detalle VARCHAR(255)
)
BEGIN
	DECLARE fechaActual  DATE DEFAULT CURDATE();
    DECLARE saldoOrigen DECIMAL(10,2);
    DECLARE saldoDestino DECIMAL(10,2);
    DECLARE cuentaDestinoExiste BOOLEAN;
    DECLARE idMovOrigen INT;
    DECLARE idMovDestino INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT saldo INTO saldoOrigen FROM cuentas WHERE cbu = cbuOrigen;
    IF saldoOrigen < importe THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente en la cuenta de origen';
    END IF;
	SELECT saldo INTO saldoDestino FROM cuentas WHERE cbu = cbuOrigen;

	INSERT INTO movimientos (numero_cuenta, fecha, detalle, importe, tipo_movimiento)
	VALUES ((SELECT numero_cuenta FROM cuentas WHERE cbu = cbuOrigen),fechaActual,detalle,-importe,'transferencia');

	SET idMovOrigen = LAST_INSERT_ID();

	INSERT INTO transferencias (dni, cbu_origen, cbu_destino, fecha, detalle, importe, movimiento_id)
	VALUES ((SELECT dni FROM cuentas WHERE cbu = cbuOrigen),cbuOrigen,cbuDestino,fechaActual, detalle, importe,idMovOrigen);
	UPDATE cuentas SET saldo = saldo - importe WHERE cbu = cbuOrigen;
    
	SELECT COUNT(*) INTO cuentaDestinoExiste FROM cuentas WHERE cbu = cbuDestino;
	IF cuentaDestinoExiste = 1 THEN
            INSERT INTO movimientos (numero_cuenta, fecha, detalle, importe, tipo_movimiento) VALUES ((SELECT numero_cuenta FROM cuentas WHERE cbu = cbuDestino),fechaActual, detalle,importe,'transferencia');
            INSERT INTO transferencias (dni, cbu_origen, cbu_destino, fecha, detalle, importe, movimiento_id)
			VALUES ((SELECT dni FROM cuentas WHERE cbu = cbuOrigen),cbuOrigen,cbuDestino,fechaActual, detalle, importe,idMovOrigen);
            UPDATE cuentas SET saldo = saldo + importe WHERE cbu = cbuDestino;
	END IF;
    COMMIT;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER altaCuenta AFTER INSERT ON cuentas
FOR EACH ROW
BEGIN
    DECLARE detalle_movimiento VARCHAR(255);  
    SET detalle_movimiento = CONCAT('Alta de cuenta para DNI ', NEW.dni);
    INSERT INTO movimientos (numero_cuenta, fecha, detalle, importe, tipo_movimiento)
    VALUES (NEW.numero_cuenta, CURDATE(), detalle_movimiento, 10000.00, 'alta de cuenta');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_AUTORIZAR_PRESTAMO(
    IN idPrestamo INT,
    IN cuentaDestino INT
)
BEGIN
    DECLARE dni VARCHAR(10);
    DECLARE importeTotal DECIMAL(10, 2);
    DECLARE nroCuotas INT;
    DECLARE cuotaMensual DECIMAL(10, 2);
    DECLARE fechaActual DATE DEFAULT CURDATE();
    DECLARE idMovimiento INT;
    DECLARE i INT DEFAULT 1;
    DECLARE fechaVencimiento DATE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    SELECT c.dni, tp.importe_total, tp.nro_cuotas, tp.cuota_mensual INTO dni, importeTotal, nroCuotas, cuotaMensual FROM prestamos p
    JOIN cuentas c ON p.numero_cuenta = c.numero_cuenta
    JOIN tipos_prestamo tp ON p.tipo_prestamo_id = tp.tipo_prestamo_id
    WHERE p.prestamo_id = idPrestamo;


    UPDATE prestamos SET estado_prestamo = 'Autorizado' WHERE prestamo_id = idPrestamo;
    UPDATE cuentas  SET saldo = saldo + importeTotal   WHERE numero_cuenta = cuentaDestino;

    INSERT INTO movimientos (numero_cuenta, fecha, detalle, importe, tipo_movimiento) 
    VALUES (cuentaDestino, fechaActual, 'Alta de un préstamo', importeTotal, 'alta de préstamo');

    SET idMovimiento = LAST_INSERT_ID();

    WHILE i <= nroCuotas DO
        SET fechaVencimiento = DATE_ADD(fechaActual, INTERVAL i MONTH);
        INSERT INTO cuotas (prestamo_id, numero_cuota, fecha_vencimiento, importe, fecha_pago)
        VALUES (idPrestamo, i, fechaVencimiento, cuotaMensual, NULL);
        SET i = i + 1;
    END WHILE;

    COMMIT;
END //
DELIMITER ;

DELIMITER //
CREATE  PROCEDURE ObtenerPrestamosSinDni(
	IN fechaInicio DATE,
    IN fechaFin DATE,
    IN estadoPrestamo VARCHAR(20),
    IN importeMin DECIMAL(10, 2),
    IN importeMax DECIMAL(10, 2)
)
BEGIN
    SELECT
        p.prestamo_id  ,
        p.numero_cuenta  ,
        p.fecha  ,
        p.plazo_pago   ,
        p.estado_prestamo ,
        tp.importe_total,
        tp.tipo_prestamo_id ,
        c.dni  
    FROM
        prestamos p
    JOIN
        tipos_prestamo tp ON p.tipo_prestamo_id = tp.tipo_prestamo_id
    JOIN
        cuentas c ON p.numero_cuenta = c.numero_cuenta

    WHERE
        (tp.importe_total BETWEEN importeMin AND importeMax
        or tp.importe_total BETWEEN importeMax AND importeMin)
        AND( p.fecha BETWEEN fechaInicio AND fechaFin
        or p.fecha BETWEEN fechaFin AND fechaInicio)

        AND p.estado_prestamo = estadoPrestamo;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerPrestamos(
    IN dniCliente VARCHAR(8),
    IN fechaInicio DATE,
    IN fechaFin DATE,
    IN estadoPrestamo VARCHAR(20),
    IN importeMin DECIMAL(10, 2),
    IN importeMax DECIMAL(10, 2)
)
BEGIN
    SELECT
        p.prestamo_id as prestamo_id ,
        p.numero_cuenta as numero_cuenta,
        p.fecha as fecha,
        p.plazo_pago as plazo_pago,
        p.estado_prestamo as estado_prestamo,
        tp.tipo_prestamo_id as tipo_prestamo_id,
        c.dni as dni
    FROM
        prestamos p
    JOIN
        tipos_prestamo tp ON p.tipo_prestamo_id = tp.tipo_prestamo_id
    JOIN
        cuentas c ON p.numero_cuenta = c.numero_cuenta
    JOIN
        clientes cl ON cl.dni = c.dni
    WHERE
        (tp.importe_total BETWEEN importeMin AND importeMax
        or tp.importe_total BETWEEN importeMax AND importeMin)
        AND( p.fecha BETWEEN fechaInicio AND fechaFin
        or p.fecha BETWEEN fechaFin AND fechaInicio)
        AND cl.dni LIKE CONCAT('%', dniCliente, '%')
        AND p.estado_prestamo = estadoPrestamo;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SP_PAGO_CUOTA(
    IN idCuota INT,
    IN nroCuentaDebito INT
)
BEGIN
   
    DECLARE nroCuotas INT;
    DECLARE cuotaMensual DECIMAL(10, 2);
    DECLARE saldoOrigen DECIMAL(10, 2);
    DECLARE fechaActual DATE DEFAULT CURDATE();
    DECLARE idPrestamo INT;
    DECLARE cuotasTotal INT;
    DECLARE cuotasPagas INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
	START TRANSACTION;
    
    SELECT saldo INTO saldoOrigen FROM cuentas WHERE numero_cuenta = nroCuentaDebito;
    SELECT numero_cuota, importe, prestamo_id INTO nroCuotas, cuotaMensual, idPrestamo FROM cuotas  WHERE  cuota_id = idCuota;

    IF saldoOrigen < cuotaMensual THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente en la cuenta de origen';
    ELSE
		UPDATE cuotas SET fecha_pago = fechaActual WHERE  cuota_id = idCuota;
		UPDATE cuentas  SET saldo = saldo - cuotaMensual   WHERE numero_cuenta = nroCuentaDebito;

		INSERT INTO movimientos (numero_cuenta, fecha, detalle, importe, tipo_movimiento) 
		VALUES (nroCuentaDebito, fechaActual,   CONCAT('Pago de cuota: ', nroCuotas), -cuotaMensual,'pago de préstamo');
        
		SELECT COUNT(*) INTO cuotasPagas  FROM cuotas WHERE prestamo_id = idPrestamo AND fecha_pago IS NOT NULL;
        SELECT plazo_pago  INTO cuotasTotal FROM prestamos  WHERE  prestamo_id = idPrestamo;
        
        IF cuotasPagas = cuotasTotal THEN
          UPDATE prestamos SET estado = 'Cancelado' WHERE prestamo_id = idPrestamo;
        END IF;
	END IF;

    COMMIT;
END //
DELIMITER ;


INSERT INTO paises (nombre) VALUES 
('Argentina'), 
('Brasil'), 
('Chile'), 
('Uruguay'), 
('Paraguay'), 
('Bolivia'), 
('Peru'), 
('Ecuador'), 
('Colombia'), 
('Venezuela'), 
('Mexico'), 
('Costa Rica'), 
('Panama'), 
('Honduras'), 
('El Salvador');

INSERT INTO provincias (nombre, pais_id) VALUES 
('Buenos Aires', 1), ('Cordoba', 1), ('Santa Fe', 1),
('Sao Paulo', 2), ('Rio de Janeiro', 2), ('Minas Gerais', 2),
('Santiago', 3), ('Valparaiso', 3), ('Biobio', 3),
('Montevideo', 4), ('Canelones', 4), ('Maldonado', 4),
('Asuncion', 5), ('Central', 5), ('Alto Parana', 5),
('La Paz', 6), ('Santa Cruz', 6), ('Cochabamba', 6),
('Lima', 7), ('Arequipa', 7), ('La Libertad', 7),
('Quito', 8), ('Guayas', 8), ('Pichincha', 8),
('Bogota', 9), ('Antioquia', 9), ('Valle del Cauca', 9),
('Caracas', 10), ('Miranda', 10), ('Zulia', 10),
('Mexico City', 11), ('Jalisco', 11), ('Nuevo Leon', 11),
('San Jose', 12), ('Alajuela', 12), ('Guanacaste', 12),
('Panama City', 13), ('Colon', 13), ('Chiriqui', 13),
('Tegucigalpa', 14), ('San Pedro Sula', 14), ('La Ceiba', 14),
('San Salvador', 15), ('Santa Ana', 15), ('San Miguel', 15);

INSERT INTO localidades (nombre, provincia_id) VALUES 
('La Plata', 1), ('Mar del Plata', 1), ('Rosario', 1),
('Campinas', 4), ('Santos', 4), ('Manaus', 4),
('Valparaiso', 7), ('Concepcion', 7), ('Antofagasta', 7),
('Ciudad de la Costa', 10), ('Punta del Este', 10), ('Maldonado', 10),
('Fernando de la Mora', 13), ('Luque', 13), ('Encarnacion', 13),
('El Alto', 16), ('Cochabamba', 16), ('Santa Cruz de la Sierra', 16),
('Lima', 19), ('Callao', 19), ('Arequipa', 19),
('Cuenca', 21), ('Guayaquil', 21), ('Santo Domingo', 21),
('Bogota', 24), ('Medellin', 24), ('Cali', 24),
('Caracas', 27), ('Maracaibo', 27), ('Valencia', 27),
('Mexico City', 30), ('Guadalajara', 30), ('Monterrey', 30),
('San Jose', 33), ('Alajuela', 33), ('Cartago', 33),
('Panama City', 36), ('David', 36), ('Colón', 36),
('Tegucigalpa', 39), ('San Pedro Sula', 39), ('La Ceiba', 39),
('San Salvador', 42), ('Santa Tecla', 42), ('Soyapango', 42);

INSERT INTO tipos_usuarios (tipo_usuario) VALUES
('administrador'),
('cliente');

INSERT INTO usuarios (nombre_usuario, password, tipo_usuario_id, estado) VALUES
('admin1', 'admin1', 1, TRUE),
('cliente1', 'cliente1', 2, TRUE),
('cliente2', 'cliente2', 2, TRUE),
('cliente3', 'cliente3', 2, TRUE),
('cliente4', 'cliente4', 2, TRUE),
('cliente5', 'cliente5', 2, TRUE),
('cliente6', 'cliente6', 2, TRUE),
('cliente7', 'cliente7', 2, TRUE),
('cliente8', 'cliente8', 2, TRUE),
('cliente9', 'cliente9', 2, TRUE),
('cliente10', 'cliente10', 2, TRUE),
('cliente11', 'cliente11', 2, TRUE),
('cliente12', 'cliente12', 2, TRUE),
('cliente13', 'cliente13', 2, TRUE),
('cliente14', 'cliente14', 2, TRUE),
('cliente15', 'cliente15', 2, TRUE),
('cliente16', 'cliente16', 2, TRUE);

INSERT INTO clientes (dni, cuil, nombre, apellido, sexo, nacionalidad, fecha_nacimiento, direccion, localidad_id, provincia_id, correo_electronico, telefono, usuario_id, estado) VALUES
('12245678', '20122456781', 'Juan', 'Perez', 'M', 'Argentina', '1985-01-15', 'Av. Maipu 123', 1, 1, 'juan.perez@gmail.com', '1134567890', 1, TRUE),
('23456789', '27234567892', 'Maria', 'Garcia', 'F', 'Argentina', '1990-02-20', 'Av. Siempre Viva 742', 4, 4, 'maria.garcia@hotmail.com', '1187654321', 2, TRUE),
('34567890', '20345678903', 'Carlos', 'Lopez', 'M', 'Argentina', '1975-03-10', 'Calle de la Amargura 456', 7, 7, 'carlos.lopez@gmail.com', '1133445545', 3, TRUE),
('45678901', '27456789014', 'Ana', 'Martinez', 'F', 'Argentina', '1980-04-25', 'Pasaje de los Inocentes 789', 10, 10, 'ana.martinez@hotmail.com', '1166778899', 4, TRUE),
('56789012', '20567890125', 'Luis', 'Rodriguez', 'M', 'Argentina', '1988-05-30', 'Boulevard de los Sueños Rotos 101', 13, 13, 'luis.rodriguez@gmail.com', '1199887766', 5, TRUE),
('67890123', '27678901236', 'Sofia', 'Hernandez', 'F', 'Argentina', '1995-06-15', 'Callejón sin Salida 202', 16, 16, 'sofia.hernandez@hotmail.com', '1155667788', 6, TRUE),
('78901234', '20789012347', 'Miguel', 'Fernandez', 'M', 'Argentina', '1978-07-05', 'Ruta Perdida 303', 19, 19, 'miguel.fernandez@gmail.com', '3344556677', 7, TRUE),
('89012345', '27890123458', 'Lucia', 'Gomez', 'F', 'Argentina', '1983-08-20', 'Camino del Inca 404', 21, 19, 'lucia.gomez@hotmail.com', '1123344556', 8, TRUE),
('90123456', '20901234569', 'David', 'Ruiz', 'M', 'Argentina', '1992-09-10', 'Avenida Libertador 505', 24, 21, 'david.ruiz@gmail.com', '1155667788', 9, TRUE),
('01234567', '27012345671', 'Elena', 'Diaz', 'F', 'Argentina', '1987-10-25', 'Camino Real 606', 27, 24, 'elena.diaz@hotmail.com', '1156677889', 10, TRUE),
('12345679', '20123456792', 'Jose', 'Torres', 'M', 'Argentina', '1980-11-15', 'Calle Ancha 707', 30, 27, 'jose.torres@gmail.com', '1177889900', 11, TRUE),
('23456780', '27234567803', 'Carmen', 'Sanchez', 'F', 'Argentina', '1991-12-05', 'Pasaje Estrecho 808', 33, 30, 'carmen.sanchez@hotmail.com', '1189900110', 12, TRUE),
('34567891', '20345678914', 'Ricardo', 'Ramirez', 'M', 'Argentina', '1984-01-20', 'Calle Cerrada 909', 36, 33, 'ricardo.ramirez@gmail.com', '1189900112', 13, TRUE),
('45678902', '27456789025', 'Veronica', 'Cruz', 'F', 'Argentina', '1989-02-10', 'Avenida Principal 1010', 39, 36, 'veronica.cruz@hotmail.com', '1190011223', 14, TRUE),
('56789013', '20567890136', 'Diego', 'Flores', 'M', 'Argentina', '1982-03-05', 'Camino Viejo 1111', 42, 39, 'diego.flores@gmail.com', '1122334445', 15, TRUE),
('67890124', '27678901247', 'Patricia', 'Jimenez', 'F', 'Argentina', '1993-04-25', 'Boulevard Central 1212', 2, 1, 'patricia.jimenez@hotmail.com', '1122334455', 16, TRUE);

INSERT INTO tiposcuentas (tipo_cuenta) VALUES 
('caja de ahorro'), 
('cuenta corriente');

INSERT INTO cuentas (cbu, dni, fecha_creacion, id_tipoCuenta) VALUES
('0000310000000012340001', '12245678', '2023-01-01', 1),
('0000310000000012340002', '23456789', '2023-02-02', 2),
('0000310000000012340003', '34567890', '2023-03-03', 1),
('0000310000000012340004', '45678901', '2023-04-04', 2),
('0000310000000012340005', '56789012', '2023-05-05', 1),
('0000310000000012340006', '67890123', '2023-06-06', 2),
('0000310000000012340007', '78901234', '2023-07-07', 1),
('0000310000000056780001', '89012345', '2023-08-08', 2),
('0000310000000056780002', '90123456', '2023-09-09', 1),
('0000310000000056780003', '01234567', '2023-10-10', 2),
('0000310000000056780004', '12345679', '2023-11-11', 1),
('0000310000000056780005', '34567891', '2023-12-12', 2),
('0000310000000056780006', '45678902', '2024-01-21', 1),
('0000310000000056780007', '56789013', '2024-02-22', 2),
('0000310000000012345678', '67890124', '2024-03-31', 1);

INSERT INTO tipos_prestamo (importe_total, importe_intereses, nro_cuotas, cuota_mensual, interes_anual) VALUES 
-- 12 cuotas, 16% anual
(500000, 580000.00, 12, 48333.33, 16),
(1000000, 1160000.00, 12, 96666.67, 16),
(1500000, 1740000.00, 12, 145000.00, 16),
(2000000, 2320000.00, 12, 193333.33, 16),
(2500000, 2900000.00, 12, 241666.67, 16),
-- --------------------------------------
-- 24 cuotas, 32% anual
(500000, 660000.00, 24, 27500.00, 32),
(1000000, 1320000.00, 24, 55000.00, 32),
(1500000, 1980000.00, 24, 82500.00, 32),
(2000000, 2640000.00, 24, 110000.00, 32),
(2500000, 3300000.00, 24, 137500.00, 32),
-- --------------------------------------
-- 36 cuotas, 64% anual
(500000, 820000.00, 36, 22777.78, 64),
(1000000, 1640000.00, 36, 45555.56, 64),
(1500000, 2460000.00, 36, 68333.33, 64),
(2000000, 3280000.00, 36, 91111.11, 64),
(2500000, 4100000.00, 36, 113888.89, 64);


INSERT INTO prestamos (numero_cuenta, fecha, plazo_pago, tipo_prestamo_id, estado_prestamo, estado) VALUES
(1, '2024-01-15', 12, 1, 'En proceso', 'Vigente'),
(2, '2024-02-20', 24, 2, 'Rechazado', 'Vigente'),
(3, '2024-03-10', 36, 3, 'En proceso', 'Vigente'),
(4, '2024-04-05', 48, 1, 'Rechazado', 'Vigente'),
(5, '2024-05-18', 60, 2, 'En proceso', 'Vigente'),
(6, '2024-06-22', 12, 3, 'Rechazado', 'Vigente'),
(7, '2024-07-01', 24, 1, 'En proceso', 'Vigente'),
(8, '2024-07-15', 36, 2, 'Rechazado', 'Vigente'),
(9, '2024-08-10', 48, 3, 'En proceso', 'Vigente'),
(10, '2024-09-05', 60, 1, 'Rechazado', 'Vigente'),
(11, '2024-10-20', 12, 2, 'En proceso', 'Vigente'),
(12, '2024-11-25', 24, 3, 'Rechazado', 'Vigente'),
(13, '2024-12-30', 36, 1, 'En proceso', 'Vigente'),
(14, '2024-01-10', 48, 2, 'Rechazado', 'Vigente'),
(15, '2024-02-14', 60, 3, 'En proceso', 'Vigente');


CALL SP_AUTORIZAR_PRESTAMO(1,1);
CALL SP_AUTORIZAR_PRESTAMO(3,3);
CALL SP_AUTORIZAR_PRESTAMO(15,15);





