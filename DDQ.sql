/*

    Title: Data Definition Queries for Recipe Project
    Author: Mark Piccirilli
    Assignment: cs340 Project Step 2
    Date: 7/10/18

*/

-- Create the ingrediants table
DROP TABLE IF EXISTS `ingredients`;

CREATE TABLE `ingredients` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `calories` int(11) NOT NULL,
    `fat` int(11) NOT NULL,
    `sodium` int(11) NOT NULL,
    `sugar` int(11) NOT NULL,
    `protein` int(11) NOT NULL,
    `vitaminA` int(11) NOT NULL,
    `vitaminC` int(11) NOT NULL
)ENGINE=InnoDB;

-- Create the cookware table
DROP TABLE IF EXISTS `cookware`;

CREATE TABLE `cookware` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `cost` DECIMAL(19,4) DEFAULT NULL
)ENGINE=InnoDB;


-- Create the users table
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `firstName` varchar(255) NOT NULL,
    `lastName` varchar(255) NOT NULL,
    `userName` varchar(255) NOT NULL,
    `password` char(20) NOT NULL,
    `email` varchar(255) NOT NULL,
    `cookingExperience` varchar(5000)
)ENGINE=InnoDB;

-- Create the Recipes table

DROP TABLE IF EXISTS `recipes`;

CREATE TABLE `recipes` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `instructions` varchar(8000) NOT NULL,
    `meal_type` varchar(255) DEFAULT NULL,
    `ethnic_cuisine` varchar(255) DEFAULT NULL,
    `contributor` int(11),
    `date_contributed` date NOT NULL,
    FOREIGN KEY (`contributor`)REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
)ENGINE=InnoDB;

-- Create the user contributor table
DROP TABLE IF EXISTS `user_contributor`;

CREATE TABLE `user_contributor` (
    `user_id` int(11),
    `contributor_id` int(11),
    PRIMARY KEY (`user_id`, `contributor_id`),
    FOREIGN KEY (`contributor_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB;

-- Create the save recipes table

DROP TABLE IF EXISTS `saved_recipes`;

CREATE TABLE `saved_recipes` (
    `recipe_id` int(11),
    `user_id` int(11),
    PRIMARY KEY (`user_id`, `recipe_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
    FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB;

-- create recipe cookware table

DROP TABLE IF EXISTS `recipe_cookware`;

CREATE TABLE `recipe_cookware`(
    `recipe_id` int(11),
    `cookware_id` int(11),
    PRIMARY KEY(`recipe_id`, `cookware_id`),
    FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON UPDATE CASCADE,
    FOREIGN KEY (`cookware_id`) REFERENCES `cookware` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB;

-- create recipe ingredients table

DROP TABLE IF EXISTS `recipe_ingredients`;

CREATE TABLE `recipe_ingredients` (
    `recipe_id` int(11),
    `ingredients_id` int(11),
    PRIMARY KEY(`recipe_id`, `ingredients_id`),
    FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON UPDATE CASCADE,
    FOREIGN KEY (`ingredients_id`) REFERENCES `ingredients` (`id`) ON UPDATE CASCADE
)ENGINE=InnoDB;
