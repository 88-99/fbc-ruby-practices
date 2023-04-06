# frozen_string_literal: true

require_relative 'game'

class Spare
  attr_reader :frames

  def initialize(frames)
    @frames = frames
  end

  def calc_total_spare
    spares = []
    frames.first(9).each do |fr|
      spares << fr.next_frame[0] if [fr.first_shot.mark, fr.second_shot.mark].compact.sum == 10 && !fr.second_shot.mark.nil?
    end
    spares.sum
  end
end
