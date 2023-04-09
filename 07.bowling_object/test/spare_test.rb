# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/spare'

class SpareTest < Minitest::Test
  def test_calc_total_spare
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    frames = game.create_frames_with_new
    assert_equal 25, Spare.new(frames).calc_total_spare
  end

  def test_calc_total_with_zero_spare
    game = Game.new('6,3,9,0,0,3,8,1,7,0,X,7,1,8,0,X,6,4,5')
    frames = game.create_frames_with_new
    assert_equal 0, Spare.new(frames).calc_total_spare
  end
end
