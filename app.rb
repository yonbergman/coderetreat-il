require 'sinatra'
set :haml, :format => :html5

get '/' do
  haml :index
end

get '/style' do
  scss :style, :style => :expanded
end


