require 'sinatra'
require 'mysql2'
set :bind, '0.0.0.0'
require_relative 'db/config'
require_relative 'db/init'
require_relative 'db/seeds'

require_relative 'controllers/users'
require_relative 'controllers/conferences'
require_relative 'controllers/sessions'
require_relative 'controllers/registrations'
