# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'
require_relative '../lib/game'

class FrameTest < Minitest::Test
  def test_score
    frame = Frame.new(Shot.new('6'), Shot.new('3'))
    next_frame = Frame.new(Shot.new('10'))
    next_next_frame = Frame.new(Shot.new('2'), Shot.new('4'))

    assert_equal 9, frame.score(next_frame, next_next_frame)
  end

  def test_score_when_frame_is_strike
    frame = Frame.new(Shot.new('10'))
    next_frame = Frame.new(Shot.new('5'), Shot.new('2'))
    next_next_frame = Frame.new(Shot.new('2'), Shot.new('4'))

    assert_equal 17, frame.score(next_frame, next_next_frame)
  end

  def test_score_when_frame_and_next_frame_are_strike
    frame = Frame.new(Shot.new('10'))
    next_frame = Frame.new(Shot.new('10'))
    next_next_frame = Frame.new(Shot.new('2'), Shot.new('4'))

    assert_equal 22, frame.score(next_frame, next_next_frame)
  end

  def test_score_when_frame_is_spare
    frame = Frame.new(Shot.new('6'), Shot.new('4'))
    next_frame = Frame.new(Shot.new('5'), Shot.new('4'))
    next_next_frame = Frame.new(Shot.new('2'), Shot.new('4'))

    assert_equal 15, frame.score(next_frame, next_next_frame)
  end

  def test_total_shot
    frame = Frame.new(Shot.new('6'), Shot.new('3'))

    assert_equal 9, frame.total_shot
  end

  def test_strike_when_frame_is_strike
    frame = Frame.new(Shot.new('10'))

    assert frame.strike?
  end

  def test_strike_when_frame_is_not_strike
    frame = Frame.new(Shot.new('6'), Shot.new('4'))

    refute frame.strike?
  end

  def test_spare_when_frame_is_spare
    frame = Frame.new(Shot.new('6'), Shot.new('4'))

    assert frame.spare?
  end

  def test_spare_when_frame_is_not_spare
    frame = Frame.new(Shot.new('5'), Shot.new('0'))

    refute frame.spare?
  end
end
