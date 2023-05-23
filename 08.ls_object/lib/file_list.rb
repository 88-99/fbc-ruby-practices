#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_item'

NUMBER_OF_COLUMNS = 3

class FileList
  attr_reader :filenames, :file_items

  def initialize(option_all:, option_reverse:)
    @option_all = option_all
    @option_reverse = option_reverse
    @filenames = fetch_files
    @file_items = fetch_files.map { FileItem.new(_1) }
  end

  def fetch_files
    filenames = @option_all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    filenames = filenames.reverse if @option_reverse
    filenames
  end

  def calc_total_file_blocks
    @file_items.map(&:blocks).sum
  end

  def make_nlinks
    @file_items.map(&:nlink)
  end

  def make_sizes
    @file_items.map(&:size)
  end

  def find_max_nlink
    make_nlinks.max.to_s.length
  end

  def find_max_size
    make_sizes.max.to_s.length
  end
end
