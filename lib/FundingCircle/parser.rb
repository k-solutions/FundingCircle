require 'optparse'

module FundingCircle
  class Parser
    VALID_NUMBERS_RANGE = 1..100
    attr_reader :options

    def initialize
      @options = {}

      validate
    end

    private

    def validate
      parse
      abort("The count must be in #{VALID_NUMBERS_RANGE}") unless VALID_NUMBERS_RANGE.cover? @options[:count]
    end

    def parse
      OptionParser.new do |parser|
        parser.on('-c', '--count COUNT', Integer, 'Generates prime numbers multiplication table upto COUNT') do |v|
          @options[:count] = v
        end

        parser.on_tail('-h', '--help', 'Show help') do
          puts parser
          exit
        end
      end.parse!
    end
  end
end
