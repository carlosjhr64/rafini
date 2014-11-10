module Rafini
  module Odometers
    refine ::Integer do
      # Need Rafini::Integer for #odometer
      # Need Rafini::Hash for #to_struct
      # Need Rafini::Array for #per
      [Rafini::Integer, Rafini::Hash, Rafini::Array].each{|mod| using mod}

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

      def odometer_reader(scale)
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

      def sec2time
        self.odometer_reader(SEC2TIME)
      end

      SCALE = {
        base: {
          One:         10,
          Ten:         10,
          Hundred:     10,
        },
        short: {
          Thousand:    1_000,
          Million:     1_000,
          Billion:     1_000,
          Trillion:    1_000,
          Quadrillion: 1_000,
          bust:        1,
        },
        long: {
          Thousand:    1_000,
          Million:     1_000_000,
          Billion:     1_000_000,
          Trillion:    1_000_000,
          Quadrillion: 1_000_000,
          bust:        1,
        },
      }

      def scale(type=:short)
        keys   = SCALE[:base].keys   + SCALE[type].keys
        values = SCALE[:base].values + SCALE[type].values
        counts = self.odometer(*values)

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
              n = n.scale
            end
            string = "#{n}#{keys[i][0]}"
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
