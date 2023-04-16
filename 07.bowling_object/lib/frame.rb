# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :next_frame, :after_next_frame

  def initialize(index, frames, first_mark, second_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @next_frame = frames[index + 1]
    @after_next_frame = frames[index + 2]
  end

  def self.calc_total_strike(frames)
    strikes = []
    frames.first(9).each do |fr|
      if fr.first_shot.mark == 10 && fr.next_frame[0] == 10
        strikes << [fr.next_frame[0], fr.after_next_frame[0]].sum
      elsif fr.first_shot.mark == 10
        strikes << fr.next_frame.sum
      end
    end
    strikes.sum
  end

  def self.calc_total_spare(frames)
    spares = []
    frames.first(9).each do |fr|
      spares << fr.next_frame[0] if [fr.first_shot.mark, fr.second_shot.mark].compact.sum == 10 && !fr.second_shot.mark.zero?
    end
    spares.sum
  end
end
