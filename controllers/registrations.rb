
get '/registrations' do
  @registrations = db_client.query('
    SELECT r.user_id, r.conference_id, u.name AS user_name, c.title AS conference_title
    FROM registration r
    JOIN user u ON r.user_id = u.id
    JOIN conference c ON r.conference_id = c.id
    ORDER BY c.start_date, u.name
  ').map do |row|
    {
      user_name: row['user_name'],
      conference_title: row['conference_title'],
      user_id: row['user_id'],
      conference_id: row['conference_id']
    }
  end
  erb :'registrations/index'
end

get '/registrations/new' do
  @users =  db_client.query('SELECT id, name, email FROM user').map do |row|
    { id: row['id'], name: row['name'], email: row['email'] }
  end
  @conferences = db_client.query('SELECT id, title, location FROM conference').map do |row|
    { id: row['id'], title: row['title'], location: row['location'] }
  end
  erb :'registrations/new'
end

post '/registrations' do
  user_id = params[:user_id]
  conference_id = params[:conference_id]
  db_client.query("INSERT INTO `registration` (user_id, conference_id) VALUES (#{user_id}, #{conference_id})")
  redirect '/registrations'
end

delete '/registrations' do
  user_id = params[:user_id]
  conference_id = params[:conference_id]
  db_client.query("DELETE FROM `registration` WHERE user_id=#{user_id} AND conference_id=#{conference_id}")
  redirect '/registrations'
end
