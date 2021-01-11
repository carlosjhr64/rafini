module Rafini
  module Integer
    refine ::Integer do
      # odometer
      # Kinda hard to explain...
      #   123.odometer(10,10) #=> [3,2,1]
      #   30.odometer(2,3,5) #=> [0,0,0,1]
      #   ((60*60*24)*3 + (60*60)*12 + 60*15 + 30).odometer(60,60,24) #=> [30, 15, 12, 3]
      # Useful for making clocks, number scales, mayan long count... etc.
      def odometer(*p)
        raise RangeError, 'negative odometer' if self < 0
        n, m, r  =  self, p.inject(1,:*), []

        p.reverse_each do |q|
          r.unshift n/m
          n, m  =  n%m, m/q
        end

        r.unshift n # remainder
      end
    end
  end
end
