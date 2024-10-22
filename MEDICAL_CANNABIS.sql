-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MEDICAL_CANNABIS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MEDICAL_CANNABIS` ;

-- -----------------------------------------------------
-- Schema MEDICAL_CANNABIS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MEDICAL_CANNABIS` DEFAULT CHARACTER SET utf8 ;
USE `MEDICAL_CANNABIS` ;

-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`ROLES` (
  `idROLES` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idROLES`),
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`USERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`USERS` (
  `idUSERS` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `ROLES_idROLES` INT NOT NULL,
  PRIMARY KEY (`idUSERS`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_USERS_ROLES1_idx` (`ROLES_idROLES` ASC) VISIBLE,
  CONSTRAINT `fk_USERS_ROLES1`
    FOREIGN KEY (`ROLES_idROLES`)
    REFERENCES `MEDICAL_CANNABIS`.`ROLES` (`idROLES`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`BRANDS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`BRANDS` (
  `idBRANDS` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(100) NOT NULL,
  `USERS_idUSERS` INT NOT NULL,
  PRIMARY KEY (`idBRANDS`),
  INDEX `fk_BRANDS_USERS1_idx` (`USERS_idUSERS` ASC) VISIBLE,
  CONSTRAINT `fk_BRANDS_USERS1`
    FOREIGN KEY (`USERS_idUSERS`)
    REFERENCES `MEDICAL_CANNABIS`.`USERS` (`idUSERS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`CANNABINOIDS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`CANNABINOIDS` (
  `idCANNABINOIDS` INT NOT NULL AUTO_INCREMENT,
  `abbreviation` VARCHAR(10) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCANNABINOIDS`),
  UNIQUE INDEX `abbreviation_UNIQUE` (`abbreviation` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`STRAINS_VARIEDADES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`STRAINS_VARIEDADES` (
  `Idstains` INT NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(255) NOT NULL,
  `strain_name` VARCHAR(100) NOT NULL,
  `cannabinoid_abbreviation` VARCHAR(10) NOT NULL,
  `cannabinoid` VARCHAR(100) NOT NULL,
  `terpene` VARCHAR(50) NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `buzzword` VARCHAR(45) NOT NULL,
  `BRANDS_idBRANDS` INT NOT NULL,
  `CANNABINOIDS_idCANNABINOIDS` INT NOT NULL,
  PRIMARY KEY (`Idstains`),
  INDEX `fk_STRAINS_VARIEDADES_BRANDS1_idx` (`BRANDS_idBRANDS` ASC) VISIBLE,
  INDEX `fk_STRAINS_VARIEDADES_CANNABINOIDS1_idx` (`CANNABINOIDS_idCANNABINOIDS` ASC) VISIBLE,
  CONSTRAINT `fk_STRAINS_VARIEDADES_BRANDS1`
    FOREIGN KEY (`BRANDS_idBRANDS`)
    REFERENCES `MEDICAL_CANNABIS`.`BRANDS` (`idBRANDS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STRAINS_VARIEDADES_CANNABINOIDS1`
    FOREIGN KEY (`CANNABINOIDS_idCANNABINOIDS`)
    REFERENCES `MEDICAL_CANNABIS`.`CANNABINOIDS` (`idCANNABINOIDS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`MEDICAL_USES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`MEDICAL_USES` (
  `idMEDICAL_USES` INT NOT NULL AUTO_INCREMENT,
  `medical_use` VARCHAR(255) NOT NULL,
  `health_benefit` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idMEDICAL_USES`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MEDICAL_CANNABIS`.`STRAINS_MEDICAL_USES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAL_CANNABIS`.`STRAINS_MEDICAL_USES` (
  `STRAINS_VARIEDADES_Idstains` INT NOT NULL,
  `MEDICAL_USES_idMEDICAL_USES` INT NOT NULL,
  PRIMARY KEY (`STRAINS_VARIEDADES_Idstains`, `MEDICAL_USES_idMEDICAL_USES`),
  INDEX `fk_STRAINS_VARIEDADES_has_MEDICAL_USES_MEDICAL_USES1_idx` (`MEDICAL_USES_idMEDICAL_USES` ASC) VISIBLE,
  INDEX `fk_STRAINS_VARIEDADES_has_MEDICAL_USES_STRAINS_VARIEDADES_idx` (`STRAINS_VARIEDADES_Idstains` ASC) VISIBLE,
  CONSTRAINT `fk_STRAINS_VARIEDADES_has_MEDICAL_USES_STRAINS_VARIEDADES`
    FOREIGN KEY (`STRAINS_VARIEDADES_Idstains`)
    REFERENCES `MEDICAL_CANNABIS`.`STRAINS_VARIEDADES` (`Idstains`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STRAINS_VARIEDADES_has_MEDICAL_USES_MEDICAL_USES1`
    FOREIGN KEY (`MEDICAL_USES_idMEDICAL_USES`)
    REFERENCES `MEDICAL_CANNABIS`.`MEDICAL_USES` (`idMEDICAL_USES`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
