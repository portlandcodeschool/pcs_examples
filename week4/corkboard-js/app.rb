require 'rack'
require 'rack/contrib'
require 'rack/contrib/try_static'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'

use Rack::TryStatic,
  :root => "public",  # static files root dir
  :urls => %w[/],     # match all requests
  :try => ['.html', 'index.html', '/index.html'] # try these postfixes sequentially

get '/note/:id' do
  content_type :json
  json({ subject: 'test', content: 'test' })
end

post '/note/' do

end

put '/note/:id/' do

end

delete '/note/:id/' do

end

get '*' do

end