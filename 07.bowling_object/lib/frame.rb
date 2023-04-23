# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = Shot.new(0))
    @first_shot = first_mark
    @second_shot = second_mark
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    [@first_shot.score, @second_shot.score].compact.sum == 10 && !@second_shot.score.zero?
  end
end
