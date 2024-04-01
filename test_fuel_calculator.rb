# frozen_string_literal: true

require './fuel_calculator'

# run with ruby -Ilib:test test_fuel_calculator.rb
class TestFuelCalculator < Minitest::Test
  GRAVITY = {
    earth: 9.807,
    moon: 1.62,
    mars: 3.711
  }.freeze

  def setup
    @class = FuelCalculator
  end

  def test_apollo11
    assert_equal 51_898, @class.new(
      28_801,
      [
        [:launch, GRAVITY[:earth]],
        [:land, GRAVITY[:moon]],
        [:launch, GRAVITY[:moon]],
        [:land, GRAVITY[:earth]]
      ]
    ).call
  end

  def test_mission_on_mars
    assert_equal 33_388, @class.new(
      14_606,
      [
        [:launch, GRAVITY[:earth]],
        [:land, GRAVITY[:mars]],
        [:launch, GRAVITY[:mars]],
        [:land, GRAVITY[:earth]]
      ]
    ).call
  end

  def test_passenger_ship
    assert_equal 212_161, @class.new(
      75_432,
      [
        [:launch, GRAVITY[:earth]],
        [:land, GRAVITY[:moon]],
        [:launch, GRAVITY[:moon]],
        [:land, GRAVITY[:mars]],
        [:launch, GRAVITY[:mars]],
        [:land, GRAVITY[:earth]]
      ]
    ).call
  end

  def test_invalid_input
    assert_equal @class::ERROR_RESPONCE, @class.new('invalid', 'invalid').call
  end
end
