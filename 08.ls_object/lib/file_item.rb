# frozen_string_literal: true

require 'etc'

class FileItem
  def initialize(file_list)
    @paths = get_absolute_paths(file_list)
  end

  def get_absolute_paths(file_list)
    file_list.map { |filename| "#{Dir.getwd}/#{filename}" }
  end

  def calc_total_file_blocks
    "total #{@paths.map { |path| File.stat(path).blocks }.sum}"
  end

  def build_row_l_option
    file_nlinks = @paths.map { |path| File.stat(path).nlink }
    file_sizes = @paths.map { |path| File.stat(path).size }

    @paths.map do |path|
      stat = File.stat(path)
      row = "#{build_permission(stat)}  "
      row += "#{stat.nlink.to_s.rjust(file_nlinks.max.to_s.length)} "
      row += "#{Etc.getpwuid(File.stat(path).uid).name}  "
      row += "#{Etc.getgrgid(File.stat(path).gid).name}  "
      row += "#{stat.size.to_s.rjust(file_sizes.max.to_s.length)} "
      row += "#{stat.mtime.month.to_s.rjust(2)} "
      row += "#{stat.mtime.day.to_s.rjust(2)} "
      row += "#{stat.mtime.strftime('%H:%M')} "
      row + File.basename(path)
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
end
