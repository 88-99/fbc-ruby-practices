# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = Shot.new(0))
    @first_shot = first_mark
    @second_shot = second_mark
  end

  def score(next_frame, next_next_frame)
    if strike?
      score = [total_shot, next_frame.total_shot].sum
      return  [score, next_next_frame.first_shot.score].sum if next_frame.strike?

      score
    elsif spare?
      [total_shot, next_frame.first_shot.score].sum
    else
      total_shot
    end
  end

  def total_shot
    [@first_shot, @second_shot].map(&:score).sum
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    total_shot == 10
  end
end
