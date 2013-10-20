require 'sinatra'
set :haml, :format => :html5

get '/' do
  redirect '/2013'
end

get '/2013' do
  haml :day2013
end

get '/2013-raanana' do
  haml :raanana2013
end

get '/2012' do
  haml :day2012
end

get '/2012-haifa' do
  haml :haifa2012
end

get '/2011' do
  haml :day2011
end

get '/style' do
  scss :style, :style => :expanded
end


