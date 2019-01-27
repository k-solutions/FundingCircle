require 'terminal-table'

# TODO: Think about pagination
module FundingCircle
  class Formater
    def initialize(primes)
      @primes = primes
      @cache  = Hash.new { |h, k| h[k] = k[0] * k[1] }
    end

    def to_table
      Terminal::Table.new do |t|
        t.style    = TABLE_STYLE
        t.headings = [nil] + @primes # we add nil in headings for proper shift
        t.rows = rows
      end
    end

    private

    TABLE_STYLE = { border_top: false,
                    border_bottom: false,
                    alignment: :right }.freeze
    def rows
      @primes.inject([]) do |rows, i|
        rows << @primes.inject([i]) { |r, j| r << @cache[[i, j]] }
      end
    end
  end
end
