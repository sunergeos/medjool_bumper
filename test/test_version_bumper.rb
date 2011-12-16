require 'helper'

# Remember to use today's date when testing.

class TestVersionBumper < MiniTest::Unit::TestCase
  def test_that_it_should_set_current_date
    v = Bumper::Medjool.new('0.0.0.0')
    assert_equal '0.2011.1216.0', v.to_s
  end

  def test_that_it_should_retain_initialized_version
    v = Bumper::Medjool.new('12.1962.0507.28')
    assert_equal '12.1962.0507.28', v.to_s
  end

  def test_that_it_should_have_correct_properties_test
    v = Bumper::Medjool.new('12.196205.07.28')
    assert_equal '12', v.major
    assert_equal '196205', v.minor
    assert_equal '07', v.revision
    assert_equal '28', v.build
  end

  def test_that_it_should_bump_major_same_date
    v = Bumper::Medjool.new('0.2011.1216.0')
    assert_equal '1', v.mbump_major
    assert_equal '1.2011.1216.0', v.to_s
  end

  def test_that_it_should_bump_major_again_same_date
    v = Bumper::Medjool.new('9.2011.1216.0')
    assert_equal '10', v.mbump_major
    assert_equal '10.2011.1216.0', v.to_s
  end

  def test_that_it_should_bump_major_and_update_date_and_build
    v = Bumper::Medjool.new('99.2010.1105.16')
    assert_equal '100', v.mbump_major
    assert_equal '100.2011.1216.0', v.to_s
  end

  def test_that_it_should_bump_build_from_init_state
    v = Bumper::Medjool.new('0.2011.1216.0')
    assert_equal '1', v.mbump_build
    assert_equal '0.2011.1216.1', v.to_s
  end

  def test_that_it_should_bump_two_digit_build
    v = Bumper::Medjool.new('0.2011.1216.17')
    assert_equal '18', v.mbump_build
    assert_equal '0.2011.1216.18', v.to_s
  end

  def test_that_it_should_bump_build_amd_retain_major
    v = Bumper::Medjool.new('11.2011.1216.17')
    assert_equal '18', v.mbump_build
    assert_equal '11.2011.1216.18', v.to_s
  end

end