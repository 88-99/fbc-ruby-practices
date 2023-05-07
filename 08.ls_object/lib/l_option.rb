# frozen_string_literal: true

require 'etc'

class LOption
  attr_reader :paths

  def initialize(filenames)
    @paths = get_absolute_paths(filenames)
  end

  def get_absolute_paths(filenames)
    filenames.map { |x| "#{Dir.getwd}/#{x}" }
  end

  def calc_total_file_blocks
    paths.map { |x| File.stat(x).blocks }.sum
  end

  def build_row_l_option
    file_nlinks = paths.map { |x| File.stat(x).nlink }
    file_sizes = paths.map { |x| File.stat(x).size }

    paths.map do |fp|
      stat = File.stat(fp)
      row = "#{build_permission(stat)}  "
      row += "#{stat.nlink.to_s.rjust(file_nlinks.max.to_s.length)} "
      row += "#{Etc.getpwuid(File.stat(fp).uid).name}  "
      row += "#{Etc.getgrgid(File.stat(fp).gid).name}  "
      row += "#{stat.size.to_s.rjust(file_sizes.max.to_s.length)} "
      row += "#{stat.mtime.month.to_s.rjust(2)} "
      row += "#{stat.mtime.day.to_s.rjust(2)} "
      row += "#{stat.mtime.strftime('%H:%M')} "
      row + File.basename(fp)
    end
  end

  def build_permission(stat)
    permission_number = stat.mode.to_s(8)
    permission_number.insert(0, '0') if permission_number.length == 5
    permission = file_type[permission_number.slice(0..1)]
    permission += file_mode[permission_number.slice(2..3)]
    permission += file_mode["0#{permission_number.slice(4)}"]
    permission + file_mode["0#{permission_number.slice(5)}"]
  end

  def file_type
    {
      '01' => 'p',
      '02' => 'c',
      '04' => 'd',
      '06' => 'b',
      '10' => '-',
      '12' => 'l',
      '14' => 's'
    }
  end

  def file_mode
    {
      '00' => '---',
      '01' => '--x',
      '02' => '-w-',
      '03' => '-wx',
      '04' => 'r--',
      '05' => 'r-x',
      '06' => 'rw-',
      '07' => 'rwx'
    }
  end

  def total_file_blocks
    "total #{calc_total_file_blocks}"
  end

  def l_option
    build_row_l_option
  end
end
