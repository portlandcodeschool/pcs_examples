require './app'

# This will make app.rb automatically reload. But changes to this file
# will still need us to kill rackup and restart it.
use Rack::Reloader, 0

map '/hello' do
  run HelloWorld.new
end

map '/file' do
  run FileReader.new
end

map '/path' do
  run FilePathReader.new
end

map '/poster' do
  run Poster.new
end