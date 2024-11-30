require 'sinatra'
require_relative '../db/config'

get '/users' do
  @users = db_client.query("SELECT * FROM `user`").to_a
  erb :'users/index'
end

get '/users/:id' do
  @user = db_client.query("SELECT * FROM `user` WHERE id=#{params[:id]}").first
  erb :'users/show'
end

get '/users/new' do
  erb :'users/form'
end

post '/users' do
  name = params[:name]
  email = params[:email]
  role = params[:role]
  db_client.query("INSERT INTO `user` (name, email, role) VALUES ('#{name}', '#{email}', '#{role}')")
  redirect '/users'
end

get '/users/:id/edit' do
  @user = db_client.query("SELECT * FROM `user` WHERE id=#{params[:id]}").first
  erb :'users/form'
end

put '/users/:id' do
  id = params[:id]
  name = params[:name]
  email = params[:email]
  role = params[:role]
  db_client.query("UPDATE `user` SET name='#{name}', email='#{email}', role='#{role}' WHERE id=#{id}")
  redirect '/users'
end

delete '/users/:id' do
  db_client.query("DELETE FROM `user` WHERE id=#{params[:id]}")
  redirect '/users'
end
