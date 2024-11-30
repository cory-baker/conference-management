
get '/sessions' do
  @sessions = db_client.query("SELECT * FROM `session`")
  @title = "Sessions"
  erb :'sessions/index'
end

get '/sessions/new' do
  @title = "Create New Session"
  erb :'sessions/new'
end

get '/sessions/:id' do
  @session = db_client.query("SELECT * FROM `session` WHERE id=#{params[:id]}").first
  @conferences = db_client.query("SELECT * FROM `conference`")  # Fetch all conferences for the dropdown
  erb :'sessions/edit'
end

post '/sessions' do
  title = params[:title]
  conference_id = params[:conference_id]
  start_time = params[:start_time]
  end_time = params[:end_time]
  description = params[:description]
  db_client.query("INSERT INTO `session` (title, conference_id, start_time, end_time, description) VALUES ('#{title}', #{conference_id}, '#{start_time}', '#{end_time}', '#{description}')")
  redirect '/sessions'
end

post '/sessions/:id' do
  id = params[:id]
  title = params[:title]
  conference_id = params[:conference_id]
  start_time = params[:start_time]
  end_time = params[:end_time]
  description = params[:description]
  db_client.query("UPDATE `session` SET title='#{title}', conference_id=#{conference_id}, start_time='#{start_time}', end_time='#{end_time}', description='#{description}' WHERE id=#{id}")
  redirect '/sessions'
end

delete '/sessions/:id' do
  db_client.query("DELETE FROM `session` WHERE id=#{params[:id]}")
  redirect '/sessions'
end
