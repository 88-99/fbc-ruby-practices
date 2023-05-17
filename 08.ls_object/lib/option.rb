# frozen_string_literal: true

require 'optparse'

class Option
  def parse_option(argv)
    argv_option = {}
    OptionParser.new do |opt|
      opt.on('-a') { |v| argv_option[:a] = v }
      opt.on('-l') { |v| argv_option[:l] = v }
      opt.on('-r') { |v| argv_option[:r] = v }
      opt.parse!(argv)
    end
    argv_option
  end

  def argv_option
    parse_option(ARGV)
  end
end
