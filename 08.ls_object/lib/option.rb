# frozen_string_literal: true

require 'optparse'

class Option
  def initialize
    @option = parse_option
  end

  def parse_option
    argv_option = {}
    OptionParser.new do |opt|
      opt.on('-a') { |v| argv_option[:a] = v }
      opt.on('-l') { |v| argv_option[:l] = v }
      opt.on('-r') { |v| argv_option[:r] = v }
      opt.parse!(ARGV)
    end
    argv_option
  end

  def option_all?
    @option[:a]
  end

  def option_reverse?
    @option[:r]
  end

  def option_long?
    @option[:l]
  end
end
