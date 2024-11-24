require 'sinatra'

get '/users' do
  @users = client.query("SELECT * FROM `user`").to_a
  erb :'users/index'
end

get '/users/:id' do
  @user = client.query("SELECT * FROM `user` WHERE id=#{params[:id]}").first
  erb :'users/show'
end

get '/users/new' do
  erb :'users/form'
end

post '/users' do
  name = params[:name]
  email = params[:email]
  role = params[:role]
  client.query("INSERT INTO `user` (name, email, role) VALUES ('#{name}', '#{email}', '#{role}')")
  redirect '/users'
end

get '/users/:id/edit' do
  @user = client.query("SELECT * FROM `user` WHERE id=#{params[:id]}").first
  erb :'users/form'
end

put '/users/:id' do
  id = params[:id]
  name = params[:name]
  email = params[:email]
  role = params[:role]
  client.query("UPDATE `user` SET name='#{name}', email='#{email}', role='#{role}' WHERE id=#{id}")
  redirect '/users'
end

delete '/users/:id' do
  client.query("DELETE FROM `user` WHERE id=#{params[:id]}")
  redirect '/users'
end
