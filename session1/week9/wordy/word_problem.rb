class WordProblem
  attr_reader :answer

  def initialize(problem_string)
    @problem = parse(problem_string)
    @answer = apply(@problem)
  end

  private

  def parse(problem_string)
    problem_string.gsub!(/What is/, '')
    problem_string = problem_string.chomp
    problem_string.gsub!(/\?/, '')
    problem_string.gsub!(/plus/, '+')
    problem_string.gsub!(/minus/, '-')
    return problem_string
  end

  def apply(problem)
    begin
      return eval(problem)
    rescue SyntaxError
      throw ArgumentError.new
    end
  end
end