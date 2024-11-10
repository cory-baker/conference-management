require 'sinatra'
require 'mysql2'

client = Mysql2::Client.new(
  host: 'localhost',
  username: 'root',
  password: 'root',
  database: 'conference'
)


set :bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/register' do
  name = params[:name]
  email = params[:email]
  phone = params[:phone]
  client.query("INSERT INTO attendees (name, email, phone) VALUES ('#{name}', '#{email}', '#{phone}')")
  erb :thanks
end
