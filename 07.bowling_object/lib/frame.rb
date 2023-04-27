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

  def self.calc_total_strike(frames)
    strikes = []
    frames.first(9).each_with_index do |frame, i|
      next unless frame.strike?

      strikes << frames[i + 1].first_shot.score
      strikes << if frames[i + 1].strike?
                   frames[i + 2].first_shot.score
                 else
                   frames[i + 1].second_shot.score
                 end
    end
    strikes.sum
  end

  def self.calc_total_spare(frames)
    spares = []
    frames.first(9).each_with_index do |frame, i|
      spares << frames[i + 1].first_shot.score if frame.spare?
    end
    spares.sum
  end
end
