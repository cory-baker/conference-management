
# Conferences
get '/conferences' do
  @conferences = client.query("SELECT * FROM `conference`").to_a
  erb :'conferences/index'
end

get '/conferences/:id' do
  @conference = client.query("SELECT * FROM `conference` WHERE id=#{params[:id]}").first
  @attendees = client.query("SELECT u.* FROM `user` u JOIN `registration` r ON u.id = r.user_id WHERE r.conference_id=#{params[:id]}").to_a
  @sessions = client.query("SELECT * FROM `session` WHERE conference_id=#{params[:id]}").to_a
  erb :'conferences/show'
end

get '/conferences/new' do
  erb :'conferences/form'
end

post '/conferences' do
  title = params[:title]
  description = params[:description]
  start_date = params[:start_date]
  end_date = params[:end_date]
  location = params[:location]
  client.query("INSERT INTO `conference` (title, description, start_date, end_date, location) VALUES ('#{title}', '#{description}', '#{start_date}', '#{end_date}', '#{location}')")
  redirect '/conferences'
end

get '/conferences/:id/edit' do
  @conference = client.query("SELECT * FROM `conference` WHERE id=#{params[:id]}").first
  erb :'conferences/form'
end

put '/conferences/:id' do
  id = params[:id]
  title = params[:title]
  description = params[:description]
  start_date = params[:start_date]
  end_date = params[:end_date]
  location = params[:location]
  client.query("UPDATE `conference` SET title='#{title}', description='#{description}', start_date='#{start_date}', end_date='#{end_date}', location='#{location}' WHERE id=#{id}")
  redirect '/conferences'
end

delete '/conferences/:id' do
  client.query("DELETE FROM `conference` WHERE id=#{params[:id]}")
  redirect '/conferences'
end
