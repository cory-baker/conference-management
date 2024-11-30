require_relative './config.rb'

seed_statements = [
  <<~SQL,
    INSERT INTO `user` (name, email, role) VALUES
      ('Alice', 'alice@example.com', 'admin'),
      ('Bob', 'bob@example.com', 'attendee'),
      ('Charlie', 'charlie@example.com', 'speaker'),
      ('Diana', 'diana@example.com', 'attendee');
  SQL

  <<~SQL,
    INSERT INTO `conference` (title, description, start_date, end_date, location) VALUES
      ('Tech Innovators Conference', 'A conference for tech enthusiasts.', '2024-12-01 09:00:00', '2024-12-03 17:00:00', 'New York City'),
      ('Health and Wellness Summit', 'Discussing the future of health and wellness.', '2025-01-15 10:00:00', '2025-01-16 15:00:00', 'San Francisco'),
      ('Education for All Forum', 'Promoting educational equity worldwide.', '2025-02-20 09:00:00', '2025-02-22 17:00:00', 'Chicago');
  SQL

  <<~SQL,
    INSERT INTO `session` (title, conference_id, start_time, end_time, description) VALUES
      ('AI and Machine Learning', 1, '2024-12-01 10:00:00', '2024-12-01 11:30:00', 'Exploring the latest advancements in AI.'),
      ('Future of Health Tech', 2, '2025-01-15 11:00:00', '2025-01-15 12:30:00', 'How technology is shaping the health sector.'),
      ('Educational Technology Trends', 3, '2025-02-20 10:00:00', '2025-02-20 11:30:00', 'Leveraging tech to enhance education.');
  SQL

  <<~SQL,
    INSERT INTO `registration` (user_id, conference_id) VALUES
      (2, 1), -- Bob registers for Tech Innovators Conference
      (2, 2), -- Bob registers for Health and Wellness Summit
      (3, 3), -- Charlie registers for Education for All Forum
      (4, 1); -- Diana registers for Tech Innovators Conference
  SQL
]

seed_statements.each do |sql|
  begin
    db_client.query(sql)
    puts "Successfully executed seed data:\n#{sql}"
  rescue Mysql2::Error => e
    puts "Error executing SQL: #{e.message}"
  end
end
