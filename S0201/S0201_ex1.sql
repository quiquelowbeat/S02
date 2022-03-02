-- Model: Óptica    Version: 1.0
-- Autor: Quique Sánchez Suárez

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `optica` ;

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`direccion` (
  `id_direccion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `piso` INT NULL DEFAULT NULL,
  `puerta` INT NOT NULL,
  `ciudad` VARCHAR(25) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id_proveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `fax` INT NULL DEFAULT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `id_direccion` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `nombre` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `nif` (`nif` ASC) VISIBLE,
  INDEX `fk_proveedores_direccion1_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `optica`.`direccion` (`id_direccion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marcas_gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marcas_gafas` (
  `id_marca` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_marcas_gafas_proveedores1_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_marcas_gafas_proveedores1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `optica`.`proveedores` (`id_proveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(11) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_direccion` INT UNSIGNED NOT NULL,
  `id_cliente_recomienda` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_clientes_direccion1_idx` (`id_direccion` ASC) VISIBLE,
  INDEX `fk_clientes_clientes1_idx` (`id_cliente_recomienda` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `optica`.`direccion` (`id_direccion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`id_cliente_recomienda`)
    REFERENCES `optica`.`clientes` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`modelos_gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`modelos_gafas` (
  `id_modelo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_marca_gafas` INT UNSIGNED NOT NULL,
  `graduacion_izq` FLOAT NOT NULL COMMENT 'Graduación cristal izquierdo.',
  `graduacion_der` FLOAT NOT NULL COMMENT 'Graduación cristal derecho.',
  `montura` ENUM('F', 'P', 'M') NOT NULL COMMENT 'F - Flotante\nP - Pasta\nM - Metálica',
  `color_montura` VARCHAR(25) NOT NULL,
  `color_vidrio_izq` VARCHAR(25) NOT NULL,
  `color_vidrio_der` VARCHAR(25) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id_modelo`, `id_marca_gafas`),
  INDEX `fk_modelos_gafas_marcas_gafas1_idx` (`id_marca_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_modelos_gafas_marcas_gafas1`
    FOREIGN KEY (`id_marca_gafas`)
    REFERENCES `optica`.`marcas_gafas` (`id_marca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `empleado_nombre` VARCHAR(45) NULL DEFAULT NULL,
  `empleado_apellido1` VARCHAR(45) NULL DEFAULT NULL,
  `empleado_apellido2` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`pedidos` (
  `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_empleado` INT UNSIGNED NOT NULL,
  INDEX `fk_pedidos_empleado1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_pedidos_clientes1_idx` (`id_cliente` ASC) VISIBLE,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `fk_pedidos_empleado1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleado` (`id_empleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`clientes` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`modelos_gafas_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`modelos_gafas_pedidos` (
  `id_modelo_gafas` INT UNSIGNED NOT NULL,
  `id_pedido` INT UNSIGNED NOT NULL,
  INDEX `fk_modelos_gafas_has_pedidos_pedidos1_idx` (`id_pedido` ASC) VISIBLE,
  INDEX `fk_modelos_gafas_has_pedidos_modelos_gafas1_idx` (`id_modelo_gafas` ASC) VISIBLE,
  PRIMARY KEY (`id_pedido`, `id_modelo_gafas`),
  CONSTRAINT `fk_modelos_gafas_has_pedidos_modelos_gafas1`
    FOREIGN KEY (`id_modelo_gafas`)
    REFERENCES `optica`.`modelos_gafas` (`id_modelo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_modelos_gafas_has_pedidos_pedidos1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `optica`.`pedidos` (`id_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
