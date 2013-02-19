# Most basic Rack app possible.
class HelloWorld
  def call(env)
    headers = {'Content-Type' => 'text/html'}
    [200, headers, ['Hello World!']]
  end
end

# Read a file from the filesystem at a predetermined location
class FileReader
  def call(env)
    headers = {'Content-Type' => 'text/html'}
    # __FILE__ is the path to this file. File.dirname strips everything
    # after the last /. File.join safely constructs file paths even
    # on windows (which uses \ instead of /)
    file_path = File.join(File.dirname(__FILE__), 'index.html')

    if File.exists?(file_path)
      return [200, headers, [File.read(file_path)]]
    else
      return [404, headers, ['Not Found!']]
    end
  end
end

# Try to read a file from the filesystem based on the path requested
# through the browser. If it's a directory we need to add index.html.
class FilePathReader
  def call(env)
    headers = {'Content-Type' => 'text/html'}
    request = Rack::Request.new(env)
    file_path = File.join(File.dirname(__FILE__), request.path)
    # The config.ru is adding on /path so we need to remove that for
    # us to find files. Either that or we need to add a directory
    # called path and keep our html files in there.
    file_path.gsub!('/path', '')

    if File.directory?(file_path)
      file_path += '/index.html'
    end

    if File.exists?(file_path)
      return [200, headers, [File.read(file_path)]]
    else
      return [404, headers, ['Not Found!']]
    end

    # This could also be this:
    # begin
    #   return [200, headers, [File.read(file_path)]]
    # rescue
    #   return [400, headers, 'Not Found!']
    # end
  end
end

# Analyze GET/POST params. This could also use Rack::Request#GET or
# Rack::Request#POST but Rack::Request#params gets us both sets.
# Call this using: curl -X POST -H "Content-type: application/x-www-form-urlencoded" -d "key=value&key2=value2" http://localhost:9292/poster
class Poster
  def call(env)
    headers = {'Content-Type' => 'text/html'}
    request = Rack::Request.new(env)

    return [200, headers, [request.params.inspect]]
  end
end