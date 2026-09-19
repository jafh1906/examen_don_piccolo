-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema don_piccolo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema don_piccolo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `don_piccolo` DEFAULT CHARACTER SET utf8 ;
USE `don_piccolo` ;

-- -----------------------------------------------------
-- Table `don_piccolo`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`personas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`cliente` (
  `persona_fk` INT NOT NULL,
  `correo` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  PRIMARY KEY (`persona_fk`),
  CONSTRAINT `fk_cliente_1`
    FOREIGN KEY (`persona_fk`)
    REFERENCES `don_piccolo`.`personas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`domiciliario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`domiciliario` (
  `persona_fk` INT NOT NULL,
  `zona` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`persona_fk`),
  CONSTRAINT `fk_domiciliario_1`
    FOREIGN KEY (`persona_fk`)
    REFERENCES `don_piccolo`.`personas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_fk` INT NOT NULL,
  `fecha_hora` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_1_idx` (`cliente_fk` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_1`
    FOREIGN KEY (`cliente_fk`)
    REFERENCES `don_piccolo`.`cliente` (`persona_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`domicilios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`domicilios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_fk` INT NOT NULL,
  `domiciliari_fk` INT NOT NULL,
  `hora_salida` VARCHAR(45) NOT NULL,
  `hora_entrega` VARCHAR(45) NOT NULL,
  `distancia` VARCHAR(45) NOT NULL,
  `costo_envio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_domicilios_1_idx` (`pedido_fk` ASC) VISIBLE,
  INDEX `fk_domicilios_1_idx1` (`domiciliari_fk` ASC) VISIBLE,
  CONSTRAINT `fk_domicilios_1`
    FOREIGN KEY (`pedido_fk`)
    REFERENCES `don_piccolo`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domicilios_2`
    FOREIGN KEY (`domiciliari_fk`)
    REFERENCES `don_piccolo`.`domiciliario` (`persona_fk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`pizzas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tamaño` VARCHAR(45) NOT NULL,
  `precio_base` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `disponibilidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`detalle_pedido` (
  `id` INT ZEROFILL NOT NULL,
  `pedido_fk` INT NOT NULL,
  `pizza_fk` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  `precio_unitario` VARCHAR(45) NOT NULL,
  `subtotal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalle_pedido_1_idx` (`pedido_fk` ASC) VISIBLE,
  INDEX `fk_detalle_pedido_2_idx` (`pizza_fk` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido_1`
    FOREIGN KEY (`pedido_fk`)
    REFERENCES `don_piccolo`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_pedido_2`
    FOREIGN KEY (`pizza_fk`)
    REFERENCES `don_piccolo`.`pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`pagos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_fk` INT NOT NULL,
  `metodo` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `fecha_pago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagos_1_idx` (`pedido_fk` ASC) VISIBLE,
  CONSTRAINT `fk_pagos_1`
    FOREIGN KEY (`pedido_fk`)
    REFERENCES `don_piccolo`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`ingredientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `stock` VARCHAR(45) NOT NULL,
  `costo_unitario` VARCHAR(45) NOT NULL,
  `disponibilidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`pizza_ingresientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`pizza_ingresientes` (
  `pizza_fk` INT NOT NULL,
  `ingrediente_fk` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pizza_fk`, `ingrediente_fk`),
  INDEX `fk_pizza_ingredientes_2_idx` (`ingrediente_fk` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_ingredientes_1`
    FOREIGN KEY (`pizza_fk`)
    REFERENCES `don_piccolo`.`pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_ingredientes_2`
    FOREIGN KEY (`ingrediente_fk`)
    REFERENCES `don_piccolo`.`ingredientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `don_piccolo`.`historial_precios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `don_piccolo`.`historial_precios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza_fk` INT NOT NULL,
  `precio_anterior` VARCHAR(45) NOT NULL,
  `precio_nuevo` VARCHAR(45) NOT NULL,
  `fecha_cambio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_historial_precios_1_idx` (`pizza_fk` ASC) VISIBLE,
  CONSTRAINT `fk_historial_precios_1`
    FOREIGN KEY (`pizza_fk`)
    REFERENCES `don_piccolo`.`pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- =====================================================
-- 1. INSERTAR PERSONAS
-- =====================================================

INSERT INTO personas (nombre, apellido, telefono) VALUES
('Juan', 'Franco', '3001234567'),
('Carlos', 'Rodriguez', '3012345678'),
('Laura', 'Gomez', '3023456789'),
('Maria', 'Hernandez', '3034567890'),
('Andres', 'Martinez', '3045678901'),
('Sofia', 'Ramirez', '3056789012'),
('Pedro', 'Lopez', '3067890123'),
('Valentina', 'Torres', '3078901234'),
('Daniel', 'Castro', '3089012345'),
('Camila', 'Moreno', '3090123456');

-- =====================================================
-- 2. INSERTAR CLIENTES
-- persona_fk corresponde al id de personas
-- =====================================================

INSERT INTO cliente (persona_fk, correo, direccion) VALUES
(1, 'juan@gmail.com', 'Calle 45 #12-30'),
(2, 'carlos@gmail.com', 'Carrera 20 #35-15'),
(3, 'laura@gmail.com', 'Calle 52 #18-40'),
(4, 'maria@gmail.com', 'Carrera 25 #42-10'),
(5, 'andres@gmail.com', 'Calle 60 #20-25'),
(6, 'sofia@gmail.com', 'Carrera 30 #50-18');

-- =====================================================
-- 3. INSERTAR DOMICILIARIOS
-- persona_fk corresponde al id de personas
-- =====================================================

INSERT INTO domiciliario (persona_fk, zona, estado) VALUES
(7, 'Norte', 'Disponible'),
(8, 'Sur', 'Disponible'),
(9, 'Centro', 'Ocupado'),
(10, 'Occidente', 'Disponible');

-- =====================================================
-- 4. INSERTAR PIZZAS
-- =====================================================

INSERT INTO pizzas
(nombre, tamaño, precio_base, tipo, disponibilidad)
VALUES
('Pizza Margarita', 'Pequeña', '18000', 'Vegetariana', 'Disponible'),
('Pizza Margarita', 'Mediana', '28000', 'Vegetariana', 'Disponible'),
('Pizza Margarita', 'Grande', '38000', 'Vegetariana', 'Disponible'),

('Pizza Pepperoni', 'Pequeña', '22000', 'Carnes', 'Disponible'),
('Pizza Pepperoni', 'Mediana', '32000', 'Carnes', 'Disponible'),
('Pizza Pepperoni', 'Grande', '42000', 'Carnes', 'Disponible'),

('Pizza Hawaiana', 'Pequeña', '21000', 'Carnes', 'Disponible'),
('Pizza Hawaiana', 'Mediana', '31000', 'Carnes', 'Disponible'),
('Pizza Hawaiana', 'Grande', '41000', 'Carnes', 'Disponible'),

('Pizza Don Piccolo', 'Mediana', '35000', 'Especial', 'Disponible'),
('Pizza Don Piccolo', 'Grande', '45000', 'Especial', 'Disponible');

-- =====================================================
-- 5. INSERTAR INGREDIENTES
-- =====================================================

INSERT INTO ingredientes
(nombre, stock, costo_unitario, disponibilidad)
VALUES
('Queso mozzarella', '100', '8000', 'Disponible'),
('Salsa de tomate', '80', '3000', 'Disponible'),
('Pepperoni', '60', '7000', 'Disponible'),
('Piña', '50', '4000', 'Disponible'),
('Jamón', '70', '6000', 'Disponible'),
('Champiñones', '40', '5000', 'Disponible'),
('Tomate', '50', '3000', 'Disponible'),
('Cebolla', '50', '2500', 'Disponible'),
('Pimentón', '45', '3500', 'Disponible'),
('Carne molida', '60', '8000', 'Disponible'),
('Aceitunas', '35', '4500', 'Disponible');

-- =====================================================
-- 6. RELACIONAR PIZZAS CON INGREDIENTES
-- pizza_fk = id de pizza
-- ingrediente_fk = id de ingrediente
-- =====================================================

-- Pizza Margarita Pequeña (id 1)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(1, 1, '1'),
(1, 2, '1'),
(1, 7, '1');

-- Pizza Margarita Mediana (id 2)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(2, 1, '2'),
(2, 2, '1'),
(2, 7, '1');

-- Pizza Margarita Grande (id 3)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(3, 1, '3'),
(3, 2, '2'),
(3, 7, '2');

-- Pizza Pepperoni Pequeña (id 4)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(4, 1, '1'),
(4, 2, '1'),
(4, 3, '1');

-- Pizza Pepperoni Mediana (id 5)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(5, 1, '2'),
(5, 2, '1'),
(5, 3, '2');

-- Pizza Pepperoni Grande (id 6)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(6, 1, '3'),
(6, 2, '2'),
(6, 3, '3');

-- Pizza Hawaiana Pequeña (id 7)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(7, 1, '1'),
(7, 2, '1'),
(7, 4, '1'),
(7, 5, '1');

-- Pizza Hawaiana Mediana (id 8)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(8, 1, '2'),
(8, 2, '1'),
(8, 4, '2'),
(8, 5, '2');

-- Pizza Hawaiana Grande (id 9)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(9, 1, '3'),
(9, 2, '2'),
(9, 4, '3'),
(9, 5, '3');

-- Pizza Don Piccolo Mediana (id 10)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(10, 1, '2'),
(10, 2, '1'),
(10, 3, '1'),
(10, 5, '1'),
(10, 6, '1'),
(10, 8, '1'),
(10, 9, '1');

-- Pizza Don Piccolo Grande (id 11)
INSERT INTO pizza_ingresientes (pizza_fk, ingrediente_fk, cantidad) VALUES
(11, 1, '3'),
(11, 2, '2'),
(11, 3, '2'),
(11, 5, '2'),
(11, 6, '2'),
(11, 8, '1'),
(11, 9, '1');

-- =====================================================
-- 7. INSERTAR PEDIDOS
-- cliente_fk corresponde a persona_fk de cliente
-- =====================================================

INSERT INTO pedidos
(cliente_fk, fecha_hora, estado)
VALUES
(1, '2026-09-10 12:30:00', 'Entregado'),
(2, '2026-09-10 13:15:00', 'Entregado'),
(3, '2026-09-11 18:20:00', 'En preparación'),
(4, '2026-09-11 19:00:00', 'En camino'),
(5, '2026-09-12 12:45:00', 'Pendiente'),
(6, '2026-09-12 20:10:00', 'Pendiente'),
(1, '2026-09-13 12:20:00', 'En preparación'),
(3, '2026-09-13 13:05:00', 'En camino');

-- =====================================================
-- 8. INSERTAR DETALLE DE PEDIDOS
-- =====================================================

-- Pedido 1
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 2, '2', '28000', '56000'),
(2, 1, 7, '1', '21000', '21000');

-- Pedido 2
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(3, 2, 5, '1', '32000', '32000'),
(4, 2, 8, '2', '31000', '62000');

-- Pedido 3
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(5, 3, 10, '1', '35000', '35000'),
(6, 3, 4, '1', '22000', '22000');

-- Pedido 4
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(7, 4, 6, '1', '42000', '42000'),
(8, 4, 2, '1', '28000', '28000');

-- Pedido 5
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(9, 5, 11, '1', '45000', '45000'),
(10, 5, 1, '1', '18000', '18000');

-- Pedido 6
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(11, 6, 9, '2', '41000', '82000');

-- Pedido 7
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(12, 7, 5, '2', '32000', '64000'),
(13, 7, 3, '1', '38000', '38000');

-- Pedido 8
INSERT INTO detalle_pedido
(id, pedido_fk, pizza_fk, cantidad, precio_unitario, subtotal)
VALUES
(14, 8, 10, '1', '35000', '35000'),
(15, 8, 8, '1', '31000', '31000');

-- =====================================================
-- 9. INSERTAR DOMICILIOS
-- pedido_fk = pedido
-- domiciliari_fk = persona_fk del domiciliario
-- =====================================================

INSERT INTO domicilios
(pedido_fk, domiciliari_fk, hora_salida, hora_entrega, distancia, costo_envio)
VALUES
(1, 7, '2026-09-10 12:50:00', '2026-09-10 13:20:00', '3.5 km', '6000'),

(2, 8, '2026-09-10 13:35:00', '2026-09-10 14:05:00', '4.2 km', '7000'),

(3, 9, '2026-09-11 18:50:00', '2026-09-11 19:25:00', '5.1 km', '8000'),

(4, 10, '2026-09-11 19:30:00', '2026-09-11 20:05:00', '4.8 km', '7500'),

(5, 7, '2026-09-12 13:10:00', '2026-09-12 13:45:00', '3.0 km', '5500'),

(6, 8, '2026-09-12 20:35:00', '2026-09-12 21:10:00', '6.2 km', '9000'),

(7, 9, '2026-09-13 12:45:00', '2026-09-13 13:20:00', '4.0 km', '6500'),

(8, 10, '2026-09-13 13:30:00', '2026-09-13 14:05:00', '5.5 km', '8500');

-- =====================================================
-- 10. INSERTAR PAGOS
-- =====================================================

INSERT INTO pagos
(pedido_fk, metodo, estado, fecha_pago)
VALUES
(1, 'Efectivo', 'Pagado', '2026-09-10 13:20:00'),
(2, 'Tarjeta', 'Pagado', '2026-09-10 14:05:00'),
(3, 'Nequi', 'Pagado', '2026-09-11 18:25:00'),
(4, 'Daviplata', 'Pagado', '2026-09-11 19:05:00'),
(5, 'Efectivo', 'Pendiente', '2026-09-12 12:45:00'),
(6, 'Nequi', 'Pendiente', '2026-09-12 20:10:00'),
(7, 'Tarjeta', 'Pagado', '2026-09-13 12:25:00'),
(8, 'Efectivo', 'Pagado', '2026-09-13 13:10:00');

-- =====================================================
-- 11. HISTORIAL DE PRECIOS
-- =====================================================

INSERT INTO historial_precios
(pizza_fk, precio_anterior, precio_nuevo, fecha_cambio)
VALUES
(1, '16000', '18000', '2026-08-01 09:00:00'),
(2, '25000', '28000', '2026-08-01 09:05:00'),
(3, '35000', '38000', '2026-08-01 09:10:00'),
(4, '20000', '22000', '2026-08-05 10:00:00'),
(5, '29000', '32000', '2026-08-05 10:05:00'),
(6, '39000', '42000', '2026-08-05 10:10:00'),
(7, '19000', '21000', '2026-08-10 11:00:00'),
(8, '28000', '31000', '2026-08-10 11:05:00'),
(9, '38000', '41000', '2026-08-10 11:10:00'),
(10, '32000', '35000', '2026-08-15 14:00:00'),
(11, '42000', '45000', '2026-08-15 14:05:00');

/*Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).*/

DELIMITER //

CREATE FUNCTION calcular_total_pedido(id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE subtotal_pizzas DECIMAL(10,2);
    DECLARE costo_envio_pedido DECIMAL(10,2);
    DECLARE subtotal DECIMAL(10,2);
    DECLARE iva DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    SELECT SUM(CAST(subtotal AS DECIMAL(10,2)))
    INTO subtotal_pizzas
    FROM detalle_pedido
    WHERE pedido_fk = id_pedido;

    SELECT COALESCE(CAST(costo_envio AS DECIMAL(10,2)),0)
    INTO costo_envio_pedido
    FROM domicilios
    WHERE pedido_fk = id_pedido
    LIMIT 1;

    SET subtotal_pizzas = COALESCE(subtotal_pizzas, 0);
    SET subtotal = subtotal_pizzas + costo_envio_pedido;
    SET iva = subtotal * 0.19;
    SET total = subtotal + iva;
    RETURN total;
END //

DELIMITER ;

SELECT calcular_total_pedido(4) AS total;
SELECT id, cliente_fk, calcular_total_pedido(id) AS total FROM pedidos;


/*Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).*/

DELIMITER //

CREATE FUNCTION calcular_ganancia_neta_diaria(fecha_consulta DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE ventas_dia DECIMAL(10,2);
    DECLARE costos_ingredientes DECIMAL(10,2);
    DECLARE ganancia_neta DECIMAL(10,2);

    SELECT COALESCE(SUM(calcular_total_pedido(p.id)),0)
    INTO ventas_dia
    FROM pedidos p
    WHERE DATE(CAST(p.fecha_hora AS DATETIME)) = fecha_consulta;

    SELECT COALESCE(SUM(CAST(dp.cantidad AS DECIMAL(10,2)) * CAST(pi.cantidad AS DECIMAL(10,2)) * CAST(i.costo_unitario AS DECIMAL(10,2))),0)
    INTO costos_ingredientes
    FROM pedidos p
    INNER JOIN detalle_pedido dp
        ON p.id = dp.pedido_fk
    INNER JOIN pizza_ingresientes pi
        ON dp.pizza_fk = pi.pizza_fk
    INNER JOIN ingredientes i
        ON pi.ingrediente_fk = i.id
    WHERE DATE(CAST(p.fecha_hora AS DATETIME)) = fecha_consulta;

    SET ganancia_neta = ventas_dia - costos_ingredientes;

    RETURN ganancia_neta;
END //

DELIMITER ;

SELECT calcular_ganancia_neta_diaria('2026-09-13') AS ganancia_neta;

/*Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.*/

DELIMITER //

CREATE PROCEDURE actualizar_estado_entregado(IN id_pedido INT)
BEGIN

    UPDATE pedidos p
    INNER JOIN domicilios d
        ON p.id = d.pedido_fk
    SET p.estado = 'entregado'
    WHERE p.id = id_pedido
      AND d.hora_entrega IS NOT NULL;

END //

DELIMITER ;

CALL actualizar_estado_entregado(8);

/*Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.*/

DELIMITER //

CREATE TRIGGER actualizar_stock_ingredientes
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN

    UPDATE ingredientes i
    INNER JOIN pizza_ingresientes pi
        ON i.id = pi.ingrediente_fk
    SET i.stock = CAST(i.stock AS DECIMAL(10,2))
                 - (NEW.cantidad * pi.cantidad)
    WHERE pi.pizza_fk = NEW.pizza_fk;

END //

DELIMITER ;

/*Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.*/

DELIMITER //

CREATE TRIGGER auditoria_precio_pizza
AFTER UPDATE ON pizzas
FOR EACH ROW
BEGIN

    IF OLD.precio_base <> NEW.precio_base THEN

        INSERT INTO historial_precios
        (
            pizza_fk,
            precio_anterior,
            precio_nuevo,
            fecha_cambio
        )
        VALUES
        (
            NEW.id,
            OLD.precio_base,
            NEW.precio_base,
            NOW()
        );

    END IF;

END //

DELIMITER ;

SELECT * FROM historial_precios;

UPDATE pizzas
SET precio_base = '30000'
WHERE id = 2;

/*Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.*/

DELIMITER //

CREATE TRIGGER liberar_repartidor
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN

    IF OLD.estado <> 'entregado' AND NEW.estado = 'entregado' THEN

        UPDATE domiciliario d
        INNER JOIN domicilios dom
            ON d.persona_fk = dom.domiciliari_fk
        SET d.estado = 'disponible'
        WHERE dom.pedido_fk = NEW.id;

    END IF;

END //

DELIMITER ;

/*Clientes con pedidos entre dos fechas (BETWEEN).*/

SELECT p.id AS pedido,
    CONCAT(pe.nombre, ' ', pe.apellido) AS cliente,
    p.fecha_hora,
    p.estado
FROM pedidos p
INNER JOIN cliente c
    ON p.cliente_fk = c.persona_fk
INNER JOIN personas pe
    ON c.persona_fk = pe.id
WHERE DATE(CAST(p.fecha_hora AS DATETIME))
      BETWEEN '2026-09-13' AND '2026-09-15';

/*Pizzas más vendidas (GROUP BY y COUNT).*/

SELECT p.id,
    p.nombre,
    COUNT(dp.pizza_fk) AS veces_vendida
FROM pizzas p
INNER JOIN detalle_pedido dp
    ON p.id = dp.pizza_fk
GROUP BY p.id, p.nombre
ORDER BY veces_vendida DESC;

/*Pedidos por repartidor (JOIN).*/

SELECT p.id AS pedido,
    CONCAT(pe.nombre, ' ', pe.apellido) AS repartidor,
    p.estado
FROM pedidos p
INNER JOIN domicilios d
    ON p.id = d.pedido_fk
INNER JOIN domiciliario dom
    ON d.domiciliari_fk = dom.persona_fk
INNER JOIN personas pe
    ON dom.persona_fk = pe.id;

/*Promedio de entrega por zona (AVG y JOIN).*/

SELECT dmi.zona,
    AVG(
        TIME_TO_SEC(
            TIMEDIFF(
                CAST(d.hora_entrega AS TIME),
                CAST(d.hora_salida AS TIME)
            )
        )
    ) / 60 AS promedio_minutos
FROM domicilios d
INNER JOIN domiciliario dmi
    ON d.domiciliari_fk = dmi.persona_fk
WHERE d.hora_salida <> ''
  AND d.hora_entrega <> ''
GROUP BY dmi.zona;

/*Clientes que gastaron más de un monto (HAVING).*/

SELECT pe.id,
    CONCAT(pe.nombre, ' ', pe.apellido) AS cliente,
    SUM(CAST(dp.subtotal AS DECIMAL(10,2))) AS total_gastado
FROM personas pe
INNER JOIN cliente c
    ON pe.id = c.persona_fk
INNER JOIN pedidos p
    ON c.persona_fk = p.cliente_fk
INNER JOIN detalle_pedido dp
    ON p.id = dp.pedido_fk
GROUP BY pe.id, pe.nombre, pe.apellido
HAVING SUM(CAST(dp.subtotal AS DECIMAL(10,2))) > 100000
ORDER BY total_gastado DESC;

/*Búsqueda por coincidencia parcial de nombre de pizza (LIKE).*/

SELECT id, nombre, tamaño, precio_base, tipo, disponibilidad FROM pizzas
WHERE nombre LIKE '%marg%';

/*Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).*/

SELECT pe.id,
    CONCAT(pe.nombre, ' ', pe.apellido) AS cliente
FROM personas pe
INNER JOIN cliente c
    ON pe.id = c.persona_fk
WHERE pe.id IN (

    SELECT p.cliente_fk
    FROM pedidos p
    WHERE DATE_FORMAT(CAST(p.fecha_hora AS DATETIME), '%Y-%m')
          = '2026-09'
    GROUP BY p.cliente_fk
    HAVING COUNT(p.id) > 1

);

/*Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).*/

CREATE VIEW resumen_pedidos_cliente AS
SELECT pe.id AS cliente_id,
    CONCAT(pe.nombre, ' ', pe.apellido) AS cliente,
    COUNT(DISTINCT p.id) AS cantidad_pedidos,
    SUM(CAST(dp.subtotal AS DECIMAL(10,2))) AS total_gastado
FROM personas pe
INNER JOIN cliente c
    ON pe.id = c.persona_fk
INNER JOIN pedidos p
    ON c.persona_fk = p.cliente_fk
INNER JOIN detalle_pedido dp
    ON p.id = dp.pedido_fk
GROUP BY pe.id, pe.nombre, pe.apellido;

SELECT * FROM resumen_pedidos_cliente;

/*Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).*/

CREATE VIEW desempeno_repartidores AS
SELECT pe.id AS repartidor_id,
    CONCAT(pe.nombre, ' ', pe.apellido) AS repartidor,
    dmi.zona,
    COUNT(d.id) AS numero_entregas,
    AVG(
        TIME_TO_SEC(
            TIMEDIFF(
                CAST(d.hora_entrega AS TIME),
                CAST(d.hora_salida AS TIME)
            )
        )
    ) / 60 AS tiempo_promedio_minutos
FROM personas pe
INNER JOIN domiciliario dmi
    ON pe.id = dmi.persona_fk
INNER JOIN domicilios d
    ON dmi.persona_fk = d.domiciliari_fk
WHERE d.hora_salida <> ''
  AND d.hora_entrega <> ''
GROUP BY pe.id, pe.nombre, pe.apellido, dmi.zona;

SELECT * FROM desempeno_repartidores;

/*Vista de stock de ingredientes por debajo del mínimo permitido.*/

CREATE VIEW stock_ingredientes_bajo AS
SELECT id, nombre, stock, stock_minimo, disponibilidad FROM ingredientes
WHERE CAST(stock AS DECIMAL(10,2)) < stock_minimo;

select * from stock_ingredientes_bajo