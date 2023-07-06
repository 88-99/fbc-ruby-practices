# frozen_string_literal: true

require_relative 'file_list'

NUMBER_OF_COLUMNS = 3

class NomalFormatter
  def initialize(filenames)
    @filenames = filenames
  end

  def find_max_character_number
    @filenames.map(&:length).max
  end

  def transpose_safely
    quotient, remainder = @filenames.length.divmod(NUMBER_OF_COLUMNS)
    each_sliced_filenames = if remainder != 0
                              (NUMBER_OF_COLUMNS - remainder).times { @filenames << nil }
                              @filenames.each_slice(quotient + 1)
                            else
                              @filenames.each_slice(quotient)
                            end
    each_sliced_filenames.to_a.transpose
  end

  def format
    max_character_number = find_max_character_number

    transpose_safely.compact.map do |row|
      rows = [row[0].ljust(max_character_number)]
      1.upto(NUMBER_OF_COLUMNS - 1).each { |i| rows << row[i].ljust(max_character_number) unless row[i].nil? }
      rows.join(' ' * 4)
    end
  end
end
