require 'rack'
require 'rack/contrib'
# require 'rack/contrib/try_static'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'

get '/note/:id/?' do
  content_type :json
  json subject: 'test', content: 'test'
end

post '/note/:id/?' do
  content_type :json
  json subject: 'test', content: 'test'
end

put '/note/?' do
  content_type :json
  json subject: 'test', content: 'test', id: 42
end

delete '/note/:id/?' do
  head :ok
end

# use Rack::TryStatic,
#   :root => File.expand_path('../public', __FILE__),  # static files root dir
#   :urls => %w[/],     # match all requests
#   :try => ['.html', 'index.html', '/index.html'] # try these postfixes sequentially
