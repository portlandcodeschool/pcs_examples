module SpaceAge
  def self.years_old(seconds, planet='earth')
    (seconds.to_i / seconds_per_year_on(planet)).round
  end

  def self.seconds_per_year_on(planet)
    case planet.downcase
    when 'mercury'
      0.2408467 * 31557600
    when 'venus'
      0.61519726 * 31557600
    when 'mars'
      1.8808158 * 31557600
    when 'jupiter'
      11.862615 * 31557600
    when 'saturn'
      29.447498 * 31557600
    when 'uranus'
      84.016846 * 31557600
    when 'neptune'
      164.79132 * 31557600
    else
      1 * 31557600
    end
  end
end

require 'minitest/spec'
require 'minitest/autorun'

describe "SpaceAge" do
  it "should calculate how old someone is" do
    SpaceAge.years_old("1031000000").must_equal(32)
  end

  it "should calculate how old someone is on another planet" do
    SpaceAge.years_old("1031000000", 'venus').must_equal(53)
  end
end