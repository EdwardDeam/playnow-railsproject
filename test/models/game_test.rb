require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new(
      title: 'Test Game',
      genre: 'Strategy',
      price: 1567,
      description: 'This is the description')
  end

  def test_price
    assert_equal 1567, @game.price
  end

  def test_price_to_decimal
    assert_equal 15.67, @game.price_to_decimal
  end

  def test_price_to_string
    assert_equal '$57.93', @game.test_price_to_string(5793)
  end
end
