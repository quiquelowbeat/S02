-- Model: Youtube    Version: 1.0
-- Autor: Quique Sánchez Suárez

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `youtube` ;

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `sexo` ENUM('H', 'M', 'N') NOT NULL COMMENT 'H - hombre\nM - mujer\nN - prefiere no contestar',
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id_video` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` LONGTEXT NOT NULL,
  `tamaño` INT NOT NULL,
  `nombre_archivo` VARCHAR(45) NOT NULL,
  `duracion_video` INT NOT NULL,
  `thumbnail_url` VARCHAR(45) NOT NULL,
  `reproducciones` INT NOT NULL DEFAULT 0,
  `likes` INT NOT NULL DEFAULT 0,
  `dislikes` INT NOT NULL DEFAULT 0,
  `estado` ENUM('publico', 'oculto', 'privado') NOT NULL,
  `fecha_hora_publicacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario_publica` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_videos_usuarios_idx` (`id_usuario_publica` ASC) VISIBLE,
  CONSTRAINT `fk_videos_usuarios`
    FOREIGN KEY (`id_usuario_publica`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas` (
  `id_etiqueta` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_etiqueta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetas_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas_video` (
  `id_video` INT NOT NULL,
  `id_etiqueta` INT NOT NULL,
  PRIMARY KEY (`id_video`, `id_etiqueta`),
  INDEX `fk_videos_has_etiquetas_etiquetas1_idx` (`id_etiqueta` ASC) VISIBLE,
  INDEX `fk_videos_has_etiquetas_videos1_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_videos_has_etiquetas_videos1`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_has_etiquetas_etiquetas1`
    FOREIGN KEY (`id_etiqueta`)
    REFERENCES `youtube`.`etiquetas` (`id_etiqueta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`canales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canales` (
  `id_canal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TINYTEXT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario_creador` INT NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_canales_usuarios1_idx` (`id_usuario_creador` ASC) VISIBLE,
  CONSTRAINT `fk_canales_usuarios1`
    FOREIGN KEY (`id_usuario_creador`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`canales_suscritos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canales_suscritos_usuarios` (
  `id_canal` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  INDEX `fk_canales_has_usuarios_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_canales_has_usuarios_canales1_idx` (`id_canal` ASC) VISIBLE,
  PRIMARY KEY (`id_usuario`, `id_canal`),
  CONSTRAINT `fk_canales_has_usuarios_canales1`
    FOREIGN KEY (`id_canal`)
    REFERENCES `youtube`.`canales` (`id_canal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_canales_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`registro_videos_likes_dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`registro_videos_likes_dislikes` (
  `id_usuario` INT NOT NULL,
  `id_video` INT NOT NULL,
  `fecha_hora_like` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `like_dislike` ENUM('L', 'D') NULL COMMENT 'L - like\nD - dislike',
  INDEX `fk_usuarios_has_videos_videos1_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_usuarios_has_videos_usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  PRIMARY KEY (`id_video`, `id_usuario`),
  CONSTRAINT `fk_usuarios_has_videos_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuarios_has_videos_videos1`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentarios_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentarios_videos` (
  `id_comentario` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_video` INT NOT NULL,
  `texto` MEDIUMTEXT NOT NULL,
  `fecha_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comentario`, `id_video`),
  INDEX `fk_usuarios_has_videos_videos2_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_usuarios_has_videos_usuarios2_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_videos_usuarios2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuarios_has_videos_videos2`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlists_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlists_videos` (
  `id_playlist` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_video` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('publica', 'privada') NOT NULL,
  PRIMARY KEY (`id_playlist`, `id_video`, `id_usuario`),
  INDEX `fk_usuarios_has_videos_videos3_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_usuarios_has_videos_usuarios3_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_videos_usuarios3`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuarios_has_videos_videos3`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`registro_comentarios_likes_dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`registro_comentarios_likes_dislikes` (
  `id_usuario` INT NOT NULL,
  `id_comentario` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `like_dislike` ENUM('L', 'D') NOT NULL COMMENT 'L - like\nD - dislike',
  PRIMARY KEY (`id_comentario`, `id_usuario`),
  INDEX `fk_usuarios_has_comentarios_videos_comentarios_videos1_idx` (`id_comentario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_comentarios_videos_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuarios_has_comentarios_videos_comentarios_videos1`
    FOREIGN KEY (`id_comentario`)
    REFERENCES `youtube`.`comentarios_videos` (`id_comentario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
