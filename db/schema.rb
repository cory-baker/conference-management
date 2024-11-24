require 'sinatra'
require 'mysql2'

client = Mysql2::Client.new(
  host: 'localhost',
  username: 'root',
  password: 'root',
  database: 'conference',
)

client.query <<-SQL
  CREATE TABLE IF NOT EXISTS `conference` (
    `id` int NOT NULL AUTO_INCREMENT,s
    `title` varchar(200) NOT NULL,
    `description` text,
    `start_date` datetime NOT NULL,
    `end_date` datetime NOT NULL,
    `location` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
  )
SQL

client.query <<-SQL
  CREATE TABLE IF NOT EXISTS `registration` (
    `user_id` int NOT NULL,
    `conference_id` int NOT NULL,
    `registration_time` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`,`conference_id`),
    KEY `conference_id` (`conference_id`),
    CONSTRAINT `registration` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `registration` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE CASCADE
  )
SQL

client.query <<-SQL
  CREATE TABLE IF NOT EXISTS `registration` (
    `user_id` int NOT NULL,
    `conference_id` int NOT NULL,
    `registration_time` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`,`conference_id`),
    KEY `conference_id` (`conference_id`),
    CONSTRAINT `registration` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `registration` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE CASCADE
  )
SQL

client.query <<-SQL
  CREATE TABLE IF NOT EXISTS `session` (
    `id` int NOT NULL AUTO_INCREMENT,
    `title` varchar(200) NOT NULL,
    `conference_id` int DEFAULT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    `description` text,
    PRIMARY KEY (`id`),
    KEY `conference_id` (`conference_id`),
    CONSTRAINT `session` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE CASCADE
  )
SQL

client.query <<-SQL
  CREATE TABLE IF NOT EXISTS `user` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `email` varchar(100) NOT NULL,
    `role` enum('admin','attendee','speaker') NOT NULL,
    `registered_at` datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `email` (`email`)
  )
SQL
