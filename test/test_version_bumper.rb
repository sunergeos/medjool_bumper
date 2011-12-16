require 'helper'

class TestVersionBumper < MiniTest::Unit::TestCase
  def test_that_it_should_set_current_date
    v = Bumper::Medjool.new('0.0.0.0')
    assert_equal '0.201112.15.0', v.to_s
  end

  def test_that_it_should_retain_initialized_version
    v = Bumper::Medjool.new('12.196205.07.28')
    assert_equal '12.196205.07.28', v.to_s
  end

  def test_that_it_should_have_correct_properties_test
    v = Bumper::Medjool.new('12.196205.07.28')
    assert_equal '12', v.major
    assert_equal '196205', v.minor
    assert_equal '07', v.revision
    assert_equal '28', v.build
  end

  def test_that_it_should_bump_major_same_date
    v = Bumper::Medjool.new('0.201112.15.0')
    assert_equal '1', v.mbump_major
    assert_equal '1.201112.15.0', v.to_s
  end

  def test_that_it_should_bump_major_again_same_date
    v = Bumper::Medjool.new('9.201112.15.0')
    assert_equal '10', v.mbump_major
    assert_equal '10.201112.15.0', v.to_s
  end

  def test_that_it_should_bump_major_and_update_date_and_build
    v = Bumper::Medjool.new('99.201011.05.16')
    assert_equal '100', v.mbump_major
    assert_equal '100.201112.15.0', v.to_s
  end

  def test_that_it_should_bump_build_from_init_state
    v = Bumper::Medjool.new('0.201112.15.0')
    assert_equal '1', v.mbump_build
    assert_equal '0.201112.15.1', v.to_s
  end

  def test_that_it_should_bump_two_digit_build
    v = Bumper::Medjool.new('0.201112.15.17')
    assert_equal '18', v.mbump_build
    assert_equal '0.201112.15.18', v.to_s
  end

  def test_that_it_should_bump_build_amd_retain_major
    v = Bumper::Medjool.new('11.201112.15.17')
    assert_equal '18', v.mbump_build
    assert_equal '11.201112.15.18', v.to_s
  end

end