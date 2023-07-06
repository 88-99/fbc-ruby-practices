# frozen_string_literal: true

require 'etc'

class FileItem
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    path = "#{Dir.getwd}/#{@filename}"
    @file_stat = File.stat(path)
  end

  def permission
    permission_number = @file_stat.mode.to_s(8)
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

  def blocks
    @file_stat.blocks
  end

  def nlink
    @file_stat.nlink
  end

  def user_name
    Etc.getpwuid(@file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(@file_stat.gid).name
  end

  def size
    @file_stat.size
  end

  def mode
    @file_stat.mode.to_s(8)
  end

  def last_update_month
    @file_stat.mtime.month
  end

  def last_update_day
    @file_stat.mtime.day
  end

  def last_update_time
    @file_stat.mtime.strftime('%H:%M')
  end
end
