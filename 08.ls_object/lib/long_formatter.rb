# frozen_string_literal: true

require_relative 'file_item'

class LongFomatter
  def initialize(file_items)
    @file_items = file_items
  end

  def format
    ["total #{@file_items.map(&:blocks).sum}", build_row_long_option]
  end

  def build_row_long_option
    @file_items.map do |file_item|
      row =  "#{file_item.permission}  "
      row += "#{file_item.nlink.to_s.rjust(find_max_value(build_nlinks))} "
      row += "#{file_item.user_name}  "
      row += "#{file_item.group_name}  "
      row += "#{file_item.size.to_s.rjust(find_max_value(build_sizes))} "
      row += "#{file_item.last_update_month.to_s.rjust(2)} "
      row += "#{file_item.last_update_day.to_s.rjust(2)} "
      row += "#{file_item.last_update_time} "
      row +  file_item.filename
    end
  end

  def build_nlinks
    @file_items.map(&:nlink)
  end

  def build_sizes
    @file_items.map(&:size)
  end

  def find_max_value(array)
    array.max.to_s.length
  end
end
