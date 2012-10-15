require 'sinatra'
set :haml, :format => :html5

get '/' do
  redirect "/2012"
end

get '/2012' do
  haml :day2012
end

get '/2011' do
  haml :day2011
end

get '/style' do
  scss :style, :style => :expanded
end


