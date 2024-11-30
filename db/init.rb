require_relative './config.rb'
puts db_client
sql_statements = [
  <<~SQL,
    CREATE TABLE IF NOT EXISTS `conference` (
      `id` int NOT NULL AUTO_INCREMENT,
      `title` varchar(200) NOT NULL,
      `description` text,
      `start_date` datetime NOT NULL,
      `end_date` datetime NOT NULL,
      `location` varchar(255) NOT NULL,
      PRIMARY KEY (`id`)
    );
  SQL

  <<~SQL,
    CREATE TABLE IF NOT EXISTS `user` (
      `id` int NOT NULL AUTO_INCREMENT,
      `name` varchar(100) NOT NULL,
      `email` varchar(100) NOT NULL,
      `role` enum('admin','attendee','speaker') NOT NULL,
      `registered_at` datetime,
      PRIMARY KEY (`id`),
      UNIQUE (`email`)
    );
  SQL

  <<~SQL,
    CREATE TABLE IF NOT EXISTS `registration` (
      `user_id` int NOT NULL,
      `conference_id` int NOT NULL,
      `registration_time` datetime,
      PRIMARY KEY (`user_id`,`conference_id`),
      KEY `conference_id` (`conference_id`),
      CONSTRAINT `registration_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
      CONSTRAINT `registration_conference_fk` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE CASCADE
    );
  SQL

  <<~SQL,
    CREATE TABLE IF NOT EXISTS `session` (
      `id` int NOT NULL AUTO_INCREMENT,
      `title` varchar(200) NOT NULL,
      `conference_id` int DEFAULT NULL,
      `start_time` datetime NOT NULL,
      `end_time` datetime NOT NULL,
      `description` text,
      PRIMARY KEY (`id`),
      KEY `conference_id` (`conference_id`),
      CONSTRAINT `session_conference_fk` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE CASCADE
    );
  SQL
]

sql_statements.each do |sql|
  begin
    db_client.query(sql)
    puts "Successfully executed:\n#{sql}"
  rescue Mysql2::Error => e
    puts "Error executing SQL: #{e.message}"
  end
end
