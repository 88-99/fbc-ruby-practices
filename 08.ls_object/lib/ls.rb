#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'l_option'

NUMBER_OF_COLUMNS = 3

class Ls
  attr_reader :argv_option, :filenames

  def initialize
    @argv_option = parse_option(ARGV)
    @filenames = apply_option_to_filenames
  end

  def output_ls
    if argv_option[:l]
      lop = LOption.new(apply_option_to_filenames)
      puts lop.total_file_blocks
      puts lop.l_option
    else
      puts build_form_except_l_option
    end
  end

  private

  def parse_option(argv)
    argv_option = {}
    OptionParser.new do |opt|
      opt.on('-a') { |v| argv_option[:a] = v }
      opt.on('-l') { |v| argv_option[:l] = v }
      opt.on('-r') { |v| argv_option[:r] = v }
      opt.parse!(argv)
    end
    argv_option
  end

  def apply_option_to_filenames
    filenames = argv_option[:a] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    filenames = filenames.reverse if argv_option[:r]
    filenames
  end

  def find_max_character_count
    filenames.compact.map(&:length).max
  end

  def determine_row_indexes
    1.upto(NUMBER_OF_COLUMNS - 1).to_a
  end

  def transpose_safely
    quotient, remainder = @filenames.length.divmod(NUMBER_OF_COLUMNS)
    if remainder != 0
      (NUMBER_OF_COLUMNS - remainder).times { filenames << nil }
      filenames.each_slice(quotient + 1).to_a.transpose
    else
      filenames.each_slice(quotient).to_a.transpose
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

ls = Ls.new
ls.output_ls
