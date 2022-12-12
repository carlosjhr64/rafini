module Rafini
  module Integer
    refine ::Integer do
      # odometer
      # Kinda hard to explain...
      #   123.odometer(10,10) #=> [3,2,1]
      #   30.odometer(2,3,5) #=> [0,0,0,1]
      #   ((60*60*24)*3 + (60*60)*12 + 60*15 + 30).odometer(60,60,24)
      #   #=> [30, 15, 12, 3]
      # Useful for making clocks, number scales, mayan long count... etc.
      def odometer(*levels, factors: true)
        raise RangeError, 'negative odometer' if self < 0
        readings, remainder = [], self

        levels = levels.inject([1]){|m, f| m.push(m.last*f)} if factors
        levels.shift

        levels.reverse_each do |level|
          # in case of a float, floor
          reading = (remainder/level).floor
          readings.unshift reading
          remainder = remainder%level
        end

        # in case of a float, round
        readings.unshift remainder.round
      end
    end
  end
end
