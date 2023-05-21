#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'option'
require_relative 'file_list'
require_relative 'long_formatter'
require_relative 'nomal_formatter'

class Ls
  def main
    options = Option.new
    filenames = FileList.new(option_all: options.option_all?, option_reverse: options.option_reverse?, option_long: options.option_long?)

    formatter = if options.option_long?
                  LongFomatter.new(filenames.refer_file_items).format
                else
                  NomalFomatter.new(filenames.transpose_safely).format
                end

    puts formatter
  end
end

Ls.new.main
