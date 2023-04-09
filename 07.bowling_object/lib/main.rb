# frozen_string_literal: true

require_relative 'game'
require_relative 'strike'
require_relative 'spare'

game = Game.new(ARGV[0])
shots = game.convert_scores_to_shots
frames = game.create_frames_with_new
total_strike = Strike.new(frames).calc_total_strike
total_spare = Spare.new(frames).calc_total_spare
puts game.calc_total_score(shots, total_strike, total_spare)
