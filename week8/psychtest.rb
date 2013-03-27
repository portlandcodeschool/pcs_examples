class PsychTest
  @@questions = [
    "What is your favorite color?"
  ].shuffle

  def random_question
  end

  def start
  end

  attr_reader :important_answer
end

require 'rspec'
require 'rspec/autorun'

describe PsychTest do
  before do
    @test = PsychTest.new
  end

  it "should ask 10 questions" do
    @test.should_receive(:random_question).exactly(10).times
    @test.start
  end

  it "should not ask the same question twice" do
    first_question = @test.random_question
    9.times do
      @test.random_question.should_not eql(first_question)
    end
  end

  it "should make a conclusion based on one important question" do
    @test.instance_variable_set(:@important_answer, "yes")
    @test.should_receive(:conclusion).once
    @test.start
  end

  it "should store the answer to the important question" do
    @test.start
    @test.important_answer.should_not be_nil
  end
end