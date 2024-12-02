
get '/conferences' do
  @title = "Conferences"
  @conferences = db_client.query("SELECT * FROM `conference`").to_a
  erb :'conferences/index'
end

get '/conferences/new' do
  @title = "New Conference"
  erb :'conferences/new'
end

get '/conferences/:id' do
  @title = "Conference Details"
  @conference = db_client.query("SELECT * FROM `conference` WHERE id=#{params[:id]}").first
  @users = db_client.query("SELECT u.* FROM `user` u JOIN `registration` r ON u.id = r.user_id WHERE r.conference_id=#{params[:id]}").to_a
  @sessions = db_client.query("SELECT * FROM `session` WHERE conference_id=#{params[:id]}").to_a
  erb :'conferences/show'
end

post '/conferences' do
  title = params[:title]
  description = params[:description]
  start_date = params[:start_date]
  end_date = params[:end_date]
  location = params[:location]
  db_client.query("INSERT INTO `conference` (title, description, start_date, end_date, location) VALUES ('#{title}', '#{description}', '#{start_date}', '#{end_date}', '#{location}')")
  redirect '/conferences'
end

get '/conferences/:id/edit' do
  @title = "Edit Conference"
  @conference = db_client.query("SELECT * FROM `conference` WHERE id=#{params[:id]}").first

  if @conference.nil?
    halt 404, "Conference not found"
  end

  erb :'conferences/edit'
end

post '/conferences/:id' do
  title = params[:title]
  description = params[:description]
  start_date = params[:start_date]
  end_date = params[:end_date]
  location = params[:location]

  db_client.query("UPDATE `conference` SET
    title = '#{title}',
    description = '#{description}',
    start_date = '#{start_date}',
    end_date = '#{end_date}',
    location = '#{location}'
    WHERE id = #{params[:id]}")

  redirect "/conferences/#{params[:id]}"
end

put '/conferences/:id' do
  id = params[:id]
  title = params[:title]
  description = params[:description]
  start_date = params[:start_date]
  end_date = params[:end_date]
  location = params[:location]
  db_client.query("UPDATE `conference` SET title='#{title}', description='#{description}', start_date='#{start_date}', end_date='#{end_date}', location='#{location}' WHERE id=#{id}")
  redirect '/conferences'
end

delete '/conferences/:id' do
  db_client.query("DELETE FROM `conference` WHERE id=#{params[:id]}")
  redirect '/conferences'
end
