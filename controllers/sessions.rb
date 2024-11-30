
# Sessions
get '/sessions' do
  @sessions = client.query("SELECT * FROM `session`").to_a
  erb :'sessions/index'
end

get '/sessions/:id' do
  @session = client.query("SELECT * FROM `session` WHERE id=#{params[:id]}").first
  erb :'sessions/show'
end

get '/sessions/new' do
  erb :'sessions/form'
end

post '/sessions' do
  title = params[:title]
  conference_id = params[:conference_id]
  start_time = params[:start_time]
  end_time = params[:end_time]
  description = params[:description]
  client.query("INSERT INTO `session` (title, conference_id, start_time, end_time, description) VALUES ('#{title}', #{conference_id}, '#{start_time}', '#{end_time}', '#{description}')")
  redirect '/sessions'
end

get '/sessions/:id/edit' do
  @session = client.query("SELECT * FROM `session` WHERE id=#{params[:id]}").first
  erb :'sessions/form'
end

put '/sessions/:id' do
  id = params[:id]
  title = params[:title]
  conference_id = params[:conference_id]
  start_time = params[:start_time]
  end_time = params[:end_time]
  description = params[:description]
  client.query("UPDATE `session` SET title='#{title}', conference_id=#{conference_id}, start_time='#{start_time}', end_time='#{end_time}', description='#{description}' WHERE id=#{id}")
  redirect '/sessions'
end

delete '/sessions/:id' do
  client.query("DELETE FROM `session` WHERE id=#{params[:id]}")
  redirect '/sessions'
end
