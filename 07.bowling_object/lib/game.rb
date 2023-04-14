# frozen_string_literal: true

require_relative 'frame'
require_relative 'strike'
require_relative 'spare'

class Game
  def split_scores
    ARGV[0].split(',')
  end

  def convert_scores_to_shots
    shots = []
    split_scores.each do |s|
      if s == 'X'
        shots << Shot.new(s).score
        shots << Shot.new(0).score
      else
        shots << Shot.new(s).score
      end
    end
    shots
  end

  def slice_into_frames
    convert_scores_to_shots.each_slice(2).to_a
  end

  def remove_zero_in_strike
    slice_into_frames.each { |frame| frame.delete(0) if frame == [10, 0] }
  end

  def create_frames_with_new
    remove_zero_in_strike.map.each_with_index do |frame, index|
      Frame.new(index, remove_zero_in_strike, *frame)
    end
  end

  def calc_total_score(shots, total_strike, total_spare)
    [shots.sum, total_strike, total_spare].sum
  end
end
