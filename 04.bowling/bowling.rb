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
shots.each_slice(2) do |s|
  frames << s
end

frames.each do |frame|
  frame.delete(0) if frame == [10, 0]
end

strikes = []
spares = []
frames.first(9).each_with_index do |frame, i|
  if frame == [10]
    strikes << i
  elsif frame.sum == 10
    spares << i
  end
end

basic_points = []
frames.each do |frame|
  basic_points << frame.sum
end

strike_points = []
strikes.each do |strike|
  strike_points << if frames[strike] == [10]
                     if frames[strike + 1] == [10]
                       frames[strike + 1][0] + frames[strike + 2][0]
                     else
                       frames[strike + 1].sum
                     end
                   end
end

spare_points = []
spares.each do |spare|
  spare_points << (frames[spare + 1][0])
end

p (basic_points + strike_points + spare_points).sum
