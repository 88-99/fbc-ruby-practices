# frozen_string_literal: true

class Strike
  attr_reader :frames

  def initialize(frames)
    @frames = frames
  end

  def calc_total_strike
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
end
