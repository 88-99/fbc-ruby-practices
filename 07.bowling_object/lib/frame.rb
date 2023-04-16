# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :next_frame, :after_next_frame

  def initialize(index, frames, first_mark, second_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @next_frame = frames[index + 1].nil? ? [0, 0] : frames[index + 1]
    @after_next_frame = frames[index + 2].nil? ? [0, 0] : frames[index + 2]
# 元のコード
    # @next_frame = frames[index + 1]
    # @after_next_frame = frames[index + 2]
  end

  def self.calc_total_strike(frames)
    frames.first(9).sum do |fr|
      # if fr.first_shot.mark == 10 && fr.next_frame[0] == 10
        fr.next_frame[0] + fr.after_next_frame[0]
      # elsif fr.first_shot.mark == 10
        # fr.next_frame.sum
      # end
    end

# 元のコード
    # strikes = []
    # frames.first(9).each do |fr|
    #   if fr.first_shot.mark == 10 && fr.next_frame[0] == 10
    #     strikes << [fr.next_frame[0], fr.after_next_frame[0]].sum
    #   elsif fr.first_shot.mark == 10
    #     strikes << fr.next_frame.sum
    #   end
    # end
    # strikes.sum
  end

  def self.calc_total_spare(frames)
    frames.first(9).sum do |fr|
      fr.next_frame[0] # if [fr.first_shot.mark, fr.second_shot.mark].compact.sum == 10 && !fr.second_shot.mark.zero?
    end
  end

# 元のコード
  # def self.calc_total_spare(frames)
  #   spares = []
  #   frames.first(9).each do |fr|
  #     spares << fr.next_frame[0] if [fr.first_shot.mark, fr.second_shot.mark].compact.sum == 10 && !fr.second_shot.mark.zero?
  #   end
  #   spares.sum
  # end
end
