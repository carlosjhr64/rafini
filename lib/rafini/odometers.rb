require 'rafini/integer'
require 'rafini/hash'

module Rafini
  module Odometers
    # Sidereal Year: https://en.wikipedia.org/wiki/Year
    year = 365*24*60*60 + 6*60*60 + 9*60 + 9.76
    SEC2TIME = { # levels
      second:     1,
      minute:     60,
      hour:       60*60,
      day:        24*60*60,
      week:       7*24*60*60,
      month:      year/12.0,
      year:       year,
      decade:     10*year,
      centurie:   100*year,
      millennium: 1_000*year,
      age:        10_000*year,
      epoch:      100_000*year,
      era:        1_000_000*year,
      eon:        5_000_000*year,
      gigaannum:  10_000_000*year,
    }

    SCALE = { # levels
      base: {
        one:         1,
        ten:         10,
        hundred:     100,
        thousand:    10**3,
        million:     10**6,
      },
      short: {
        billion:     10**9,
        trillion:    10**12,
        quadrillion: 10**15,
      },
      long: {
        billion:     10**12,
        trillion:    10**18,
        quadrillion: 10**24,
      },
    }

    refine ::Hash do
      def description
        string = ''
        reverse_each do |key, count|
          s = (count==1)? '' : 's'
          unless string.empty?
            string << " and #{count} #{key}#{s}" if count > 0
            break
          end
          next if count == 0
          string << "#{count} #{key}#{s}"
        end
        return string
      end
    end

    refine ::Integer do
      using Rafini::Integer # Need Rafini::Integer for #odometer
      using Rafini::Hash    # Need Rafini::Hash for #to_struct

      def odoread(scale, **kw, &blk)
        counts = odometer(*scale.values, **kw)
        ::Hash[scale.keys.zip(counts)].to_struct(&blk)
      end

      # Integer#sec2time
      # Returns a struct with the different time scales for number of seconds.
      #   10_000.sec2time.to_s #=> "2 hours and 46 minutes"
      #   10_000.sec2time.hour #=> 2
      def sec2time
        odoread(SEC2TIME, factors:false) do
          def to_s
            string = nil
            SEC2TIME.keys.reverse_each do |key|
              count=self[key]
              if string
                if count > 0
                  string << " and #{count} #{key}"
                  string << 's' if count > 1
                end
                break
              end
              next if count==0
              string = "#{count} #{key}"
              string << 's' if count > 1
            end
            string = "0 #{SEC2TIME.first[0]}s" unless string
            string
          end
          def to_i
            SEC2TIME.to_a.map{|k,v|v*self[k]}.sum.round
          end
        end
      end

      # 1_230.illion.to_s #=> "1.23k"
      # 1_230_000.illion.to_s #=> "1.23M"
      # ...etc
      # Does both short and long scales, short by default.
      # Returns a struct with the different scales of the number
      #   m = 888_777_666_555_444_321.illion
      #   m.ones #=> 1
      #   m.tens #=> 2
      #   m.hundreds #=> 3
      #   m.thousands #=> 444
      #   m.millions #=> 555
      #   m.billions #=> 666
      #   m.trillions #=> 777
      #   m.quadrillions #=> 888
      #   m.to_s #=> "888Q" It rounds up 888.7!
      def illion(type=:short)
        scale = SCALE[:base].merge SCALE[type]
        struct = odoread(scale, factors:false) do
          def scale=(scale)
            @scale=scale
          end
          def type=(type)
            @type=type
          end
          def to_s
            number = to_i
            return number.to_s if number < 1_000
            if number < 1_000_000
              precision = (number<10_000)? 2 : (number<100_000)? 1 : 0
              return "#{(number/1000.0).round(precision)}K"
            end
            keys = @scale.keys.reverse_each
            loop do
              key = keys.next
              n = self[key]
              next if n == 0
              if n < 1_000
                precision = (n<10)? 2 : (n<100)? 1 : 0
                scale = @scale[key].to_f
                f = (number/scale).round(precision)
                return "#{f}#{key[0].upcase}"
              end
              return "#{n.illion}#{key[0].upcase}"
            end
          end
          def to_i
            @scale.to_a.map{|k,v|v*self[k]}.sum
          end
        end
        struct.type  = type
        struct.scale = scale
        return struct
      end
    end
  end
end
