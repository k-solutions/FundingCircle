require 'test_helper'

class PrimesTest < Minitest::Unit::TestCase
  BASE_PRIMES = [2, 3, 5, 7, 11].freeze
  HALF_PRIMES = BASE_PRIMES + [13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
  FULL_PRIMES = HALF_PRIMES + [53, 59, 61, 67, 71, 73, 79, 83, 89, 97]

  def test_eq_only
    [2, 11, 50, 100, 300].each do |n|
      assert_equal FundingCircle::Primes.take(n), FundingCircle::OnlyPrimes.take(n)
    end
  end

  def test_eq_cached
    [2, 11, 50, 100, 300].each do |n|
      assert_equal FundingCircle::Primes.take(n), FundingCircle::CachedPrimes.new.take(n)
    end
  end

  def test_valid_1
    assert_equal [2, 3], FundingCircle::Primes.take(2)
  end

  def test_valid_2
    assert_equal BASE_PRIMES, FundingCircle::Primes.take(5)
  end

  def test_valid_3
    assert_equal HALF_PRIMES, FundingCircle::Primes.take(15)
  end

  def test_valid_4
    assert_equal FULL_PRIMES, FundingCircle::Primes.take(25)
  end

  def test_invalid_8
    assert_raises(ArgumentError) { FundingCircle::Primes.take(0) }
  end
end
