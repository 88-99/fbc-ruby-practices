#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_item'

NUMBER_OF_COLUMNS = 3

class FileList
  def initialize(options)
    @options = options
    @filenames = fetch_files
    @file_items = fetch_files.map { FileItem.new(_1) }
  end

  def fetch_files
    filenames = @options[:option_all] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    filenames = filenames.reverse if @options[:option_reverse]
    filenames
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

  def refer_file_items
    @file_items
  end
end
