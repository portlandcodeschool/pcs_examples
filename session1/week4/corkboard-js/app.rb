require 'rack'
require 'rack/contrib'
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