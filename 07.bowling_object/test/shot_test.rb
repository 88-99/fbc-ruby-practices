# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_change_into_score
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_change_into_valid_number
    shot = Shot.new('8')
    assert_equal 8, shot.score
  end
end
