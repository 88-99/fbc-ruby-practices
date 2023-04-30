# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark == 'X' ? 10 : mark
  end

  def score
    mark.to_i
  end
end
