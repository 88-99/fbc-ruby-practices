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
                  LongFormatter.new(file_list).format
                else
                  NomalFormatter.new(file_list.filenames).format
                end

    puts formatter
  end
end

Ls.new.main
