require 'mysql2'

def db_client
  client = Mysql2::Client.new(
    host: 'db',
    username: 'root',
    password: 'password'
  )

  client.query("CREATE DATABASE IF NOT EXISTS conference_db")

  @db_client ||= Mysql2::Client.new(
    host: 'db',
    username: 'root',
    password: 'password',
    database: 'conference_db'
  )

  return @db_client
end
