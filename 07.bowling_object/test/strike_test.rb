# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/strike'

class StrikeTest < Minitest::Test
  def test_calc_total_strike
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    frames = game.create_frames_with_new
    assert_equal 20, Strike.new(frames).calc_total_strike
  end

  def test_calc_total_strike_when_all_strike
    game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    frames = game.create_frames_with_new
    assert_equal 180, Strike.new(frames).calc_total_strike
  end

  def test_calc_total_strike_when_no_strike
    game = Game.new('6,3,9,0,0,3,8,2,7,3,1,0,9,1,8,0,5,2,6,4,5')
    frames = game.create_frames_with_new
    assert_equal 0, Strike.new(frames).calc_total_strike
  end
end
