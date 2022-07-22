-- MySQL Script generated by MySQL Workbench
-- Fri Jul 22 15:20:00 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TinyTheaters
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TinyTheaters
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TinyTheaters` DEFAULT CHARACTER SET utf8 ;
USE `TinyTheaters` ;

-- -----------------------------------------------------
-- Table `TinyTheaters`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyTheaters`.`Customer` ;

CREATE TABLE IF NOT EXISTS `TinyTheaters`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_first` VARCHAR(45) NOT NULL,
  `customer_last` VARCHAR(45) NOT NULL,
  `customer_email` VARCHAR(45) NOT NULL,
  `customer_address` VARCHAR(45) NULL,
  `customer_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyTheaters`.`Theater`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyTheaters`.`Theater` ;

CREATE TABLE IF NOT EXISTS `TinyTheaters`.`Theater` (
  `theater_id` INT NOT NULL AUTO_INCREMENT,
  `theater_name` VARCHAR(45) NOT NULL,
  `theater_address` VARCHAR(100) NOT NULL,
  `theater_phone` VARCHAR(45) NOT NULL,
  `theater_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`theater_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyTheaters`.`Show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyTheaters`.`Show` ;

CREATE TABLE IF NOT EXISTS `TinyTheaters`.`Show` (
  `show_id` INT NOT NULL AUTO_INCREMENT,
  `show_name` VARCHAR(45) NOT NULL,
  `ticket_price` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `theater_id` INT NOT NULL,
  PRIMARY KEY (`show_id`),
  INDEX `fk_Show_Theater1_idx` (`theater_id` ASC) VISIBLE,
  CONSTRAINT `fk_Show_Theater1`
    FOREIGN KEY (`theater_id`)
    REFERENCES `TinyTheaters`.`Theater` (`theater_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TinyTheaters`.`TicketPurchase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TinyTheaters`.`TicketPurchase` ;

CREATE TABLE IF NOT EXISTS `TinyTheaters`.`TicketPurchase` (
  `ticket_purchase_id` INT NOT NULL AUTO_INCREMENT,
  `seat_label` VARCHAR(2) NOT NULL,
  `customer_id` INT NOT NULL,
  `show_id` INT NOT NULL,
  PRIMARY KEY (`ticket_purchase_id`),
  INDEX `fk_TicketPurchase_Customer1_idx` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `seat_id_UNIQUE` (`seat_label` ASC) VISIBLE,
  INDEX `fk_TicketPurchase_Show1_idx` (`show_id` ASC) VISIBLE,
  CONSTRAINT `fk_TicketPurchase_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `TinyTheaters`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TicketPurchase_Show1`
    FOREIGN KEY (`show_id`)
    REFERENCES `TinyTheaters`.`Show` (`show_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
