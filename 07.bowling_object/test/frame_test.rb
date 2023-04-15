# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/game'

class FrameTest < Minitest::Test
  def test_frame
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'])
    game = Game.new
    frames = game.create_frames_with_new

    assert_equal frames[0].after_next_frame, frames[1].next_frame
  end

  def test_calc_total_strike
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'])
    game = Game.new
    frames = game.create_frames_with_new

    assert_equal 20, game.calc_total_strike(frames)
  end

  def test_calc_total_spare
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'])
    game = Game.new
    frames = game.create_frames_with_new

    assert_equal 25, game.calc_total_spare(frames)
  end
end