require 'pry'

module FundingCircle
  module Primes
    extend self
    MAXBOUND = 100_000 # The max bound of the prime number range

    def take(size)
      raise ArgumentError if size < 1

      range
        .select { |v| prime? v }
        .take(size - 1)
        .to_a
        .unshift(2) # adds 2 as we take only odd numbers
    end

    protected

    def range
      (3..MAXBOUND).step(2).lazy # we skip all even numbers
    end

    def prime?(n)
      subrange(sub(n)).each do |k|
        return false if n % k == 0
      end

      true
    end

    def subrange(size)
      (3..size).step(2).lazy
    end

    def sub(n)
      n / 2 + 1
    end
  end

  # NOTE: Use only primes as divisors
  # but still slightly slower than base
  module OnlyPrimes
    extend self
    extend Primes

    def take(size)
      raise ArgumentError if size < 1

      @primes = [2]
      range.each do |v|
        @primes << v if prime? v
      end
       .take(size - 1)
       .to_a
    end

    private

    def prime?(n)
      @primes.each do |k|
        return false if n % k == 0
      end

      true
    end
  end

  # NOTE: As optimisation point we cache
  # all previous calculation involved in
  # prime? method
  # But it dosn't seem to work as cache get big and complex key access is slow!
  class CachedPrimes
    include Primes

    def initialize
      @cache ||= Hash.new { |h, k| h[k] = k[1].divmod k[0] } # Cache key is [divider, divided]
    end

    def prime?(n)
      subrange(sub(n)).each do |k|
        dm = @cache[[k, n]]
        return false if dm[1] == 0
      end

      true
    end
  end
end
