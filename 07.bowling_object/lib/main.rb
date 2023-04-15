# frozen_string_literal: true

require_relative 'game'
require_relative 'frame'

game = Game.new
shots = game.convert_scores_to_shots
frames = game.create_frames_with_new
total_strike = game.calc_total_strike(frames)
total_spare = game.calc_total_spare(frames)

puts game.calc_total_score(shots, total_strike, total_spare)
