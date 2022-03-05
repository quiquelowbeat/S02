-- Model: Spotify    Version: 1.0
-- Autor: Quique Sánchez Suárez

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `spotify` ;

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` VARCHAR(45) NOT NULL,
  `sexo` ENUM('H', 'M', 'N') NOT NULL COMMENT 'H - hombre\nM - mujer\nN - prefiere no responder',
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `tipo_usuario` ENUM('free', 'premium') NOT NULL COMMENT '1- Premium\n0- Free',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`suscripciones` (
  `id_suscripcion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario_premium` INT NOT NULL,
  `fecha_inicio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_renovacion` DATETIME NOT NULL,
  `forma_pago` ENUM('tarjeta', 'paypal') NOT NULL,
  INDEX `fk_suscripciones_usuario_premium_idx` (`id_usuario_premium` ASC) VISIBLE,
  PRIMARY KEY (`id_suscripcion`),
  CONSTRAINT `fk_suscripciones_usuario_premium`
    FOREIGN KEY (`id_usuario_premium`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `id_usuario_premium` INT NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  INDEX `fk_paypal_usuario_premium1_idx` (`id_usuario_premium` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_usuario_premium1`
    FOREIGN KEY (`id_usuario_premium`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`tarjeta` (
  `id_usuario_premium` INT NOT NULL,
  `numero_tarjeta` VARCHAR(45) NOT NULL,
  `mes_caducidad` INT NOT NULL,
  `año_caducidad` INT NOT NULL,
  `cvv` INT NOT NULL,
  INDEX `fk_tarjeta_usuario_premium1_idx` (`id_usuario_premium` ASC) VISIBLE,
  CONSTRAINT `fk_tarjeta_usuario_premium1`
    FOREIGN KEY (`id_usuario_premium`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`historial_pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`historial_pagos` (
  `id_orden_pago` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `precio_total` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_orden_pago`),
  UNIQUE INDEX `id_orden_pago_UNIQUE` (`id_orden_pago` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`pagos_suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pagos_suscripciones` (
  `id_suscripcion` INT NOT NULL,
  `id_orden_pago` INT NOT NULL,
  PRIMARY KEY (`id_suscripcion`, `id_orden_pago`),
  INDEX `fk_suscripciones_has_historial_pagos_historial_pagos1_idx` (`id_orden_pago` ASC) VISIBLE,
  INDEX `fk_suscripciones_has_historial_pagos_suscripciones1_idx` (`id_suscripcion` ASC) VISIBLE,
  CONSTRAINT `fk_suscripciones_has_historial_pagos_suscripciones1`
    FOREIGN KEY (`id_suscripcion`)
    REFERENCES `spotify`.`suscripciones` (`id_suscripcion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_suscripciones_has_historial_pagos_historial_pagos1`
    FOREIGN KEY (`id_orden_pago`)
    REFERENCES `spotify`.`historial_pagos` (`id_orden_pago`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `total_canciones` INT NOT NULL DEFAULT 0,
  `fecha_creacion` DATE NOT NULL,
  `is_deleted` ENUM('Y', 'N') NOT NULL COMMENT 'Y - YES\nN - NO',
  `is_shared` ENUM('Y', 'N') NOT NULL COMMENT 'Y - YES\nN - NO',
  PRIMARY KEY (`id_playlist`),
  INDEX `fk_playlists_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_eliminada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_eliminada` (
  `fecha_eliminacion` DATE NOT NULL,
  `id_playlist` INT NOT NULL,
  INDEX `fk_playlist_eliminada_playlists1_idx` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_eliminada_playlists1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`playlists` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists_compatidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists_compatidas` (
  `id_playlist` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_cancion_añadida` DATETIME NOT NULL,
  INDEX `fk_playlists_has_usuarios_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_playlists_has_usuarios_playlists1_idx` (`id_playlist` ASC) VISIBLE,
  PRIMARY KEY (`id_playlist`, `id_usuario`),
  CONSTRAINT `fk_playlists_has_usuarios_playlists1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`playlists` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlists_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistas` (
  `id_artista` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `url_imagen` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_artista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albumes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albumes` (
  `id_album` INT NOT NULL AUTO_INCREMENT,
  `id_artista` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `anyo_publicacion` INT NOT NULL,
  `url_imagen_portada` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_album`, `id_artista`),
  INDEX `fk_albumes_artistas1_idx` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_albumes_artistas1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`artistas` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`canciones` (
  `id_cancion` INT NOT NULL AUTO_INCREMENT,
  `id_album` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `duracion` INT NOT NULL,
  `reproducciones` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_cancion`, `id_album`),
  INDEX `fk_canciones_albumes1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_albumes1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`albumes` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albumes_favoritos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albumes_favoritos_usuarios` (
  `id_usuario` INT NOT NULL,
  `id_album` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_album`),
  INDEX `fk_canciones_has_usuarios_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_canciones_favoritas_usuarios_albumes1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canciones_favoritas_usuarios_albumes1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`albumes` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistas_seguidos_por_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistas_seguidos_por_usuarios` (
  `id_usuario` INT NOT NULL,
  `id_artista` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_artista`),
  INDEX `fk_artistas_has_usuarios_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_artistas_has_usuarios_artistas1_idx` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_artistas_has_usuarios_artistas1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`artistas` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artistas_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistas_relacionados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistas_relacionados` (
  `id_artista_relacionado` INT NOT NULL,
  INDEX `fk_artistas_has_artistas_artistas2_idx` (`id_artista_relacionado` ASC) VISIBLE,
  CONSTRAINT `fk_artistas_has_artistas_artistas2`
    FOREIGN KEY (`id_artista_relacionado`)
    REFERENCES `spotify`.`artistas` (`id_artista`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canciones_en_playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`canciones_en_playlists` (
  `id_cancion` INT NOT NULL,
  `id_playlist` INT NOT NULL,
  PRIMARY KEY (`id_cancion`, `id_playlist`),
  INDEX `fk_canciones_has_playlists_playlists1_idx` (`id_playlist` ASC) VISIBLE,
  INDEX `fk_canciones_has_playlists_canciones1_idx` (`id_cancion` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_has_playlists_canciones1`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `spotify`.`canciones` (`id_cancion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canciones_has_playlists_playlists1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`playlists` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canciones_favoritas_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`canciones_favoritas_usuarios` (
  `id_usuario` INT NOT NULL,
  `id_cancion` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_cancion`),
  INDEX `fk_canciones_has_usuarios_usuarios2_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_canciones_has_usuarios_canciones1_idx` (`id_cancion` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_has_usuarios_canciones1`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `spotify`.`canciones` (`id_cancion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canciones_has_usuarios_usuarios2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `spotify`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
