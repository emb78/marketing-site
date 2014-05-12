require 'sinatra/base'
require './main'

map('/') { run Website }