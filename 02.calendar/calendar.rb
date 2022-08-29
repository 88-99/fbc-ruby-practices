#!/usr/bin/env ruby
require 'date'
require 'optparse'

params = ARGV.getopts("m:", "y:")

if params["y"] == nil
  year = Date.today.year
else
  year = params["y"].to_i
end

if params["m"] == nil
  month = Date.today.month
else
  month = params["m"].to_i
end

first_date = Date.new(year, month, 1)
first_wday = first_date.wday

end_date = Date.new(year, month, -1)

puts "      #{month}月 #{year}"
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")

days_in_manth = (first_date..end_date).to_a

days_in_manth.each do |date|
  if date.day < 10
    case
    when first_wday == 1 && date.day == 1
      print "    #{first_date.day.to_s} "
    when first_wday == 2 && date.day == 1
      print "       #{first_date.day.to_s} "
    when first_wday == 3 && date.day == 1
      print "          #{first_date.day.to_s} "
    when first_wday == 4 && date.day == 1
      print "             #{first_date.day.to_s} "
    when first_wday == 5 && date.day == 1
      print "                #{first_date.day.to_s} "
    when first_wday == 6 && date.day == 1
      print "                   #{first_date.day.to_s} "
    else
      print " #{date.day} "
    end
  else
    print "#{date.day} "
  end
  print "\n" if date.saturday? || date == end_date
end
