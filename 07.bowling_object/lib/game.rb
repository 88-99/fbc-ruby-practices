# frozen_string_literal: true

require_relative 'frame'

class Game < Frame
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def calc_shots
    scores = @scores.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << Shot.new(s).score
        shots << Shot.new(nil).score
      else
        shots << Shot.new(s).score
      end
    end
    shots
  end

  def build_frames(shots)
    frames = []
    shots.each_slice(2) { |s| frames << s }
    frames.each { |frame| frame.delete(0) if frame == [10, 0] }
    frames = frames.map.each_with_index do |frame, index|
      Frame.new(index, frames, *frame)
    end
  end

  def calc_total_score(game, shots, frames)
    [shots.sum, game.calc_strikes(frames).sum, game.calc_spares(frames).sum].sum
  end

  game = Game.new(ARGV[0])
  shots = game.calc_shots
  frames = game.build_frames(shots)
  p game.calc_total_score(game, shots, frames)
end
