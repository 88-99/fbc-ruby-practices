# frozen_string_literal: true

require_relative 'frame'

class Game
  def call_calc_total_score
    calc_total_score
  end

  private

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

  def create_frames_with_new
    slice_into_frames.map.each_with_index do |frame, index|
      Frame.new(index, slice_into_frames, *frame)
    end
  end

  def calc_total_strike(frames)
    Frame.calc_total_strike(frames)
  end

  def calc_total_spare(frames)
    Frame.calc_total_spare(frames)
  end

  def calc_total_score
    [convert_scores_to_shots.sum, calc_total_strike(create_frames_with_new), calc_total_spare(create_frames_with_new)].sum
  end
end

game = Game.new
p game.call_calc_total_score
