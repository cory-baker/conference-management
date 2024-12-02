require 'sinatra'
require_relative '../db/config'

get '/users' do
  @title = "Users"
  @users = db_client.query("SELECT * FROM `user`").to_a
  puts "DEBUG: @title = #{@title}"
  erb :'users/index', layout: true
end

get '/users/new' do
  @title = "New User"
  erb :'users/new'
end

get '/users/:id' do
  @title = "Edit User"
  if params[:id] =~ /^\d+$/
    @user = db_client.query("SELECT * FROM `user` WHERE id=#{params[:id]}").first
    erb :'users/edit'
  else
    halt 404, "User not found"
  end
end

post '/users' do
  name = params[:name]
  email = params[:email]
  role = params[:role]
  db_client.query("INSERT INTO `user` (name, email, role) VALUES ('#{name}', '#{email}', '#{role}')")
  redirect '/users'
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
