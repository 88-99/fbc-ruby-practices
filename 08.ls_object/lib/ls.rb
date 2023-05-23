#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option'
require_relative 'file_list'
require_relative 'long_formatter'
require_relative 'nomal_formatter'

class Ls
  def main
    options = Option.new
    file_list = FileList.new(option_all: options.option_all?, option_reverse: options.option_reverse?)
    formatter = if options.option_long?
                  LongFomatter.new(file_list.file_items, file_list.calc_total_file_blocks, file_list.find_max_nlink, file_list.find_max_size).format
                else
                  NomalFomatter.new(file_list.filenames).format
                  # NomalFomatter.new(filenames.transpose_safely).format
                end

    puts formatter
  end
end

Ls.new.main
