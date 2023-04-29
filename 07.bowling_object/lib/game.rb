# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize
    @frames = create_frames_with_new
  end

  def score
    @frames.first(10).each_with_index.sum do |frame, index|
      frame.score(@frames[index + 1], @frames[index + 2])
    end
  end

  private

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
p game.score
