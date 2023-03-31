# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/game'

class FrameTest < Minitest::Test
  def test_frame
    game = Game.new(ARGV[0])
    # game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    shots = game.calc_shots
    frames = game.build_frames(shots)
    frames = frames.map.each_with_index do |frame, index|
      Frame.new(index, frames, *frame)
    end

    assert_equal frames[0].after_next_frame, frames[1].next_frame
  end
end
