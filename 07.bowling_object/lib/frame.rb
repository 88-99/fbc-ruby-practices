# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :next_frame, :after_next_frame

  def initialize(index, frames, first_mark, second_mark = nil)
    @first_shot = first_mark
    @second_shot = second_mark
    @next_frame = frames[index + 1]
    @after_next_frame = frames[index + 2]
  end

  def strike?
    @first_shot&.score == 10
  end

  def self.calc_total_strike(frames)
    strikes = []
    frames.first(9).each do |fr|
      if fr.strike? && fr.next_frame[0].score == 10
        strikes << [fr.next_frame[0].score, fr.after_next_frame[0].score].sum
      elsif fr.strike?
        strikes << fr.next_frame.map(&:score).sum
      end
    end
    strikes.sum
  end

  def self.calc_total_spare(frames)
    spares = []
    frames.first(9).each do |fr|
      spares << fr.next_frame[0].score if [fr.first_shot.score, fr.second_shot.score].compact.sum == 10 && !fr.second_shot.score.zero?
    end
    spares.sum
  end
end
