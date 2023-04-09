# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
  end

  def test_split_scores
    assert_equal %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X 6 4 5], @game.split_scores
  end

  def test_convert_scores_to_shots
    assert_equal [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 0, 9, 1, 8, 0, 10, 0, 6, 4, 5], @game.convert_scores_to_shots
  end

  def test_remove_zero_in_strike
    @game.convert_scores_to_shots

    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4], [5]], @game.remove_zero_in_strike
  end

  def test_calc_total_score
    shots = @game.convert_scores_to_shots
    frames = @game.create_frames_with_new
    total_strike = Strike.new(frames).calc_total_strike
    total_spare = Spare.new(frames).calc_total_spare

    assert_equal 139, @game.calc_total_score(shots, total_strike, total_spare)
  end
end
