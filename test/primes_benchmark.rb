require 'test_helper'

class PrimesBenchmark < Minitest::Benchmark
  def self.bench_range
    bench_linear 10, 100, 20
  end

  def setup
    @size   = 100 # rand(450..500)
    @cached = FundingCircle::CachedPrimes.new
  end

  def bench_primes
    assert_performance_linear do |n|
      n.times { FundingCircle::Primes.take @size }
    end
  end

  def bench_only
    assert_performance_linear do |n|
      n.times { FundingCircle::OnlyPrimes.take @size }
    end
  end

  def bench_cached
    assert_performance_linear do |n|
      n.times { @cached.take @size }
    end
  end
end
