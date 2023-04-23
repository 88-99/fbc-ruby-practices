# frozen_string_literal: true

require_relative 'frame'

class Game
  def call_calc_total_score
    calc_total_score
  end

  def split_scores
    ARGV[0].split(',')
  end

  def convert_scores_to_shots
    shots = []
    split_scores.each do |s|
      if s == 'X'
        shots << Shot.new(s)
        shots << Shot.new(0)
      else
        shots << Shot.new(s)
      end
    end
    shots
  end

  def slice_into_frames
    convert_scores_to_shots.each_slice(2).to_a
  end

  def create_frames_with_new
    slice_into_frames.map do |frame|
      Frame.new(*frame)
    end
  end
end

game = Game.new

strikes = []
frames = game.create_frames_with_new
frames.first(9).each_with_index do |frame, i|
  next unless frame.strike?

  strikes << frames[i + 1].first_shot.score
  strikes << if frames[i + 1].strike?
               frames[i + 2].first_shot.score
             else
               frames[i + 1].second_shot.score
             end
end

spares = []
frames = game.create_frames_with_new
frames.first(9).each_with_index do |frame, i|
  spares << frames[i + 1].first_shot.score if frame.spare?
end

p [game.convert_scores_to_shots.map(&:score).sum, strikes.sum, spares.sum].sum
