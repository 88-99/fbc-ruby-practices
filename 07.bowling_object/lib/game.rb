# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def split_scores
    @scores.split(',')
  end

  def convert_splits_to_shots
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

  def remove_zero_in_strike
    frames = []
    convert_splits_to_shots.each_slice(2) { |s| frames << s }
    frames.each { |frame| frame.delete(0) if frame == [10, 0] }
  end

  def shots_score_to_frames
    remove_zero_in_strike.map.each_with_index do |frame, index|
      Frame.new(index, remove_zero_in_strike, *frame)
    end
  end

  def calc_total_score(shots, total_strike, total_spare)
    puts [shots.sum, total_strike, total_spare].sum
  end
end
