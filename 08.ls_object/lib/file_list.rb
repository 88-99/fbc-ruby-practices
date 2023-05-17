#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option'
require_relative 'file_item'

NUMBER_OF_COLUMNS = 3

class FileList
  def initialize
    @argv_option = Option.new.argv_option
    @file_list = apply_option_to_file_list
  end

  def apply_option_to_file_list
    file_list = @argv_option[:a] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    file_list = file_list.reverse if @argv_option[:r]
    file_list
  end

  def find_max_character_count
    @file_list.compact.map(&:length).max
  end

  def ls
    if @argv_option[:l]
      puts FileItem.new(@file_list).calc_total_file_blocks
      puts FileItem.new(@file_list).build_row_l_option
    else
      puts build_form_except_l_option
    end
  end

  def determine_row_indexes
    1.upto(NUMBER_OF_COLUMNS - 1).to_a
  end

  def transpose_safely
    quotient, remainder = @file_list.length.divmod(NUMBER_OF_COLUMNS)
    if remainder != 0
      (NUMBER_OF_COLUMNS - remainder).times { @file_list << nil }
      @file_list.each_slice(quotient + 1).to_a.transpose
    else
      @file_list.each_slice(quotient).to_a.transpose
    end
  end

  def build_form_except_l_option
    max_char = find_max_character_count

    transpose_safely.compact.map do |row|
      rows = [row[0].ljust(max_char)]
      determine_row_indexes.each { |i| rows << row[i].ljust(max_char) unless row[i].nil? }
      rows.join(' ' * 4)
    end
  end
end

FileList.new.ls
