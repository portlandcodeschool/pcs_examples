APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra'
require 'erb'
require "sinatra/reloader" if development?

set :root, APP_ROOT

set :server, :thin
connections = []

# Example of what a long-poll is actually doing
# TODO: Delete this route and render a login page
get '/' do
  stream do |out|
    out << "It's gonna be legen -\n"
    sleep 0.5
    out << " (wait for it) \n"
    sleep 1
    out << "- dary!\n"
  end
end

get '/chat' do
  # TODO: This should be protected. Make a new get '/' which allows people to login
  # TODO: If there isn't a username redirect back to /.

  # Render the chat template from below
  erb :chat
end

# In order to use EventSource we have to specify our Content-Type as 'text/event-stream'
get '/subscribe', :provides => 'text/event-stream' do
  # register a client's interest in server events
  return stream :keep_open do |out|
    # Store the connection so that we can use it later
    connections << out

    # When the connection does close, remove it from the storage
    out.callback { connections.delete(out) }
  end

  # We have to return the stream or the connection will close. Nothing can
  # be output here except for the stream
end

post '/message' do
  # For each of our connected clients, output the same message to all of them
  # The two newlines at the end mark the message 'complete' and renderable
  connections.each { |out| out << "data: #{params[:message]}\n\n" }

  # acknowledge with a 204 'nothing to see here' status
  204
end

# TODO Take these templates and put them somewhere a little more reasonable
# TODO Use the HTML5 Doctype
# TODO Use a specific version of jquery. If you use 1.9.1, make sure you get jquery-migrate.
__END__

@@ layout
<html>
  <head>
    <title>Super Simple Chat with Sinatra</title>
    <meta charset="utf-8" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
  </head>
  <body><%= yield %></body>
</html>

@@ login
<!-- TODO: This template should be completed with a field for the username -->

@@ chat
<pre id='chat'></pre>

<script>
  $(function () {
    // Open a persistent connection and manage reopening the connection
    // if it times out.
    var es = new EventSource('/subscribe');

    // If we hear the 'onmessage' event, do this thing to the page
    es.onmessage = function(e) {
      $('#chat').append(e.data + "\n");
    };

    // Override submit to post using ajax $.post. Then clear out the text
    // field and refocus the input.
    $(document).on("submit", function(e) {
      // TODO: This should use the username when sending the message. But how?
      $.post('/message', {message: $('#msg').val()});
      $('#msg').val(''); $('#msg').focus();
      e.preventDefault();
    });

    // Put the cursor in the text field to start with. Otherwise we have to
    // click in the text field to start chatting.
    $('#msg').focus();
  })
</script>

<form>
  <input id='msg' placeholder='type message here...' />
</form>

