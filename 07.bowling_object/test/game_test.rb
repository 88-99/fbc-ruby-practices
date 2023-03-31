# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    # @game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    @game = Game.new(ARGV[0])
    @shots = @game.calc_shots
    @frames = @game.build_frames(@shots)
  end

  def test_total_shots
    assert_equal 89, @game.calc_shots.sum
  end

  def test_total_strikes
    assert_equal 20, @game.calc_strikes(@frames).sum
  end

  def test_total_spares
    assert_equal 25, @game.calc_spares(@frames).sum
  end

  def test_total_scores
    assert_equal 134, @game.calc_total_score(@game, @shots, @frames)
  end
end
