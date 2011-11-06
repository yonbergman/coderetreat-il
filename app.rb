require 'sinatra'
set :haml, :format => :html5

locales = {
    :title => "מפגש הקוד ריטריט העברי הראשון",
    :header1 => "מפגש הקוד ריטריט",
    :header2 => "העברי הראשון",
    :header3 => "יום שבת ה-3 בדצמבר",
    :ribbon => [
      "חלק מהיום",
      "הבינלאומי",
      "לקוד ריטריט"
    ]
}

get '/' do
  haml :index, :locals => locales
end

get '/style' do
  scss :style, :style => :expanded
end


