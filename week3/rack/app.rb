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

class RPS
  def call(env)
    headers = {'Content-Type' => 'text/html'}
    request = Rack::Request.new(env)

    user_choice = request.params['user_choice']
    computer_choice = ["rock", "scissors", "paper", "lizard", "spock"].sample

    return [200, headers, [choice(user_choice, computer_choice)]]
  end

  def choice(user_choice, computer_choice)
    case user_choice
    when "rock"
    case computer_choice
      when "rock"
        return "I choose rock too. We just rock together. Tie."
      when "scissors"
        return "I choose scissors. You broke my blades! You win!"
      when "paper"
        return "I choose paper. I wrap you, and kill you. I win! "
      when "lizard"
        return "I choose lizard. Your rocked crushed me. You win!"
      when "spock"
        return "I choose Spock. I vaporize your rock. You lose!"
      end

    when "paper"
      case computer_choice
      when "rock"
        return "I choose rock. You hugged me to death. You win!"
      when "scissors"
        return "I choose scissors. I cut you up, and you lose!"
      when "paper"
        return "I choose paper. We just lay on each other. Tie."
      when "lizard"
        return "I choose lizard. I eat your paper. You lose!"
      when "spock"
        return "I choose Spock. You disproved me with your paper. You Win!"
      end

    when "scissors"
      case computer_choice
      when "rock"
        return "I choose rock. I break you, and you lose! "
      when "scissors"
        return "I choose scissors. Tie game."
      when "paper"
        return "I choose paper. Ow! You cut me! You Win!"
      when "lizard"
        return "I choose lizard. You decapitated me. You are sick, but you win!"
      when "spock"
        return "I choose Spock. I smash your scissors. You lose!"
      end

    when "lizard"
      case computer_choice
      when "rock"
        return "I choose rock. I smash you. You lose!"
      when "scissors"
        return "I choose scissors. I cut your head off, sorry. You lose!"
      when "paper"
        return "I choose paper. You ate me. You Win!"
      when "lizard"
        return "I choose lizard. We just stare at each other. Tie."
      when "spock"
        return "I choose Spock. You poison me. You win!"
      end

    when "spock"
      case computer_choice
      when "rock"
        return "I choose rock. Zap! You vaporized me! You win."
      when "scissors"
        return "I choose scissors. You smashed me. You win!"
      when "paper"
        return "I choose paper. I disproved you. You lose!"
      when "lizard"
        return "I choose lizard. I bite you and poison you. You lose!"
      when "spock"
        return "I choose old Spock. You lose. ;)"
      end
    end
  end
end




















