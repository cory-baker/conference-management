require 'sinatra'
set :bind, '0.0.0.0'

get '/' do
  "Hello, Sinatra on Docker!"
end
