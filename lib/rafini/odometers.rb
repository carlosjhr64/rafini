module Rafini
  module Odometers
    refine ::Integer do
      # Need Rafini::Integer for #odometer
      # Need Rafini::Hash for #to_struct
      # Need Rafini::Array for #per
      [Rafini::Integer, Rafini::Hash, Rafini::Array].each{|mod| using mod}

      def odoread(scale)
        values = scale.values
        keys = scale.keys;
        counts = self.odometer(*values[0..-2])

        string = "#{counts[0]} #{keys[0]}#{(counts[0]==1)? '' : 's'}"
        (keys.length-1).downto(1) do |i|
          if counts[i] > 0
            string = "#{counts[i]} #{keys[i]}#{(counts[i]>1)? 's' : ''}"
            string << " and #{counts[i-1]} #{keys[i-1]}#{(counts[i-1]>1)? 's' : ''}" if counts[i-1]>0
            break
          end
        end

        hash = {}
        keys.per(counts){|k,v| hash[k]=v}
        hash[:to_s]=string

        return hash.to_struct
      end

      SEC2TIME = {
          second:     60,
          minute:     60,
          hour:       24,
          day:        7,
          week:       4,
          month:      13,
          year:       10,
          decade:     10,
          centurie:   10,
          millennium: 10,
          age:        10,
          epoch:      10,
          era:        5,
          eon:        2,
          gigaannum:  nil,
      }

      # Integer#sec2time
      # Returns a struct with the different time scales for number of seconds.
      # Note that the month(4 weeks)/year(13 months) are not meant to be exact.
      #   10_000.sec2time.to_s #=> "2 hours and 46 minutes"
      #   10_000.sec2time.hour #=> 2
      def sec2time
        self.odoread(SEC2TIME)
      end

      SCALE = {
        base: {
          ones:         10,
          tens:         10,
          hundreds:     10,
          thousands:    1_000,
        },
        short: {
          millions:     1_000,
          billions:     1_000,
          trillions:    1_000,
          quadrillions: nil,
        },
        long: {
          millions:     1_000_000,
          billions:     1_000_000,
          trillions:    1_000_000,
          quadrillions: nil,
        },
      }

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
        keys   = SCALE[:base].keys   + SCALE[type].keys
        values = SCALE[:base].values + SCALE[type].values
        counts = self.odometer(*values[0..-2])

        string = nil
        if self < 1_000
          string = self.to_s
        elsif self < 1_000_000
          d = (self<10_000)? 2 : (self<100_000)? 1 : 0
          m = (self/1000.0).round(d)
          string = "#{m}k"
        else
          (keys.length-1).downto(4) do |i|
            next unless counts[i]>0
            n = counts[i]
            if n < 1_000
              d = (n<10)? 2 : (n<100)? 1 : 0
              n = (n + counts[i-1]/values[i-1].to_f).round(d)
            else
              n = n.illion
            end
            string = "#{n}#{keys[i][0].upcase}"
            break
          end
        end

        hash = {}
        keys.per(counts){|k,v| hash[k]=v}
        hash[:to_s] = string

        return hash.to_struct
      end
    end
  end
end
