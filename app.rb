require 'sinatra'
require 'sinatra/contrib/all'
require 'json'
require 'pg'
require 'pry-byebug'

get '/' do
  redirect to('/videos')
end

get '/videos' do 
  sql = 'select * from videos'
  @videos = run_sql(sql) 

  if request.xhr? 
    json @videos.to_a
  else
  erb :index
  end
end

post '/videos' do
  binding.pry 
  sql = "insert into videos (title, url, genre, description) values ('#{title}', '#{url}', #{genre}, #{description}) returning *" 
  video = run_sql(sql)
  if request.xhr?
    json videos.first
  end
end

put '/videos:id' do

  sql = "update videos = '#{params[]}' where id = #{params[:id]}" #in first[]?
  @video = run_sql(sql)
  if request.xhr?
    json videos.first #?
  end
end

private 
def run_sql(sql)
  conn = PG.connect(:dbname =>'tube_app', :host => 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end

  result
end
