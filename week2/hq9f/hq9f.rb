def h
  puts 'Hello World!'
end

require 'forwardable'

class HQ9F
  include Enumerable
  extend Forwardable

  def_delegators :@_store, :<<

  def initialize
    @_store = []
    @_lambdas = []
  end

  def self._99(n)
    msg = []

    n.downto(0) do |i|
      if i > 0
        msg << "#{i} bottles of beer on the wall,\n"
        msg << "#{i} bottles of beer.\n"
        msg << "Take one down, pass it around.\n"
        msg << "#{i-1} bottles of beer on the wall.\n"
      else
        msg << "No bottles of beer on the wall,\n"
        msg << "No bottles of beer.\n"
        msg << "Go to the store, buy some more,\n"
        msg << "#{n} new bottles of beer on the wall!"
      end
    end

    puts msg
  end

  def f(min, max, substitutions)
    min.upto(max) do |i|
      msg = ""

      substitutions.each_pair do |k,v|
        msg += v if i % k == 0
      end

      if !msg.empty?
        puts msg
      else
        puts i.to_s
      end
    end
  end

  def each(&blk)
    @_store.each(&blk)
  end

  def push_lambda(lamb)
    @_lambdas << lamb
  end

  def pop_lambda(*args)
    @_lambdas.pop.call(*args)
  end
end

require 'minitest/autorun'
class TestHQ9F < MiniTest::Unit::TestCase
  def test_h
    assert_output "Hello World!\n" do
      h
    end
  end

  def test_99
    out, err = capture_io do
      HQ9F._99(99)
    end
    assert_match /99 bottles of beer on the wall,\n/, out
    # assert_equal HQ9F._99(1).last, '1 new bottles of beer on the wall!'
  end

  def test_f
    out, err = capture_io do
      hq9f = HQ9F.new
      hq9f.f(1, 100, {3 => 'Chunky', 7 => 'Bacon', 17 => 'HeartPCS'})
    end
    result = out.split()
    assert_equal '1', result.first
    assert_equal 'Chunky', result[3-1]
    assert_equal 'HeartPCS', result[17-1]
  end

  def test_each
    hq9f = HQ9F.new
    10.times do |i|
      hq9f << i
    end
    hq9f.each_with_index do |k,v|
      assert_equal k,v
    end
  end

  def test_push_pop
    hq9f = HQ9F.new
    hq9f.push_lambda lambda { puts 'PCS Rocks' }
    assert_output "PCS Rocks\n" do
      hq9f.pop_lambda
    end
  end
end