# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) { |s| frames << s }

frames.each { |frame| frame.delete(0) if frame == [10, 0] }

strikes = []
spares = []
frames.first(9).each_with_index do |frame, i|
  if frame == [10]
    strikes << i
  elsif frame.sum == 10
    spares << i
  end
end

basic_points = frames.map(&:sum)

strike_points = strikes.map do |strike|
  if frames[strike] == [10]
    if frames[strike + 1] == [10]
      frames[strike + 1][0] + frames[strike + 2][0]
    else
      frames[strike + 1].sum
    end
  end
end

spare_points = spares.map { |spare| frames[spare + 1][0] }

p (basic_points + strike_points + spare_points).sum
