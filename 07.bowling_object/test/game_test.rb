# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'])
    @game = Game.new
  end

  def test_score
    assert_equal 139, @game.score
  end

  def test_split_scores
    assert_equal %w[6 3 9 0 0 3 8 2 7 3 X 9 1 8 0 X 6 4 5], @game.send(:split_scores)
  end

  def test_convert_scores_to_shots
    ARGV.replace(['2,3,X,6,4'])
    @game = Game.new
    shots = @game.send(:convert_scores_to_shots)

    assert [Shot.new('2'), Shot.new('3'), Shot.new('10'), Shot.new('0'), Shot.new('6'), Shot.new('4')], shots
  end

  def test_slice_into_frames
    ARGV.replace(['X,X,6,4'])
    @game = Game.new
    frames = @game.send(:slice_into_frames)

    assert [[Shot.new('10'), Shot.new('0')], [Shot.new('10'), Shot.new('0')], [Shot.new('6'), Shot.new('4')]], frames
  end
end
