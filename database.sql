CREATE TABLE `s4`.`sclass` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `classname` VARCHAR(45) NULL,
  `status` TINYINT NULL,
  PRIMARY KEY (`id`));

  CREATE TABLE `s4`.`student` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
CREATE TABLE `s4`.`class_student` (
  `idclass_student` INT NOT NULL AUTO_INCREMENT,
  `id_class` INT NULL,
  `id_student` INT NULL,
  `status` TINYINT NULL,
  PRIMARY KEY (`idclass_student`));