-- Model: Pizzería    Version: 1.0
-- Autor: Quique Sánchez Suárez

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincias` (
  `id_provincias` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidades` (
  `id_localidades` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_localidades`, `id_provincia`),
  CONSTRAINT `fk_localidades_provincias`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria`.`provincias` (`id_provincias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id_clientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `puerta` INT NOT NULL,
  `piso` INT NOT NULL,
  `codigo_postal` INT NOT NULL,
  `telefono` INT NULL,
  `id_localidad` INT NOT NULL,
  `id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_clientes`),
  CONSTRAINT `id_localidad_provincia`
    FOREIGN KEY (`id_localidad` , `id_provincia`)
    REFERENCES `pizzeria`.`localidades` (`id_localidades` , `id_provincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `número` INT NOT NULL,
  `codigo_postal` INT NOT NULL,
  `id_localidad` INT NOT NULL,
  `id_provincia` INT NOT NULL,
  PRIMARY KEY (`id_tienda`),
  CONSTRAINT `fk_tiendas_localidades1`
    FOREIGN KEY (`id_localidad` , `id_provincia`)
    REFERENCES `pizzeria`.`localidades` (`id_localidades` , `id_provincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_tienda` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_pedido` ENUM('domicilio', 'recogida') NOT NULL,
  `cantidad_pizzas` INT NULL DEFAULT NULL,
  `cantidad_hamburguesas` INT NULL DEFAULT NULL,
  `cantidad_bebidas` INT NULL DEFAULT NULL,
  `precio_total` FLOAT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `pizzeria`.`clientes` (`id_clientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_tiendas1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `id_bebida` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id_bebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categorias_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias_pizzas` (
  `id_categorias` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `id_categoria_pizza` INT NOT NULL,
  PRIMARY KEY (`id_pizza`),
  CONSTRAINT `fk_pizzas_categorias_pizzas1`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `pizzeria`.`categorias_pizzas` (`id_categorias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `id_hamburguesa` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id_hamburguesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `id_tienda` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `tipo_trabajo` ENUM('repartidor', 'cocina') NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`repartos_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`repartos_domicilio` (
  `fecha_hora_entrega` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_domicilio` (
  `id_pedido` INT NOT NULL,
  `fecha_hora_entrega` DATETIME NOT NULL,
  `id_empleado` INT NOT NULL,
  INDEX `id_empleado` (`id_empleado` ASC) VISIBLE,
  PRIMARY KEY (`id_pedido`, `id_empleado`),
  CONSTRAINT `fk_pedidos_domicilio_empleados1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `pizzeria`.`empleados` (`id_empleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_domicilio_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pizzeria`.`pedidos` (`id_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos_has_bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos_has_bebidas` (
  `id_pedido` INT NOT NULL,
  `id_bebida` INT NOT NULL,
  `id_hamburguesa` INT NOT NULL,
  `id_pizza` INT NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_bebida`, `id_hamburguesa`, `id_pizza`),
  CONSTRAINT `fk_pedidos_has_bebidas_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pizzeria`.`pedidos` (`id_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_has_bebidas_bebidas1`
    FOREIGN KEY (`id_bebida`)
    REFERENCES `pizzeria`.`bebidas` (`id_bebida`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_has_bebidas_hamburguesas1`
    FOREIGN KEY (`id_hamburguesa`)
    REFERENCES `pizzeria`.`hamburguesas` (`id_hamburguesa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_has_bebidas_pizzas1`
    FOREIGN KEY (`id_pizza`)
    REFERENCES `pizzeria`.`pizzas` (`id_pizza`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
