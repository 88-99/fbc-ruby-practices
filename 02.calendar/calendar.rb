#!/usr/bin/env ruby
require 'date'
require 'optparse'

params = ARGV.getopts("m:", "y:")

if params["y"] == nil
  @year = Date.today.year
else
  @year = params["y"].to_i
end

if params["m"] == nil
  @month = Date.today.month
else
  @month = params["m"].to_i
end

@first_date = Date.new(@year, @month, 1)
@first_wday = @first_date.wday

@end_date = Date.new(@year, @month, -1)

puts "      #{@month}月 #{@year}"
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

days_in_manth = (@first_date..@end_date).to_a

days_in_manth.each do |date|
  if date.day < 10
    print " #{date.day} "
  else
    print "#{date.day} "
  end
  print "\n" if date.saturday?
end
