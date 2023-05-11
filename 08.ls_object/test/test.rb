# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'
require_relative '../lib/l_option'

class LsTest < Minitest::Test
  def setup
    @original_dir = Dir.pwd
    Dir.chdir('test_dir')
  end

  def teardown
    Dir.chdir(@original_dir)
  end

  def ls
    Ls.new
  end

  def test_parse_option
    assert_equal({ a: true, r: true }, ls.send(:parse_option, ARGV.replace(['-ar'])))
  end

  def test_apply_option_to_filenames
    assert_equal ['12345.txt', '99991111.txt', 'a.txt', 'b.txt', 'dir1', 'dir2', 'dir3'], ls.send(:apply_option_to_filenames)
  end

  def test_apply_option_to_filenames_with_r
    ARGV.replace(['-r'])

    assert_equal ['dir3', 'dir2', 'dir1', 'b.txt', 'a.txt', '99991111.txt', '12345.txt'], ls.send(:apply_option_to_filenames)
  end

  def test_determine_row_indexes
    assert_equal [1, 2], ls.send(:determine_row_indexes)
  end

  def test_transpose_safely
    ARGV.replace(['-a'])

    assert_equal [['.', 'a.txt', 'dir2'], ['12345.txt', 'b.txt', 'dir3'], ['99991111.txt', 'dir1', nil]], ls.send(:transpose_safely)
  end

  def test_build_form_except_l_option
    assert_equal ['12345.txt       b.txt           dir3        ', '99991111.txt    dir1        ', 'a.txt           dir2        '],
                 ls.send(:build_form_except_l_option)
  end

  def test_total_file_blocks
    ARGV.replace(['-a'])
    lop = LOption.new(ls.send(:apply_option_to_filenames))

    assert_equal 'total 16', lop.total_file_blocks
  end

  def test_l_option
    ARGV.replace(['-ar'])
    lop = LOption.new(ls.send(:apply_option_to_filenames))

    assert_equal ['drwxr-xr-x  2 kw  staff   64  5 11 14:48 dir3',
                  'drwxr-xr-x  2 kw  staff   64  5 11 14:48 dir2',
                  'drwxr-xr-x  2 kw  staff   64  5 11 14:48 dir1',
                  '-rw-r--r--  1 kw  staff    0  5 11 14:48 b.txt',
                  '-rw-r--r--  1 kw  staff    0  5 11 14:48 a.txt',
                  '-rw-r--r--  1 kw  staff   10  5 12 07:37 99991111.txt',
                  '-rw-r--r--  1 kw  staff    5  5 12 07:38 12345.txt',
                  'drwxr-xr-x  9 kw  staff  288  5 11 14:48 .'], lop.l_option
  end
end
