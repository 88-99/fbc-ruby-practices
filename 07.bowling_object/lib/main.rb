# frozen_string_literal: true

require_relative 'game'
require_relative 'strike'
require_relative 'spare'

game = Game.new(ARGV[0])
shots = game.convert_splits_to_shots
frames = game.shots_score_to_frames
total_strike = Strike.new(frames).calc_total_strike
total_spare = Spare.new(frames).calc_total_spare
game.calc_total_score(shots, total_strike, total_spare)
