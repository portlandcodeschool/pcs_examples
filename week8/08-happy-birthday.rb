# Happy Birthday
# Write a program that asks what year a person was born in, then the month, then the day.

# Figure out how old they are and give them a big SPANK! for each birthday they have had.

# Extensions
# Write tests, and make sure that they will work if you run them on December 31st and January 1st.

# Source
# Taken from Chapter 9 in Chris Pine's online Learn to Program tutorial.

require 'highline/import'

class HappyBirthday
  def initialize(year, month, day)
    @birth_date = Time.local(year, month, day, 12, 0, 0)
  end

  def self.start
    # Ask for year, month, day
    year  = ask("What year were you born?")
    month = ask("What month were you born?")
    day   = ask("What day of the month were you born on?")

    # Create new self with @birth_date
    birthday = self.new(year, month, day)

    # Call spank
    birthday.spank
  end

  private

  def spank
    # Find out how many spanks we need and output them
    spank_count.times do
      say("SPANK!")
    end
  end

  def spank_count
    # If the month < birthday month, subtract one from total years
    # If the month is the same, but the day < birthday day, subtract one from total years
    # Otherwise return current year - birth year
    @now = Time.now

    if @now.month < @birth_date.month || (@now.month == @birth_date.month && @now.day < @birth_date.day)
      @now.year - @birth_date.year - 1
    else
      @now.year - @birth_date.year
    end
  end
end

require 'rspec'
require 'rspec/autorun'
require 'timecop'

describe HappyBirthday do
  before do
    HappyBirthday.stub(:ask)
    HappyBirthday.stub(:say)
    @birthday = HappyBirthday.new(1982, 11, 17)
    @mock_birthday = double("HappyBirthday", :spank => true)
  end

  it "should have a main loop which is untestable" do
    HappyBirthday.should respond_to(:start)
  end

  it "should ask you when you were born" do
    # Because we included HighLine in HappyBirthday, we actually need to stub that
    HappyBirthday.stub(:new => @mock_birthday)
    HappyBirthday.should_receive(:ask).exactly(3).times
    HappyBirthday.start
  end

  it "should puts SPANK for each birthday you've had" do
    Timecop.travel(Time.local(2013, 11, 18, 12, 0, 0)) do
      @birthday.should_receive(:say).exactly(31).times
      @birthday.send(:spank)
    end
  end

  context "correct number of birthdays" do
    it "should report 30 on the day before the birthday" do
      Timecop.travel(Time.local(2013, 11, 16, 12, 0, 0)) do
        @birthday.send(:spank_count).should eql(30)
      end
    end

    it "should report 31 on the day after the birthday" do
      Timecop.travel(Time.local(2013, 11, 18, 12, 0, 0)) do
        @birthday.send(:spank_count).should eql(31)
      end
    end

    it "should work when run on Dec 31st" do
      Timecop.travel(Time.local(2013, 12, 31, 12, 0, 0)) do
        @birthday.send(:spank_count).should eql(31)
      end
    end

    it "should work when run on Jan 1st" do
      Timecop.travel(Time.local(2014, 1, 1, 12, 0, 0)) do
        @birthday.send(:spank_count).should eql(31)
      end
    end

    it "should be funny when the birthday is on Feb 29th" do
      pending
      Timecop.travel(Time.local(2013, 11, 18, 12, 0, 0)) do
        @birthday = HappyBirthday.new(2000, 2, 29)
        @birthday.send(:spank_count).should eql(3)
      end
    end
  end
end