
# Registrations
get '/registrations' do
  @registrations = client.query("SELECT * FROM `registration`").to_a
  erb :'registrations/index'
end

post '/registrations' do
  user_id = params[:user_id]
  conference_id = params[:conference_id]
  client.query("INSERT INTO `registration` (user_id, conference_id) VALUES (#{user_id}, #{conference_id})")
  redirect '/registrations'
end

delete '/registrations' do
  user_id = params[:user_id]
  conference_id = params[:conference_id]
  client.query("DELETE FROM `registration` WHERE user_id=#{user_id} AND conference_id=#{conference_id}")
  redirect '/registrations'
end
