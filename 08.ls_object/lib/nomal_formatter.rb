# frozen_string_literal: true

require_relative 'file_list'

class NomalFomatter
  def initialize(filenames)
    @filenames = filenames
  end

  def determine_row_indexes
    1.upto(NUMBER_OF_COLUMNS - 1).to_a
  end

  def find_max_character_number
    @filenames.map(&:length).max
  end

  def transpose_safely
    quotient, remainder = @filenames.length.divmod(NUMBER_OF_COLUMNS)
    if remainder != 0
      (NUMBER_OF_COLUMNS - remainder).times { @filenames << nil }
      @filenames.each_slice(quotient + 1).to_a.transpose
    else
      @filenames.each_slice(quotient).to_a.transpose
    end
  end

  def format
    max_character_number = find_max_character_number

    transpose_safely.compact.map do |row|
      rows = [row[0].ljust(max_character_number)]
      determine_row_indexes.each { |i| rows << row[i].ljust(max_character_number) unless row[i].nil? }
      rows.join(' ' * 4)
    end
  end
end
