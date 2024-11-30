require 'mysql2'

# Database connection setup
def db_client
  @db_client ||= Mysql2::Client.new(
    host:'db',
    username: 'root',
    password: 'password',
    database: 'conference_db'
  )
end
