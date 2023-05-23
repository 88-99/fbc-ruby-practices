# frozen_string_literal: true

require_relative 'file_item'

class LongFomatter
  def initialize(file_items, total_file_blocks, max_nlink, max_size)
    @file_items = file_items
    @total_file_blocks = total_file_blocks
    @max_nlink = max_nlink
    @max_size = max_size
  end

  def format
    ["total #{@total_file_blocks}", build_row]
  end

  def build_row
    @file_items.map do |file_item|
      row =  "#{file_item.permission}  "
      row += "#{file_item.nlink.to_s.rjust(@max_nlink)} "
      row += "#{file_item.user_name}  "
      row += "#{file_item.group_name}  "
      row += "#{file_item.size.to_s.rjust(@max_size)} "
      row += "#{file_item.last_update_month.to_s.rjust(2)} "
      row += "#{file_item.last_update_day.to_s.rjust(2)} "
      row += "#{file_item.last_update_time} "
      row +  file_item.filename
    end
  end
end
