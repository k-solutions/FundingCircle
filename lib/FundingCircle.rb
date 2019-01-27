require 'FundingCircle/formater'
require 'FundingCircle/parser'
require 'FundingCircle/primes'

module FundingCircle
  def run
    size   = Parser.new.options[:count]
    primes = Primes.upto size

    puts Formater.new(primes).to_table
  end
  module_function :run
end
