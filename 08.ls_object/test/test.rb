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
end
