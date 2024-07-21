# Customer-Management

CREATE TABLE `organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `loginId` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `customerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `cusId_idx` (`customerId` ASC) VISIBLE,
  CONSTRAINT `cusId`
    FOREIGN KEY (`customerId`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

## JSON Web Token(JWT)
- https://jwt.io/ website to get secret key.

