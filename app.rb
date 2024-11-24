require 'sinatra'
require_relative './db/schema'
require_relative './db/seeds'
set :bind, '0.0.0.0'

require_relative 'controllers/users'
require_relative 'controllers/conferences'
require_relative 'controllers/sessions'
require_relative 'controllers/registrations'
