require 'sinatra'
require 'coffee-script'
set :haml, :format => :html5

get '/' do
  redirect '/2014'
end

get '/2014' do
  haml :day2014
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


get '/initech' do
  haml :'initech/initech'
end

get '/initech/onboarding' do
  haml :'initech/initech'
end

get '/initech/application.js' do
  coffee :'initech/application'
end

get '/initech/style.css' do
  scss :'initech/style'
end


